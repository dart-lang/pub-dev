// This is a generated file (see the discoveryapis_generator project).

library googleapis.fitness.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client fitness/v1';

/**
 * Stores and accesses user data in the fitness store from apps on any platform.
 */
class FitnessApi {
  /** View your activity information in Google Fit */
  static const FitnessActivityReadScope = "https://www.googleapis.com/auth/fitness.activity.read";

  /** View and store your activity information in Google Fit */
  static const FitnessActivityWriteScope = "https://www.googleapis.com/auth/fitness.activity.write";

  /** View blood glucose data in Google Fit */
  static const FitnessBloodGlucoseReadScope = "https://www.googleapis.com/auth/fitness.blood_glucose.read";

  /** View and store blood glucose data in Google Fit */
  static const FitnessBloodGlucoseWriteScope = "https://www.googleapis.com/auth/fitness.blood_glucose.write";

  /** View blood pressure data in Google Fit */
  static const FitnessBloodPressureReadScope = "https://www.googleapis.com/auth/fitness.blood_pressure.read";

  /** View and store blood pressure data in Google Fit */
  static const FitnessBloodPressureWriteScope = "https://www.googleapis.com/auth/fitness.blood_pressure.write";

  /** View body sensor information in Google Fit */
  static const FitnessBodyReadScope = "https://www.googleapis.com/auth/fitness.body.read";

  /** View and store body sensor data in Google Fit */
  static const FitnessBodyWriteScope = "https://www.googleapis.com/auth/fitness.body.write";

  /** View body temperature data in Google Fit */
  static const FitnessBodyTemperatureReadScope = "https://www.googleapis.com/auth/fitness.body_temperature.read";

  /** View and store body temperature data in Google Fit */
  static const FitnessBodyTemperatureWriteScope = "https://www.googleapis.com/auth/fitness.body_temperature.write";

  /** View your stored location data in Google Fit */
  static const FitnessLocationReadScope = "https://www.googleapis.com/auth/fitness.location.read";

  /** View and store your location data in Google Fit */
  static const FitnessLocationWriteScope = "https://www.googleapis.com/auth/fitness.location.write";

  /** View nutrition information in Google Fit */
  static const FitnessNutritionReadScope = "https://www.googleapis.com/auth/fitness.nutrition.read";

  /** View and store nutrition information in Google Fit */
  static const FitnessNutritionWriteScope = "https://www.googleapis.com/auth/fitness.nutrition.write";

  /** View oxygen saturation data in Google Fit */
  static const FitnessOxygenSaturationReadScope = "https://www.googleapis.com/auth/fitness.oxygen_saturation.read";

  /** View and store oxygen saturation data in Google Fit */
  static const FitnessOxygenSaturationWriteScope = "https://www.googleapis.com/auth/fitness.oxygen_saturation.write";

  /** View reproductive health data in Google Fit */
  static const FitnessReproductiveHealthReadScope = "https://www.googleapis.com/auth/fitness.reproductive_health.read";

  /** View and store reproductive health data in Google Fit */
  static const FitnessReproductiveHealthWriteScope = "https://www.googleapis.com/auth/fitness.reproductive_health.write";


  final commons.ApiRequester _requester;

  UsersResourceApi get users => new UsersResourceApi(_requester);

  FitnessApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "fitness/v1/users/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class UsersResourceApi {
  final commons.ApiRequester _requester;

  UsersDataSourcesResourceApi get dataSources => new UsersDataSourcesResourceApi(_requester);
  UsersDatasetResourceApi get dataset => new UsersDatasetResourceApi(_requester);
  UsersSessionsResourceApi get sessions => new UsersSessionsResourceApi(_requester);

  UsersResourceApi(commons.ApiRequester client) : 
      _requester = client;
}


class UsersDataSourcesResourceApi {
  final commons.ApiRequester _requester;

  UsersDataSourcesDatasetsResourceApi get datasets => new UsersDataSourcesDatasetsResourceApi(_requester);

  UsersDataSourcesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates a new data source that is unique across all data sources belonging
   * to this user. The data stream ID field can be omitted and will be generated
   * by the server with the correct format. The data stream ID is an ordered
   * combination of some fields from the data source. In addition to the data
   * source fields reflected into the data source ID, the developer project
   * number that is authenticated when creating the data source is included.
   * This developer project number is obfuscated when read by any other
   * developer reading public data types.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [userId] - Create the data source for the person identified. Use me to
   * indicate the authenticated user. Only me is supported at this time.
   *
   * Completes with a [DataSource].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DataSource> create(DataSource request, core.String userId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$userId') + '/dataSources';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DataSource.fromJson(data));
  }

  /**
   * Deletes the specified data source. The request will fail if the data source
   * contains any data points.
   *
   * Request parameters:
   *
   * [userId] - Retrieve a data source for the person identified. Use me to
   * indicate the authenticated user. Only me is supported at this time.
   *
   * [dataSourceId] - The data stream ID of the data source to delete.
   *
   * Completes with a [DataSource].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DataSource> delete(core.String userId, core.String dataSourceId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }
    if (dataSourceId == null) {
      throw new core.ArgumentError("Parameter dataSourceId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$userId') + '/dataSources/' + commons.Escaper.ecapeVariable('$dataSourceId');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DataSource.fromJson(data));
  }

  /**
   * Returns the specified data source.
   *
   * Request parameters:
   *
   * [userId] - Retrieve a data source for the person identified. Use me to
   * indicate the authenticated user. Only me is supported at this time.
   *
   * [dataSourceId] - The data stream ID of the data source to retrieve.
   *
   * Completes with a [DataSource].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DataSource> get(core.String userId, core.String dataSourceId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }
    if (dataSourceId == null) {
      throw new core.ArgumentError("Parameter dataSourceId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$userId') + '/dataSources/' + commons.Escaper.ecapeVariable('$dataSourceId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DataSource.fromJson(data));
  }

  /**
   * Lists all data sources that are visible to the developer, using the OAuth
   * scopes provided. The list is not exhaustive; the user may have private data
   * sources that are only visible to other developers, or calls using other
   * scopes.
   *
   * Request parameters:
   *
   * [userId] - List data sources for the person identified. Use me to indicate
   * the authenticated user. Only me is supported at this time.
   *
   * [dataTypeName] - The names of data types to include in the list. If not
   * specified, all data sources will be returned.
   *
   * Completes with a [ListDataSourcesResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListDataSourcesResponse> list(core.String userId, {core.List<core.String> dataTypeName}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }
    if (dataTypeName != null) {
      _queryParams["dataTypeName"] = dataTypeName;
    }

    _url = commons.Escaper.ecapeVariable('$userId') + '/dataSources';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListDataSourcesResponse.fromJson(data));
  }

  /**
   * Updates the specified data source. The dataStreamId, dataType, type,
   * dataStreamName, and device properties with the exception of version, cannot
   * be modified.
   *
   * Data sources are identified by their dataStreamId. This method supports
   * patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [userId] - Update the data source for the person identified. Use me to
   * indicate the authenticated user. Only me is supported at this time.
   *
   * [dataSourceId] - The data stream ID of the data source to update.
   *
   * Completes with a [DataSource].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DataSource> patch(DataSource request, core.String userId, core.String dataSourceId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }
    if (dataSourceId == null) {
      throw new core.ArgumentError("Parameter dataSourceId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$userId') + '/dataSources/' + commons.Escaper.ecapeVariable('$dataSourceId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DataSource.fromJson(data));
  }

  /**
   * Updates the specified data source. The dataStreamId, dataType, type,
   * dataStreamName, and device properties with the exception of version, cannot
   * be modified.
   *
   * Data sources are identified by their dataStreamId.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [userId] - Update the data source for the person identified. Use me to
   * indicate the authenticated user. Only me is supported at this time.
   *
   * [dataSourceId] - The data stream ID of the data source to update.
   *
   * Completes with a [DataSource].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DataSource> update(DataSource request, core.String userId, core.String dataSourceId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }
    if (dataSourceId == null) {
      throw new core.ArgumentError("Parameter dataSourceId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$userId') + '/dataSources/' + commons.Escaper.ecapeVariable('$dataSourceId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DataSource.fromJson(data));
  }

}


class UsersDataSourcesDatasetsResourceApi {
  final commons.ApiRequester _requester;

  UsersDataSourcesDatasetsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Performs an inclusive delete of all data points whose start and end times
   * have any overlap with the time range specified by the dataset ID. For most
   * data types, the entire data point will be deleted. For data types where the
   * time span represents a consistent value (such as
   * com.google.activity.segment), and a data point straddles either end point
   * of the dataset, only the overlapping portion of the data point will be
   * deleted.
   *
   * Request parameters:
   *
   * [userId] - Delete a dataset for the person identified. Use me to indicate
   * the authenticated user. Only me is supported at this time.
   *
   * [dataSourceId] - The data stream ID of the data source that created the
   * dataset.
   *
   * [datasetId] - Dataset identifier that is a composite of the minimum data
   * point start time and maximum data point end time represented as nanoseconds
   * from the epoch. The ID is formatted like: "startTime-endTime" where
   * startTime and endTime are 64 bit integers.
   *
   * [currentTimeMillis] - The client's current time in milliseconds since
   * epoch.
   *
   * [modifiedTimeMillis] - When the operation was performed on the client.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String userId, core.String dataSourceId, core.String datasetId, {core.String currentTimeMillis, core.String modifiedTimeMillis}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }
    if (dataSourceId == null) {
      throw new core.ArgumentError("Parameter dataSourceId is required.");
    }
    if (datasetId == null) {
      throw new core.ArgumentError("Parameter datasetId is required.");
    }
    if (currentTimeMillis != null) {
      _queryParams["currentTimeMillis"] = [currentTimeMillis];
    }
    if (modifiedTimeMillis != null) {
      _queryParams["modifiedTimeMillis"] = [modifiedTimeMillis];
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$userId') + '/dataSources/' + commons.Escaper.ecapeVariable('$dataSourceId') + '/datasets/' + commons.Escaper.ecapeVariable('$datasetId');

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
   * Returns a dataset containing all data points whose start and end times
   * overlap with the specified range of the dataset minimum start time and
   * maximum end time. Specifically, any data point whose start time is less
   * than or equal to the dataset end time and whose end time is greater than or
   * equal to the dataset start time.
   *
   * Request parameters:
   *
   * [userId] - Retrieve a dataset for the person identified. Use me to indicate
   * the authenticated user. Only me is supported at this time.
   *
   * [dataSourceId] - The data stream ID of the data source that created the
   * dataset.
   *
   * [datasetId] - Dataset identifier that is a composite of the minimum data
   * point start time and maximum data point end time represented as nanoseconds
   * from the epoch. The ID is formatted like: "startTime-endTime" where
   * startTime and endTime are 64 bit integers.
   *
   * [limit] - If specified, no more than this many data points will be included
   * in the dataset. If there are more data points in the dataset, nextPageToken
   * will be set in the dataset response.
   *
   * [pageToken] - The continuation token, which is used to page through large
   * datasets. To get the next page of a dataset, set this parameter to the
   * value of nextPageToken from the previous response. Each subsequent call
   * will yield a partial dataset with data point end timestamps that are
   * strictly smaller than those in the previous partial response.
   *
   * Completes with a [Dataset].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Dataset> get(core.String userId, core.String dataSourceId, core.String datasetId, {core.int limit, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }
    if (dataSourceId == null) {
      throw new core.ArgumentError("Parameter dataSourceId is required.");
    }
    if (datasetId == null) {
      throw new core.ArgumentError("Parameter datasetId is required.");
    }
    if (limit != null) {
      _queryParams["limit"] = ["${limit}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = commons.Escaper.ecapeVariable('$userId') + '/dataSources/' + commons.Escaper.ecapeVariable('$dataSourceId') + '/datasets/' + commons.Escaper.ecapeVariable('$datasetId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Dataset.fromJson(data));
  }

  /**
   * Adds data points to a dataset. The dataset need not be previously created.
   * All points within the given dataset will be returned with subsquent calls
   * to retrieve this dataset. Data points can belong to more than one dataset.
   * This method does not use patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [userId] - Patch a dataset for the person identified. Use me to indicate
   * the authenticated user. Only me is supported at this time.
   *
   * [dataSourceId] - The data stream ID of the data source that created the
   * dataset.
   *
   * [datasetId] - Dataset identifier that is a composite of the minimum data
   * point start time and maximum data point end time represented as nanoseconds
   * from the epoch. The ID is formatted like: "startTime-endTime" where
   * startTime and endTime are 64 bit integers.
   *
   * [currentTimeMillis] - The client's current time in milliseconds since
   * epoch. Note that the minStartTimeNs and maxEndTimeNs properties in the
   * request body are in nanoseconds instead of milliseconds.
   *
   * Completes with a [Dataset].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Dataset> patch(Dataset request, core.String userId, core.String dataSourceId, core.String datasetId, {core.String currentTimeMillis}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }
    if (dataSourceId == null) {
      throw new core.ArgumentError("Parameter dataSourceId is required.");
    }
    if (datasetId == null) {
      throw new core.ArgumentError("Parameter datasetId is required.");
    }
    if (currentTimeMillis != null) {
      _queryParams["currentTimeMillis"] = [currentTimeMillis];
    }

    _url = commons.Escaper.ecapeVariable('$userId') + '/dataSources/' + commons.Escaper.ecapeVariable('$dataSourceId') + '/datasets/' + commons.Escaper.ecapeVariable('$datasetId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Dataset.fromJson(data));
  }

}


class UsersDatasetResourceApi {
  final commons.ApiRequester _requester;

  UsersDatasetResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Aggregates data of a certain type or stream into buckets divided by a given
   * type of boundary. Multiple data sets of multiple types and from multiple
   * sources can be aggreated into exactly one bucket type per request.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [userId] - Aggregate data for the person identified. Use me to indicate the
   * authenticated user. Only me is supported at this time.
   *
   * Completes with a [AggregateResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AggregateResponse> aggregate(AggregateRequest request, core.String userId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }

    _url = commons.Escaper.ecapeVariable('$userId') + '/dataset:aggregate';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AggregateResponse.fromJson(data));
  }

}


class UsersSessionsResourceApi {
  final commons.ApiRequester _requester;

  UsersSessionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes a session specified by the given session ID.
   *
   * Request parameters:
   *
   * [userId] - Delete a session for the person identified. Use me to indicate
   * the authenticated user. Only me is supported at this time.
   *
   * [sessionId] - The ID of the session to be deleted.
   *
   * [currentTimeMillis] - The client's current time in milliseconds since
   * epoch.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String userId, core.String sessionId, {core.String currentTimeMillis}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }
    if (sessionId == null) {
      throw new core.ArgumentError("Parameter sessionId is required.");
    }
    if (currentTimeMillis != null) {
      _queryParams["currentTimeMillis"] = [currentTimeMillis];
    }

    _downloadOptions = null;

    _url = commons.Escaper.ecapeVariable('$userId') + '/sessions/' + commons.Escaper.ecapeVariable('$sessionId');

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
   * Lists sessions previously created.
   *
   * Request parameters:
   *
   * [userId] - List sessions for the person identified. Use me to indicate the
   * authenticated user. Only me is supported at this time.
   *
   * [endTime] - An RFC3339 timestamp. Only sessions ending between the start
   * and end times will be included in the response.
   *
   * [includeDeleted] - If true, deleted sessions will be returned. When set to
   * true, sessions returned in this response will only have an ID and will not
   * have any other fields.
   *
   * [pageToken] - The continuation token, which is used to page through large
   * result sets. To get the next page of results, set this parameter to the
   * value of nextPageToken from the previous response.
   *
   * [startTime] - An RFC3339 timestamp. Only sessions ending between the start
   * and end times will be included in the response.
   *
   * Completes with a [ListSessionsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListSessionsResponse> list(core.String userId, {core.String endTime, core.bool includeDeleted, core.String pageToken, core.String startTime}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }
    if (endTime != null) {
      _queryParams["endTime"] = [endTime];
    }
    if (includeDeleted != null) {
      _queryParams["includeDeleted"] = ["${includeDeleted}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (startTime != null) {
      _queryParams["startTime"] = [startTime];
    }

    _url = commons.Escaper.ecapeVariable('$userId') + '/sessions';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListSessionsResponse.fromJson(data));
  }

  /**
   * Updates or insert a given session.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [userId] - Create sessions for the person identified. Use me to indicate
   * the authenticated user. Only me is supported at this time.
   *
   * [sessionId] - The ID of the session to be created.
   *
   * [currentTimeMillis] - The client's current time in milliseconds since
   * epoch.
   *
   * Completes with a [Session].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Session> update(Session request, core.String userId, core.String sessionId, {core.String currentTimeMillis}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }
    if (sessionId == null) {
      throw new core.ArgumentError("Parameter sessionId is required.");
    }
    if (currentTimeMillis != null) {
      _queryParams["currentTimeMillis"] = [currentTimeMillis];
    }

    _url = commons.Escaper.ecapeVariable('$userId') + '/sessions/' + commons.Escaper.ecapeVariable('$sessionId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Session.fromJson(data));
  }

}



class AggregateBucket {
  /** Available for Bucket.Type.ACTIVITY_TYPE, Bucket.Type.ACTIVITY_SEGMENT */
  core.int activity;
  /** There will be one dataset per AggregateBy in the request. */
  core.List<Dataset> dataset;
  /**
   * The end time for the aggregated data, in milliseconds since epoch,
   * inclusive.
   */
  core.String endTimeMillis;
  /** Available for Bucket.Type.SESSION */
  Session session;
  /**
   * The start time for the aggregated data, in milliseconds since epoch,
   * inclusive.
   */
  core.String startTimeMillis;
  /**
   * The type of a bucket signifies how the data aggregation is performed in the
   * bucket.
   * Possible string values are:
   * - "activitySegment"
   * - "activityType"
   * - "session"
   * - "time"
   * - "unknown"
   */
  core.String type;

  AggregateBucket();

  AggregateBucket.fromJson(core.Map _json) {
    if (_json.containsKey("activity")) {
      activity = _json["activity"];
    }
    if (_json.containsKey("dataset")) {
      dataset = _json["dataset"].map((value) => new Dataset.fromJson(value)).toList();
    }
    if (_json.containsKey("endTimeMillis")) {
      endTimeMillis = _json["endTimeMillis"];
    }
    if (_json.containsKey("session")) {
      session = new Session.fromJson(_json["session"]);
    }
    if (_json.containsKey("startTimeMillis")) {
      startTimeMillis = _json["startTimeMillis"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (activity != null) {
      _json["activity"] = activity;
    }
    if (dataset != null) {
      _json["dataset"] = dataset.map((value) => (value).toJson()).toList();
    }
    if (endTimeMillis != null) {
      _json["endTimeMillis"] = endTimeMillis;
    }
    if (session != null) {
      _json["session"] = (session).toJson();
    }
    if (startTimeMillis != null) {
      _json["startTimeMillis"] = startTimeMillis;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** The specification of which data to aggregate. */
class AggregateBy {
  /**
   * A data source ID to aggregate. Mutually exclusive of dataTypeName. Only
   * data from the specified data source ID will be included in the aggregation.
   * The dataset in the response will have the same data source ID.
   */
  core.String dataSourceId;
  /**
   * The data type to aggregate. All data sources providing this data type will
   * contribute data to the aggregation. The response will contain a single
   * dataset for this data type name. The dataset will have a data source ID of
   * derived:com.google.:com.google.android.gms:aggregated
   */
  core.String dataTypeName;

  AggregateBy();

  AggregateBy.fromJson(core.Map _json) {
    if (_json.containsKey("dataSourceId")) {
      dataSourceId = _json["dataSourceId"];
    }
    if (_json.containsKey("dataTypeName")) {
      dataTypeName = _json["dataTypeName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dataSourceId != null) {
      _json["dataSourceId"] = dataSourceId;
    }
    if (dataTypeName != null) {
      _json["dataTypeName"] = dataTypeName;
    }
    return _json;
  }
}

/** Next id: 10 */
class AggregateRequest {
  /**
   * The specification of data to be aggregated. At least one aggregateBy spec
   * must be provided. All data that is specified will be aggregated using the
   * same bucketing criteria. There will be one dataset in the response for
   * every aggregateBy spec.
   */
  core.List<AggregateBy> aggregateBy;
  /**
   * Specifies that data be aggregated each activity segment recored for a user.
   * Similar to bucketByActivitySegment, but bucketing is done for each activity
   * segment rather than all segments of the same type. Mutually exclusive of
   * other bucketing specifications.
   */
  BucketByActivity bucketByActivitySegment;
  /**
   * Specifies that data be aggregated by the type of activity being performed
   * when the data was recorded. All data that was recorded during a certain
   * activity type (for the given time range) will be aggregated into the same
   * bucket. Data that was recorded while the user was not active will not be
   * included in the response. Mutually exclusive of other bucketing
   * specifications.
   */
  BucketByActivity bucketByActivityType;
  /**
   * Specifies that data be aggregated by user sessions. Data that does not fall
   * within the time range of a session will not be included in the response.
   * Mutually exclusive of other bucketing specifications.
   */
  BucketBySession bucketBySession;
  /**
   * Specifies that data be aggregated by a single time interval. Mutually
   * exclusive of other bucketing specifications.
   */
  BucketByTime bucketByTime;
  /**
   * The end of a window of time. Data that intersects with this time window
   * will be aggregated. The time is in milliseconds since epoch, inclusive.
   */
  core.String endTimeMillis;
  /**
   * A list of acceptable data quality standards. Only data points which conform
   * to at least one of the specified data quality standards will be returned.
   * If the list is empty, all data points are returned.
   */
  core.List<core.String> filteredDataQualityStandard;
  /**
   * The start of a window of time. Data that intersects with this time window
   * will be aggregated. The time is in milliseconds since epoch, inclusive.
   */
  core.String startTimeMillis;

  AggregateRequest();

  AggregateRequest.fromJson(core.Map _json) {
    if (_json.containsKey("aggregateBy")) {
      aggregateBy = _json["aggregateBy"].map((value) => new AggregateBy.fromJson(value)).toList();
    }
    if (_json.containsKey("bucketByActivitySegment")) {
      bucketByActivitySegment = new BucketByActivity.fromJson(_json["bucketByActivitySegment"]);
    }
    if (_json.containsKey("bucketByActivityType")) {
      bucketByActivityType = new BucketByActivity.fromJson(_json["bucketByActivityType"]);
    }
    if (_json.containsKey("bucketBySession")) {
      bucketBySession = new BucketBySession.fromJson(_json["bucketBySession"]);
    }
    if (_json.containsKey("bucketByTime")) {
      bucketByTime = new BucketByTime.fromJson(_json["bucketByTime"]);
    }
    if (_json.containsKey("endTimeMillis")) {
      endTimeMillis = _json["endTimeMillis"];
    }
    if (_json.containsKey("filteredDataQualityStandard")) {
      filteredDataQualityStandard = _json["filteredDataQualityStandard"];
    }
    if (_json.containsKey("startTimeMillis")) {
      startTimeMillis = _json["startTimeMillis"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (aggregateBy != null) {
      _json["aggregateBy"] = aggregateBy.map((value) => (value).toJson()).toList();
    }
    if (bucketByActivitySegment != null) {
      _json["bucketByActivitySegment"] = (bucketByActivitySegment).toJson();
    }
    if (bucketByActivityType != null) {
      _json["bucketByActivityType"] = (bucketByActivityType).toJson();
    }
    if (bucketBySession != null) {
      _json["bucketBySession"] = (bucketBySession).toJson();
    }
    if (bucketByTime != null) {
      _json["bucketByTime"] = (bucketByTime).toJson();
    }
    if (endTimeMillis != null) {
      _json["endTimeMillis"] = endTimeMillis;
    }
    if (filteredDataQualityStandard != null) {
      _json["filteredDataQualityStandard"] = filteredDataQualityStandard;
    }
    if (startTimeMillis != null) {
      _json["startTimeMillis"] = startTimeMillis;
    }
    return _json;
  }
}

class AggregateResponse {
  /** A list of buckets containing the aggregated data. */
  core.List<AggregateBucket> bucket;

  AggregateResponse();

  AggregateResponse.fromJson(core.Map _json) {
    if (_json.containsKey("bucket")) {
      bucket = _json["bucket"].map((value) => new AggregateBucket.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (bucket != null) {
      _json["bucket"] = bucket.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class Application {
  /** An optional URI that can be used to link back to the application. */
  core.String detailsUrl;
  /**
   * The name of this application. This is required for REST clients, but we do
   * not enforce uniqueness of this name. It is provided as a matter of
   * convenience for other developers who would like to identify which REST
   * created an Application or Data Source.
   */
  core.String name;
  /**
   * Package name for this application. This is used as a unique identifier when
   * created by Android applications, but cannot be specified by REST clients.
   * REST clients will have their developer project number reflected into the
   * Data Source data stream IDs, instead of the packageName.
   */
  core.String packageName;
  /**
   * Version of the application. You should update this field whenever the
   * application changes in a way that affects the computation of the data.
   */
  core.String version;

  Application();

  Application.fromJson(core.Map _json) {
    if (_json.containsKey("detailsUrl")) {
      detailsUrl = _json["detailsUrl"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("packageName")) {
      packageName = _json["packageName"];
    }
    if (_json.containsKey("version")) {
      version = _json["version"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (detailsUrl != null) {
      _json["detailsUrl"] = detailsUrl;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (packageName != null) {
      _json["packageName"] = packageName;
    }
    if (version != null) {
      _json["version"] = version;
    }
    return _json;
  }
}

class BucketByActivity {
  /**
   * The default activity stream will be used if a specific activityDataSourceId
   * is not specified.
   */
  core.String activityDataSourceId;
  /**
   * Specifies that only activity segments of duration longer than
   * minDurationMillis are considered and used as a container for aggregated
   * data.
   */
  core.String minDurationMillis;

  BucketByActivity();

  BucketByActivity.fromJson(core.Map _json) {
    if (_json.containsKey("activityDataSourceId")) {
      activityDataSourceId = _json["activityDataSourceId"];
    }
    if (_json.containsKey("minDurationMillis")) {
      minDurationMillis = _json["minDurationMillis"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (activityDataSourceId != null) {
      _json["activityDataSourceId"] = activityDataSourceId;
    }
    if (minDurationMillis != null) {
      _json["minDurationMillis"] = minDurationMillis;
    }
    return _json;
  }
}

class BucketBySession {
  /**
   * Specifies that only sessions of duration longer than minDurationMillis are
   * considered and used as a container for aggregated data.
   */
  core.String minDurationMillis;

  BucketBySession();

  BucketBySession.fromJson(core.Map _json) {
    if (_json.containsKey("minDurationMillis")) {
      minDurationMillis = _json["minDurationMillis"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (minDurationMillis != null) {
      _json["minDurationMillis"] = minDurationMillis;
    }
    return _json;
  }
}

class BucketByTime {
  /**
   * Specifies that result buckets aggregate data by exactly durationMillis time
   * frames. Time frames that contain no data will be included in the response
   * with an empty dataset.
   */
  core.String durationMillis;
  BucketByTimePeriod period;

  BucketByTime();

  BucketByTime.fromJson(core.Map _json) {
    if (_json.containsKey("durationMillis")) {
      durationMillis = _json["durationMillis"];
    }
    if (_json.containsKey("period")) {
      period = new BucketByTimePeriod.fromJson(_json["period"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (durationMillis != null) {
      _json["durationMillis"] = durationMillis;
    }
    if (period != null) {
      _json["period"] = (period).toJson();
    }
    return _json;
  }
}

class BucketByTimePeriod {
  /** org.joda.timezone.DateTimeZone */
  core.String timeZoneId;
  /**
   *
   * Possible string values are:
   * - "day"
   * - "month"
   * - "week"
   */
  core.String type;
  core.int value;

  BucketByTimePeriod();

  BucketByTimePeriod.fromJson(core.Map _json) {
    if (_json.containsKey("timeZoneId")) {
      timeZoneId = _json["timeZoneId"];
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
    if (timeZoneId != null) {
      _json["timeZoneId"] = timeZoneId;
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

/**
 * Represents a single data point, generated by a particular data source. A data
 * point holds a value for each field, an end timestamp and an optional start
 * time. The exact semantics of each of these attributes are specified in the
 * documentation for the particular data type.
 *
 * A data point can represent an instantaneous measurement, reading or input
 * observation, as well as averages or aggregates over a time interval. Check
 * the data type documentation to determine which is the case for a particular
 * data type.
 *
 * Data points always contain one value for each field of the data type.
 */
class DataPoint {
  /**
   * Used for version checking during transformation; that is, a datapoint can
   * only replace another datapoint that has an older computation time stamp.
   */
  core.String computationTimeMillis;
  /** The data type defining the format of the values in this data point. */
  core.String dataTypeName;
  /**
   * The end time of the interval represented by this data point, in nanoseconds
   * since epoch.
   */
  core.String endTimeNanos;
  /**
   * Indicates the last time this data point was modified. Useful only in
   * contexts where we are listing the data changes, rather than representing
   * the current state of the data.
   */
  core.String modifiedTimeMillis;
  /**
   * If the data point is contained in a dataset for a derived data source, this
   * field will be populated with the data source stream ID that created the
   * data point originally.
   */
  core.String originDataSourceId;
  /** The raw timestamp from the original SensorEvent. */
  core.String rawTimestampNanos;
  /**
   * The start time of the interval represented by this data point, in
   * nanoseconds since epoch.
   */
  core.String startTimeNanos;
  /**
   * Values of each data type field for the data point. It is expected that each
   * value corresponding to a data type field will occur in the same order that
   * the field is listed with in the data type specified in a data source.
   *
   * Only one of integer and floating point fields will be populated, depending
   * on the format enum value within data source's type field.
   */
  core.List<Value> value;

  DataPoint();

  DataPoint.fromJson(core.Map _json) {
    if (_json.containsKey("computationTimeMillis")) {
      computationTimeMillis = _json["computationTimeMillis"];
    }
    if (_json.containsKey("dataTypeName")) {
      dataTypeName = _json["dataTypeName"];
    }
    if (_json.containsKey("endTimeNanos")) {
      endTimeNanos = _json["endTimeNanos"];
    }
    if (_json.containsKey("modifiedTimeMillis")) {
      modifiedTimeMillis = _json["modifiedTimeMillis"];
    }
    if (_json.containsKey("originDataSourceId")) {
      originDataSourceId = _json["originDataSourceId"];
    }
    if (_json.containsKey("rawTimestampNanos")) {
      rawTimestampNanos = _json["rawTimestampNanos"];
    }
    if (_json.containsKey("startTimeNanos")) {
      startTimeNanos = _json["startTimeNanos"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"].map((value) => new Value.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (computationTimeMillis != null) {
      _json["computationTimeMillis"] = computationTimeMillis;
    }
    if (dataTypeName != null) {
      _json["dataTypeName"] = dataTypeName;
    }
    if (endTimeNanos != null) {
      _json["endTimeNanos"] = endTimeNanos;
    }
    if (modifiedTimeMillis != null) {
      _json["modifiedTimeMillis"] = modifiedTimeMillis;
    }
    if (originDataSourceId != null) {
      _json["originDataSourceId"] = originDataSourceId;
    }
    if (rawTimestampNanos != null) {
      _json["rawTimestampNanos"] = rawTimestampNanos;
    }
    if (startTimeNanos != null) {
      _json["startTimeNanos"] = startTimeNanos;
    }
    if (value != null) {
      _json["value"] = value.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Definition of a unique source of sensor data. Data sources can expose raw
 * data coming from hardware sensors on local or companion devices. They can
 * also expose derived data, created by transforming or merging other data
 * sources. Multiple data sources can exist for the same data type. Every data
 * point inserted into or read from this service has an associated data source.
 *
 * The data source contains enough information to uniquely identify its data,
 * including the hardware device and the application that collected and/or
 * transformed the data. It also holds useful metadata, such as the hardware and
 * application versions, and the device type.
 *
 * Each data source produces a unique stream of data, with a unique identifier.
 * Not all changes to data source affect the stream identifier, so that data
 * collected by updated versions of the same application/device can still be
 * considered to belong to the same data stream.
 */
class DataSource {
  /**
   * Information about an application which feeds sensor data into the platform.
   */
  Application application;
  core.List<core.String> dataQualityStandard;
  /**
   * A unique identifier for the data stream produced by this data source. The
   * identifier includes:
   *
   *
   * - The physical device's manufacturer, model, and serial number (UID).
   * - The application's package name or name. Package name is used when the
   * data source was created by an Android application. The developer project
   * number is used when the data source was created by a REST client.
   * - The data source's type.
   * - The data source's stream name.  Note that not all attributes of the data
   * source are used as part of the stream identifier. In particular, the
   * version of the hardware/the application isn't used. This allows us to
   * preserve the same stream through version updates. This also means that two
   * DataSource objects may represent the same data stream even if they're not
   * equal.
   *
   * The exact format of the data stream ID created by an Android application
   * is:
   * type:dataType.name:application.packageName:device.manufacturer:device.model:device.uid:dataStreamName
   *
   * The exact format of the data stream ID created by a REST client is:
   * type:dataType.name:developer project
   * number:device.manufacturer:device.model:device.uid:dataStreamName
   *
   * When any of the optional fields that comprise of the data stream ID are
   * blank, they will be omitted from the data stream ID. The minnimum viable
   * data stream ID would be: type:dataType.name:developer project number
   *
   * Finally, the developer project number is obfuscated when read by any REST
   * or Android client that did not create the data source. Only the data source
   * creator will see the developer project number in clear and normal form.
   */
  core.String dataStreamId;
  /**
   * The stream name uniquely identifies this particular data source among other
   * data sources of the same type from the same underlying producer. Setting
   * the stream name is optional, but should be done whenever an application
   * exposes two streams for the same data type, or when a device has two
   * equivalent sensors.
   */
  core.String dataStreamName;
  /**
   * The data type defines the schema for a stream of data being collected by,
   * inserted into, or queried from the Fitness API.
   */
  DataType dataType;
  /**
   * Representation of an integrated device (such as a phone or a wearable) that
   * can hold sensors.
   */
  Device device;
  /** An end-user visible name for this data source. */
  core.String name;
  /**
   * A constant describing the type of this data source. Indicates whether this
   * data source produces raw or derived data.
   * Possible string values are:
   * - "derived"
   * - "raw"
   */
  core.String type;

  DataSource();

  DataSource.fromJson(core.Map _json) {
    if (_json.containsKey("application")) {
      application = new Application.fromJson(_json["application"]);
    }
    if (_json.containsKey("dataQualityStandard")) {
      dataQualityStandard = _json["dataQualityStandard"];
    }
    if (_json.containsKey("dataStreamId")) {
      dataStreamId = _json["dataStreamId"];
    }
    if (_json.containsKey("dataStreamName")) {
      dataStreamName = _json["dataStreamName"];
    }
    if (_json.containsKey("dataType")) {
      dataType = new DataType.fromJson(_json["dataType"]);
    }
    if (_json.containsKey("device")) {
      device = new Device.fromJson(_json["device"]);
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (application != null) {
      _json["application"] = (application).toJson();
    }
    if (dataQualityStandard != null) {
      _json["dataQualityStandard"] = dataQualityStandard;
    }
    if (dataStreamId != null) {
      _json["dataStreamId"] = dataStreamId;
    }
    if (dataStreamName != null) {
      _json["dataStreamName"] = dataStreamName;
    }
    if (dataType != null) {
      _json["dataType"] = (dataType).toJson();
    }
    if (device != null) {
      _json["device"] = (device).toJson();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class DataType {
  /** A field represents one dimension of a data type. */
  core.List<DataTypeField> field;
  /**
   * Each data type has a unique, namespaced, name. All data types in the
   * com.google namespace are shared as part of the platform.
   */
  core.String name;

  DataType();

  DataType.fromJson(core.Map _json) {
    if (_json.containsKey("field")) {
      field = _json["field"].map((value) => new DataTypeField.fromJson(value)).toList();
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (field != null) {
      _json["field"] = field.map((value) => (value).toJson()).toList();
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/**
 * In case of multi-dimensional data (such as an accelerometer with x, y, and z
 * axes) each field represents one dimension. Each data type field has a unique
 * name which identifies it. The field also defines the format of the data (int,
 * float, etc.).
 *
 * This message is only instantiated in code and not used for wire comms or
 * stored in any way.
 */
class DataTypeField {
  /**
   * The different supported formats for each field in a data type.
   * Possible string values are:
   * - "blob"
   * - "floatList"
   * - "floatPoint"
   * - "integer"
   * - "integerList"
   * - "map"
   * - "string"
   */
  core.String format;
  /**
   * Defines the name and format of data. Unlike data type names, field names
   * are not namespaced, and only need to be unique within the data type.
   */
  core.String name;
  core.bool optional;

  DataTypeField();

  DataTypeField.fromJson(core.Map _json) {
    if (_json.containsKey("format")) {
      format = _json["format"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("optional")) {
      optional = _json["optional"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (format != null) {
      _json["format"] = format;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (optional != null) {
      _json["optional"] = optional;
    }
    return _json;
  }
}

/**
 * A dataset represents a projection container for data points. They do not
 * carry any info of their own. Datasets represent a set of data points from a
 * particular data source. A data point can be found in more than one dataset.
 */
class Dataset {
  /**
   * The data stream ID of the data source that created the points in this
   * dataset.
   */
  core.String dataSourceId;
  /**
   * The largest end time of all data points in this possibly partial
   * representation of the dataset. Time is in nanoseconds from epoch. This
   * should also match the first part of the dataset identifier.
   */
  core.String maxEndTimeNs;
  /**
   * The smallest start time of all data points in this possibly partial
   * representation of the dataset. Time is in nanoseconds from epoch. This
   * should also match the first part of the dataset identifier.
   */
  core.String minStartTimeNs;
  /**
   * This token will be set when a dataset is received in response to a GET
   * request and the dataset is too large to be included in a single response.
   * Provide this value in a subsequent GET request to return the next page of
   * data points within this dataset.
   */
  core.String nextPageToken;
  /**
   * A partial list of data points contained in the dataset, ordered by largest
   * endTimeNanos first. This list is considered complete when retrieving a
   * small dataset and partial when patching a dataset or retrieving a dataset
   * that is too large to include in a single response.
   */
  core.List<DataPoint> point;

  Dataset();

  Dataset.fromJson(core.Map _json) {
    if (_json.containsKey("dataSourceId")) {
      dataSourceId = _json["dataSourceId"];
    }
    if (_json.containsKey("maxEndTimeNs")) {
      maxEndTimeNs = _json["maxEndTimeNs"];
    }
    if (_json.containsKey("minStartTimeNs")) {
      minStartTimeNs = _json["minStartTimeNs"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("point")) {
      point = _json["point"].map((value) => new DataPoint.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dataSourceId != null) {
      _json["dataSourceId"] = dataSourceId;
    }
    if (maxEndTimeNs != null) {
      _json["maxEndTimeNs"] = maxEndTimeNs;
    }
    if (minStartTimeNs != null) {
      _json["minStartTimeNs"] = minStartTimeNs;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (point != null) {
      _json["point"] = point.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Representation of an integrated device (such as a phone or a wearable) that
 * can hold sensors. Each sensor is exposed as a data source.
 *
 * The main purpose of the device information contained in this class is to
 * identify the hardware of a particular data source. This can be useful in
 * different ways, including:
 * - Distinguishing two similar sensors on different devices (the step counter
 * on two nexus 5 phones, for instance)
 * - Display the source of data to the user (by using the device make / model)
 * - Treat data differently depending on sensor type (accelerometers on a watch
 * may give different patterns than those on a phone)
 * - Build different analysis models for each device/version.
 */
class Device {
  /** Manufacturer of the product/hardware. */
  core.String manufacturer;
  /** End-user visible model name for the device. */
  core.String model;
  /**
   * A constant representing the type of the device.
   * Possible string values are:
   * - "chestStrap"
   * - "headMounted"
   * - "phone"
   * - "scale"
   * - "tablet"
   * - "unknown"
   * - "watch"
   */
  core.String type;
  /**
   * The serial number or other unique ID for the hardware. This field is
   * obfuscated when read by any REST or Android client that did not create the
   * data source. Only the data source creator will see the uid field in clear
   * and normal form.
   */
  core.String uid;
  /** Version string for the device hardware/software. */
  core.String version;

  Device();

  Device.fromJson(core.Map _json) {
    if (_json.containsKey("manufacturer")) {
      manufacturer = _json["manufacturer"];
    }
    if (_json.containsKey("model")) {
      model = _json["model"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("uid")) {
      uid = _json["uid"];
    }
    if (_json.containsKey("version")) {
      version = _json["version"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (manufacturer != null) {
      _json["manufacturer"] = manufacturer;
    }
    if (model != null) {
      _json["model"] = model;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (uid != null) {
      _json["uid"] = uid;
    }
    if (version != null) {
      _json["version"] = version;
    }
    return _json;
  }
}

class ListDataSourcesResponse {
  /** A previously created data source. */
  core.List<DataSource> dataSource;

  ListDataSourcesResponse();

  ListDataSourcesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("dataSource")) {
      dataSource = _json["dataSource"].map((value) => new DataSource.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (dataSource != null) {
      _json["dataSource"] = dataSource.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class ListSessionsResponse {
  /**
   * If includeDeleted is set to true in the request, this list will contain
   * sessions deleted with original end times that are within the startTime and
   * endTime frame.
   */
  core.List<Session> deletedSession;
  /** Flag to indicate server has more data to transfer */
  core.bool hasMoreData;
  /**
   * The continuation token, which is used to page through large result sets.
   * Provide this value in a subsequent request to return the next page of
   * results.
   */
  core.String nextPageToken;
  /**
   * Sessions with an end time that is between startTime and endTime of the
   * request.
   */
  core.List<Session> session;

  ListSessionsResponse();

  ListSessionsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("deletedSession")) {
      deletedSession = _json["deletedSession"].map((value) => new Session.fromJson(value)).toList();
    }
    if (_json.containsKey("hasMoreData")) {
      hasMoreData = _json["hasMoreData"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("session")) {
      session = _json["session"].map((value) => new Session.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deletedSession != null) {
      _json["deletedSession"] = deletedSession.map((value) => (value).toJson()).toList();
    }
    if (hasMoreData != null) {
      _json["hasMoreData"] = hasMoreData;
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (session != null) {
      _json["session"] = session.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Holder object for the value of an entry in a map field of a data point.
 *
 * A map value supports a subset of the formats that the regular Value supports.
 */
class MapValue {
  /** Floating point value. */
  core.double fpVal;

  MapValue();

  MapValue.fromJson(core.Map _json) {
    if (_json.containsKey("fpVal")) {
      fpVal = _json["fpVal"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (fpVal != null) {
      _json["fpVal"] = fpVal;
    }
    return _json;
  }
}

/**
 * Sessions contain metadata, such as a user-friendly name and time interval
 * information.
 */
class Session {
  /**
   * Session active time. While start_time_millis and end_time_millis define the
   * full session time, the active time can be shorter and specified by
   * active_time_millis. If the inactive time during the session is known, it
   * should also be inserted via a com.google.activity.segment data point with a
   * STILL activity value
   */
  core.String activeTimeMillis;
  /** The type of activity this session represents. */
  core.int activityType;
  /** The application that created the session. */
  Application application;
  /** A description for this session. */
  core.String description;
  /** An end time, in milliseconds since epoch, inclusive. */
  core.String endTimeMillis;
  /**
   * A client-generated identifier that is unique across all sessions owned by
   * this particular user.
   */
  core.String id;
  /** A timestamp that indicates when the session was last modified. */
  core.String modifiedTimeMillis;
  /** A human readable name of the session. */
  core.String name;
  /** A start time, in milliseconds since epoch, inclusive. */
  core.String startTimeMillis;

  Session();

  Session.fromJson(core.Map _json) {
    if (_json.containsKey("activeTimeMillis")) {
      activeTimeMillis = _json["activeTimeMillis"];
    }
    if (_json.containsKey("activityType")) {
      activityType = _json["activityType"];
    }
    if (_json.containsKey("application")) {
      application = new Application.fromJson(_json["application"]);
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("endTimeMillis")) {
      endTimeMillis = _json["endTimeMillis"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("modifiedTimeMillis")) {
      modifiedTimeMillis = _json["modifiedTimeMillis"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("startTimeMillis")) {
      startTimeMillis = _json["startTimeMillis"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (activeTimeMillis != null) {
      _json["activeTimeMillis"] = activeTimeMillis;
    }
    if (activityType != null) {
      _json["activityType"] = activityType;
    }
    if (application != null) {
      _json["application"] = (application).toJson();
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (endTimeMillis != null) {
      _json["endTimeMillis"] = endTimeMillis;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (modifiedTimeMillis != null) {
      _json["modifiedTimeMillis"] = modifiedTimeMillis;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (startTimeMillis != null) {
      _json["startTimeMillis"] = startTimeMillis;
    }
    return _json;
  }
}

/**
 * Holder object for the value of a single field in a data point.
 *
 * A field value has a particular format and is only ever set to one of an
 * integer or a floating point value. LINT.IfChange
 */
class Value {
  /** Floating point value. When this is set, other values must not be set. */
  core.double fpVal;
  /** Integer value. When this is set, other values must not be set. */
  core.int intVal;
  /**
   * Map value. The valid key space and units for the corresponding value of
   * each entry should be documented as part of the data type definition. Keys
   * should be kept small whenever possible. Data streams with large keys and
   * high data frequency may be down sampled.
   */
  core.List<ValueMapValEntry> mapVal;
  /**
   * String value. When this is set, other values must not be set. Strings
   * should be kept small whenever possible. Data streams with large string
   * values and high data frequency may be down sampled.
   */
  core.String stringVal;

  Value();

  Value.fromJson(core.Map _json) {
    if (_json.containsKey("fpVal")) {
      fpVal = _json["fpVal"];
    }
    if (_json.containsKey("intVal")) {
      intVal = _json["intVal"];
    }
    if (_json.containsKey("mapVal")) {
      mapVal = _json["mapVal"].map((value) => new ValueMapValEntry.fromJson(value)).toList();
    }
    if (_json.containsKey("stringVal")) {
      stringVal = _json["stringVal"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (fpVal != null) {
      _json["fpVal"] = fpVal;
    }
    if (intVal != null) {
      _json["intVal"] = intVal;
    }
    if (mapVal != null) {
      _json["mapVal"] = mapVal.map((value) => (value).toJson()).toList();
    }
    if (stringVal != null) {
      _json["stringVal"] = stringVal;
    }
    return _json;
  }
}

class ValueMapValEntry {
  core.String key;
  MapValue value;

  ValueMapValEntry();

  ValueMapValEntry.fromJson(core.Map _json) {
    if (_json.containsKey("key")) {
      key = _json["key"];
    }
    if (_json.containsKey("value")) {
      value = new MapValue.fromJson(_json["value"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (key != null) {
      _json["key"] = key;
    }
    if (value != null) {
      _json["value"] = (value).toJson();
    }
    return _json;
  }
}
