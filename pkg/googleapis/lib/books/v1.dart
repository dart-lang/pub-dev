// This is a generated file (see the discoveryapis_generator project).

library googleapis.books.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client books/v1';

/** Searches for books and manages your Google Books library. */
class BooksApi {
  /** Manage your books */
  static const BooksScope = "https://www.googleapis.com/auth/books";


  final commons.ApiRequester _requester;

  BookshelvesResourceApi get bookshelves => new BookshelvesResourceApi(_requester);
  CloudloadingResourceApi get cloudloading => new CloudloadingResourceApi(_requester);
  DictionaryResourceApi get dictionary => new DictionaryResourceApi(_requester);
  LayersResourceApi get layers => new LayersResourceApi(_requester);
  MyconfigResourceApi get myconfig => new MyconfigResourceApi(_requester);
  MylibraryResourceApi get mylibrary => new MylibraryResourceApi(_requester);
  NotificationResourceApi get notification => new NotificationResourceApi(_requester);
  OnboardingResourceApi get onboarding => new OnboardingResourceApi(_requester);
  PersonalizedstreamResourceApi get personalizedstream => new PersonalizedstreamResourceApi(_requester);
  PromoofferResourceApi get promooffer => new PromoofferResourceApi(_requester);
  SeriesResourceApi get series => new SeriesResourceApi(_requester);
  VolumesResourceApi get volumes => new VolumesResourceApi(_requester);

  BooksApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "books/v1/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class BookshelvesResourceApi {
  final commons.ApiRequester _requester;

  BookshelvesVolumesResourceApi get volumes => new BookshelvesVolumesResourceApi(_requester);

  BookshelvesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves metadata for a specific bookshelf for the specified user.
   *
   * Request parameters:
   *
   * [userId] - ID of user for whom to retrieve bookshelves.
   *
   * [shelf] - ID of bookshelf to retrieve.
   *
   * [source] - String to identify the originator of this request.
   *
   * Completes with a [Bookshelf].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Bookshelf> get(core.String userId, core.String shelf, {core.String source}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }
    if (shelf == null) {
      throw new core.ArgumentError("Parameter shelf is required.");
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }

    _url = 'users/' + commons.Escaper.ecapeVariable('$userId') + '/bookshelves/' + commons.Escaper.ecapeVariable('$shelf');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Bookshelf.fromJson(data));
  }

  /**
   * Retrieves a list of public bookshelves for the specified user.
   *
   * Request parameters:
   *
   * [userId] - ID of user for whom to retrieve bookshelves.
   *
   * [source] - String to identify the originator of this request.
   *
   * Completes with a [Bookshelves].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Bookshelves> list(core.String userId, {core.String source}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }

    _url = 'users/' + commons.Escaper.ecapeVariable('$userId') + '/bookshelves';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Bookshelves.fromJson(data));
  }

}


class BookshelvesVolumesResourceApi {
  final commons.ApiRequester _requester;

  BookshelvesVolumesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves volumes in a specific bookshelf for the specified user.
   *
   * Request parameters:
   *
   * [userId] - ID of user for whom to retrieve bookshelf volumes.
   *
   * [shelf] - ID of bookshelf to retrieve volumes.
   *
   * [maxResults] - Maximum number of results to return
   *
   * [showPreorders] - Set to true to show pre-ordered books. Defaults to false.
   *
   * [source] - String to identify the originator of this request.
   *
   * [startIndex] - Index of the first element to return (starts at 0)
   *
   * Completes with a [Volumes].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Volumes> list(core.String userId, core.String shelf, {core.int maxResults, core.bool showPreorders, core.String source, core.int startIndex}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (userId == null) {
      throw new core.ArgumentError("Parameter userId is required.");
    }
    if (shelf == null) {
      throw new core.ArgumentError("Parameter shelf is required.");
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (showPreorders != null) {
      _queryParams["showPreorders"] = ["${showPreorders}"];
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }
    if (startIndex != null) {
      _queryParams["startIndex"] = ["${startIndex}"];
    }

    _url = 'users/' + commons.Escaper.ecapeVariable('$userId') + '/bookshelves/' + commons.Escaper.ecapeVariable('$shelf') + '/volumes';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Volumes.fromJson(data));
  }

}


class CloudloadingResourceApi {
  final commons.ApiRequester _requester;

  CloudloadingResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Request parameters:
   *
   * [driveDocumentId] - A drive document id. The upload_client_token must not
   * be set.
   *
   * [mimeType] - The document MIME type. It can be set only if the
   * drive_document_id is set.
   *
   * [name] - The document name. It can be set only if the drive_document_id is
   * set.
   *
   * [uploadClientToken] - null
   *
   * Completes with a [BooksCloudloadingResource].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<BooksCloudloadingResource> addBook({core.String driveDocumentId, core.String mimeType, core.String name, core.String uploadClientToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (driveDocumentId != null) {
      _queryParams["drive_document_id"] = [driveDocumentId];
    }
    if (mimeType != null) {
      _queryParams["mime_type"] = [mimeType];
    }
    if (name != null) {
      _queryParams["name"] = [name];
    }
    if (uploadClientToken != null) {
      _queryParams["upload_client_token"] = [uploadClientToken];
    }

    _url = 'cloudloading/addBook';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new BooksCloudloadingResource.fromJson(data));
  }

  /**
   * Remove the book and its contents
   *
   * Request parameters:
   *
   * [volumeId] - The id of the book to be removed.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future deleteBook(core.String volumeId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (volumeId == null) {
      throw new core.ArgumentError("Parameter volumeId is required.");
    }
    _queryParams["volumeId"] = [volumeId];

    _downloadOptions = null;

    _url = 'cloudloading/deleteBook';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [BooksCloudloadingResource].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<BooksCloudloadingResource> updateBook(BooksCloudloadingResource request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'cloudloading/updateBook';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new BooksCloudloadingResource.fromJson(data));
  }

}


class DictionaryResourceApi {
  final commons.ApiRequester _requester;

  DictionaryResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns a list of offline dictionary metadata available
   *
   * Request parameters:
   *
   * [cpksver] - The device/version ID from which to request the data.
   *
   * Completes with a [Metadata].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Metadata> listOfflineMetadata(core.String cpksver) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (cpksver == null) {
      throw new core.ArgumentError("Parameter cpksver is required.");
    }
    _queryParams["cpksver"] = [cpksver];

    _url = 'dictionary/listOfflineMetadata';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Metadata.fromJson(data));
  }

}


class LayersResourceApi {
  final commons.ApiRequester _requester;

  LayersAnnotationDataResourceApi get annotationData => new LayersAnnotationDataResourceApi(_requester);
  LayersVolumeAnnotationsResourceApi get volumeAnnotations => new LayersVolumeAnnotationsResourceApi(_requester);

  LayersResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets the layer summary for a volume.
   *
   * Request parameters:
   *
   * [volumeId] - The volume to retrieve layers for.
   *
   * [summaryId] - The ID for the layer to get the summary for.
   *
   * [contentVersion] - The content version for the requested volume.
   *
   * [source] - String to identify the originator of this request.
   *
   * Completes with a [Layersummary].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Layersummary> get(core.String volumeId, core.String summaryId, {core.String contentVersion, core.String source}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (volumeId == null) {
      throw new core.ArgumentError("Parameter volumeId is required.");
    }
    if (summaryId == null) {
      throw new core.ArgumentError("Parameter summaryId is required.");
    }
    if (contentVersion != null) {
      _queryParams["contentVersion"] = [contentVersion];
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }

    _url = 'volumes/' + commons.Escaper.ecapeVariable('$volumeId') + '/layersummary/' + commons.Escaper.ecapeVariable('$summaryId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Layersummary.fromJson(data));
  }

  /**
   * List the layer summaries for a volume.
   *
   * Request parameters:
   *
   * [volumeId] - The volume to retrieve layers for.
   *
   * [contentVersion] - The content version for the requested volume.
   *
   * [maxResults] - Maximum number of results to return
   * Value must be between "0" and "200".
   *
   * [pageToken] - The value of the nextToken from the previous page.
   *
   * [source] - String to identify the originator of this request.
   *
   * Completes with a [Layersummaries].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Layersummaries> list(core.String volumeId, {core.String contentVersion, core.int maxResults, core.String pageToken, core.String source}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (volumeId == null) {
      throw new core.ArgumentError("Parameter volumeId is required.");
    }
    if (contentVersion != null) {
      _queryParams["contentVersion"] = [contentVersion];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }

    _url = 'volumes/' + commons.Escaper.ecapeVariable('$volumeId') + '/layersummary';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Layersummaries.fromJson(data));
  }

}


class LayersAnnotationDataResourceApi {
  final commons.ApiRequester _requester;

  LayersAnnotationDataResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets the annotation data.
   *
   * Request parameters:
   *
   * [volumeId] - The volume to retrieve annotations for.
   *
   * [layerId] - The ID for the layer to get the annotations.
   *
   * [annotationDataId] - The ID of the annotation data to retrieve.
   *
   * [contentVersion] - The content version for the volume you are trying to
   * retrieve.
   *
   * [allowWebDefinitions] - For the dictionary layer. Whether or not to allow
   * web definitions.
   *
   * [h] - The requested pixel height for any images. If height is provided
   * width must also be provided.
   *
   * [locale] - The locale information for the data. ISO-639-1 language and
   * ISO-3166-1 country code. Ex: 'en_US'.
   *
   * [scale] - The requested scale for the image.
   *
   * [source] - String to identify the originator of this request.
   *
   * [w] - The requested pixel width for any images. If width is provided height
   * must also be provided.
   *
   * Completes with a [Annotationdata].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Annotationdata> get(core.String volumeId, core.String layerId, core.String annotationDataId, core.String contentVersion, {core.bool allowWebDefinitions, core.int h, core.String locale, core.int scale, core.String source, core.int w}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (volumeId == null) {
      throw new core.ArgumentError("Parameter volumeId is required.");
    }
    if (layerId == null) {
      throw new core.ArgumentError("Parameter layerId is required.");
    }
    if (annotationDataId == null) {
      throw new core.ArgumentError("Parameter annotationDataId is required.");
    }
    if (contentVersion == null) {
      throw new core.ArgumentError("Parameter contentVersion is required.");
    }
    _queryParams["contentVersion"] = [contentVersion];
    if (allowWebDefinitions != null) {
      _queryParams["allowWebDefinitions"] = ["${allowWebDefinitions}"];
    }
    if (h != null) {
      _queryParams["h"] = ["${h}"];
    }
    if (locale != null) {
      _queryParams["locale"] = [locale];
    }
    if (scale != null) {
      _queryParams["scale"] = ["${scale}"];
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }
    if (w != null) {
      _queryParams["w"] = ["${w}"];
    }

    _url = 'volumes/' + commons.Escaper.ecapeVariable('$volumeId') + '/layers/' + commons.Escaper.ecapeVariable('$layerId') + '/data/' + commons.Escaper.ecapeVariable('$annotationDataId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Annotationdata.fromJson(data));
  }

  /**
   * Gets the annotation data for a volume and layer.
   *
   * Request parameters:
   *
   * [volumeId] - The volume to retrieve annotation data for.
   *
   * [layerId] - The ID for the layer to get the annotation data.
   *
   * [contentVersion] - The content version for the requested volume.
   *
   * [annotationDataId] - The list of Annotation Data Ids to retrieve.
   * Pagination is ignored if this is set.
   *
   * [h] - The requested pixel height for any images. If height is provided
   * width must also be provided.
   *
   * [locale] - The locale information for the data. ISO-639-1 language and
   * ISO-3166-1 country code. Ex: 'en_US'.
   *
   * [maxResults] - Maximum number of results to return
   * Value must be between "0" and "200".
   *
   * [pageToken] - The value of the nextToken from the previous page.
   *
   * [scale] - The requested scale for the image.
   *
   * [source] - String to identify the originator of this request.
   *
   * [updatedMax] - RFC 3339 timestamp to restrict to items updated prior to
   * this timestamp (exclusive).
   *
   * [updatedMin] - RFC 3339 timestamp to restrict to items updated since this
   * timestamp (inclusive).
   *
   * [w] - The requested pixel width for any images. If width is provided height
   * must also be provided.
   *
   * Completes with a [Annotationsdata].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Annotationsdata> list(core.String volumeId, core.String layerId, core.String contentVersion, {core.List<core.String> annotationDataId, core.int h, core.String locale, core.int maxResults, core.String pageToken, core.int scale, core.String source, core.String updatedMax, core.String updatedMin, core.int w}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (volumeId == null) {
      throw new core.ArgumentError("Parameter volumeId is required.");
    }
    if (layerId == null) {
      throw new core.ArgumentError("Parameter layerId is required.");
    }
    if (contentVersion == null) {
      throw new core.ArgumentError("Parameter contentVersion is required.");
    }
    _queryParams["contentVersion"] = [contentVersion];
    if (annotationDataId != null) {
      _queryParams["annotationDataId"] = annotationDataId;
    }
    if (h != null) {
      _queryParams["h"] = ["${h}"];
    }
    if (locale != null) {
      _queryParams["locale"] = [locale];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (scale != null) {
      _queryParams["scale"] = ["${scale}"];
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }
    if (updatedMax != null) {
      _queryParams["updatedMax"] = [updatedMax];
    }
    if (updatedMin != null) {
      _queryParams["updatedMin"] = [updatedMin];
    }
    if (w != null) {
      _queryParams["w"] = ["${w}"];
    }

    _url = 'volumes/' + commons.Escaper.ecapeVariable('$volumeId') + '/layers/' + commons.Escaper.ecapeVariable('$layerId') + '/data';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Annotationsdata.fromJson(data));
  }

}


class LayersVolumeAnnotationsResourceApi {
  final commons.ApiRequester _requester;

  LayersVolumeAnnotationsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets the volume annotation.
   *
   * Request parameters:
   *
   * [volumeId] - The volume to retrieve annotations for.
   *
   * [layerId] - The ID for the layer to get the annotations.
   *
   * [annotationId] - The ID of the volume annotation to retrieve.
   *
   * [locale] - The locale information for the data. ISO-639-1 language and
   * ISO-3166-1 country code. Ex: 'en_US'.
   *
   * [source] - String to identify the originator of this request.
   *
   * Completes with a [Volumeannotation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Volumeannotation> get(core.String volumeId, core.String layerId, core.String annotationId, {core.String locale, core.String source}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (volumeId == null) {
      throw new core.ArgumentError("Parameter volumeId is required.");
    }
    if (layerId == null) {
      throw new core.ArgumentError("Parameter layerId is required.");
    }
    if (annotationId == null) {
      throw new core.ArgumentError("Parameter annotationId is required.");
    }
    if (locale != null) {
      _queryParams["locale"] = [locale];
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }

    _url = 'volumes/' + commons.Escaper.ecapeVariable('$volumeId') + '/layers/' + commons.Escaper.ecapeVariable('$layerId') + '/annotations/' + commons.Escaper.ecapeVariable('$annotationId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Volumeannotation.fromJson(data));
  }

  /**
   * Gets the volume annotations for a volume and layer.
   *
   * Request parameters:
   *
   * [volumeId] - The volume to retrieve annotations for.
   *
   * [layerId] - The ID for the layer to get the annotations.
   *
   * [contentVersion] - The content version for the requested volume.
   *
   * [endOffset] - The end offset to end retrieving data from.
   *
   * [endPosition] - The end position to end retrieving data from.
   *
   * [locale] - The locale information for the data. ISO-639-1 language and
   * ISO-3166-1 country code. Ex: 'en_US'.
   *
   * [maxResults] - Maximum number of results to return
   * Value must be between "0" and "200".
   *
   * [pageToken] - The value of the nextToken from the previous page.
   *
   * [showDeleted] - Set to true to return deleted annotations. updatedMin must
   * be in the request to use this. Defaults to false.
   *
   * [source] - String to identify the originator of this request.
   *
   * [startOffset] - The start offset to start retrieving data from.
   *
   * [startPosition] - The start position to start retrieving data from.
   *
   * [updatedMax] - RFC 3339 timestamp to restrict to items updated prior to
   * this timestamp (exclusive).
   *
   * [updatedMin] - RFC 3339 timestamp to restrict to items updated since this
   * timestamp (inclusive).
   *
   * [volumeAnnotationsVersion] - The version of the volume annotations that you
   * are requesting.
   *
   * Completes with a [Volumeannotations].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Volumeannotations> list(core.String volumeId, core.String layerId, core.String contentVersion, {core.String endOffset, core.String endPosition, core.String locale, core.int maxResults, core.String pageToken, core.bool showDeleted, core.String source, core.String startOffset, core.String startPosition, core.String updatedMax, core.String updatedMin, core.String volumeAnnotationsVersion}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (volumeId == null) {
      throw new core.ArgumentError("Parameter volumeId is required.");
    }
    if (layerId == null) {
      throw new core.ArgumentError("Parameter layerId is required.");
    }
    if (contentVersion == null) {
      throw new core.ArgumentError("Parameter contentVersion is required.");
    }
    _queryParams["contentVersion"] = [contentVersion];
    if (endOffset != null) {
      _queryParams["endOffset"] = [endOffset];
    }
    if (endPosition != null) {
      _queryParams["endPosition"] = [endPosition];
    }
    if (locale != null) {
      _queryParams["locale"] = [locale];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (showDeleted != null) {
      _queryParams["showDeleted"] = ["${showDeleted}"];
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }
    if (startOffset != null) {
      _queryParams["startOffset"] = [startOffset];
    }
    if (startPosition != null) {
      _queryParams["startPosition"] = [startPosition];
    }
    if (updatedMax != null) {
      _queryParams["updatedMax"] = [updatedMax];
    }
    if (updatedMin != null) {
      _queryParams["updatedMin"] = [updatedMin];
    }
    if (volumeAnnotationsVersion != null) {
      _queryParams["volumeAnnotationsVersion"] = [volumeAnnotationsVersion];
    }

    _url = 'volumes/' + commons.Escaper.ecapeVariable('$volumeId') + '/layers/' + commons.Escaper.ecapeVariable('$layerId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Volumeannotations.fromJson(data));
  }

}


class MyconfigResourceApi {
  final commons.ApiRequester _requester;

  MyconfigResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets the current settings for the user.
   *
   * Request parameters:
   *
   * Completes with a [Usersettings].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Usersettings> getUserSettings() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'myconfig/getUserSettings';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Usersettings.fromJson(data));
  }

  /**
   * Release downloaded content access restriction.
   *
   * Request parameters:
   *
   * [volumeIds] - The volume(s) to release restrictions for.
   *
   * [cpksver] - The device/version ID from which to release the restriction.
   *
   * [locale] - ISO-639-1, ISO-3166-1 codes for message localization, i.e.
   * en_US.
   *
   * [source] - String to identify the originator of this request.
   *
   * Completes with a [DownloadAccesses].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<DownloadAccesses> releaseDownloadAccess(core.List<core.String> volumeIds, core.String cpksver, {core.String locale, core.String source}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (volumeIds == null || volumeIds.isEmpty) {
      throw new core.ArgumentError("Parameter volumeIds is required.");
    }
    _queryParams["volumeIds"] = volumeIds;
    if (cpksver == null) {
      throw new core.ArgumentError("Parameter cpksver is required.");
    }
    _queryParams["cpksver"] = [cpksver];
    if (locale != null) {
      _queryParams["locale"] = [locale];
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }

    _url = 'myconfig/releaseDownloadAccess';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new DownloadAccesses.fromJson(data));
  }

  /**
   * Request concurrent and download access restrictions.
   *
   * Request parameters:
   *
   * [source] - String to identify the originator of this request.
   *
   * [volumeId] - The volume to request concurrent/download restrictions for.
   *
   * [nonce] - The client nonce value.
   *
   * [cpksver] - The device/version ID from which to request the restrictions.
   *
   * [licenseTypes] - The type of access license to request. If not specified,
   * the default is BOTH.
   * Possible string values are:
   * - "BOTH" : Both concurrent and download licenses.
   * - "CONCURRENT" : Concurrent access license.
   * - "DOWNLOAD" : Offline download access license.
   *
   * [locale] - ISO-639-1, ISO-3166-1 codes for message localization, i.e.
   * en_US.
   *
   * Completes with a [RequestAccess].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RequestAccess> requestAccess(core.String source, core.String volumeId, core.String nonce, core.String cpksver, {core.String licenseTypes, core.String locale}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (source == null) {
      throw new core.ArgumentError("Parameter source is required.");
    }
    _queryParams["source"] = [source];
    if (volumeId == null) {
      throw new core.ArgumentError("Parameter volumeId is required.");
    }
    _queryParams["volumeId"] = [volumeId];
    if (nonce == null) {
      throw new core.ArgumentError("Parameter nonce is required.");
    }
    _queryParams["nonce"] = [nonce];
    if (cpksver == null) {
      throw new core.ArgumentError("Parameter cpksver is required.");
    }
    _queryParams["cpksver"] = [cpksver];
    if (licenseTypes != null) {
      _queryParams["licenseTypes"] = [licenseTypes];
    }
    if (locale != null) {
      _queryParams["locale"] = [locale];
    }

    _url = 'myconfig/requestAccess';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RequestAccess.fromJson(data));
  }

  /**
   * Request downloaded content access for specified volumes on the My eBooks
   * shelf.
   *
   * Request parameters:
   *
   * [source] - String to identify the originator of this request.
   *
   * [nonce] - The client nonce value.
   *
   * [cpksver] - The device/version ID from which to release the restriction.
   *
   * [features] - List of features supported by the client, i.e., 'RENTALS'
   *
   * [includeNonComicsSeries] - Set to true to include non-comics series.
   * Defaults to false.
   *
   * [locale] - ISO-639-1, ISO-3166-1 codes for message localization, i.e.
   * en_US.
   *
   * [showPreorders] - Set to true to show pre-ordered books. Defaults to false.
   *
   * [volumeIds] - The volume(s) to request download restrictions for.
   *
   * Completes with a [Volumes].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Volumes> syncVolumeLicenses(core.String source, core.String nonce, core.String cpksver, {core.List<core.String> features, core.bool includeNonComicsSeries, core.String locale, core.bool showPreorders, core.List<core.String> volumeIds}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (source == null) {
      throw new core.ArgumentError("Parameter source is required.");
    }
    _queryParams["source"] = [source];
    if (nonce == null) {
      throw new core.ArgumentError("Parameter nonce is required.");
    }
    _queryParams["nonce"] = [nonce];
    if (cpksver == null) {
      throw new core.ArgumentError("Parameter cpksver is required.");
    }
    _queryParams["cpksver"] = [cpksver];
    if (features != null) {
      _queryParams["features"] = features;
    }
    if (includeNonComicsSeries != null) {
      _queryParams["includeNonComicsSeries"] = ["${includeNonComicsSeries}"];
    }
    if (locale != null) {
      _queryParams["locale"] = [locale];
    }
    if (showPreorders != null) {
      _queryParams["showPreorders"] = ["${showPreorders}"];
    }
    if (volumeIds != null) {
      _queryParams["volumeIds"] = volumeIds;
    }

    _url = 'myconfig/syncVolumeLicenses';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Volumes.fromJson(data));
  }

  /**
   * Sets the settings for the user. If a sub-object is specified, it will
   * overwrite the existing sub-object stored in the server. Unspecified
   * sub-objects will retain the existing value.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [Usersettings].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Usersettings> updateUserSettings(Usersettings request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'myconfig/updateUserSettings';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Usersettings.fromJson(data));
  }

}


class MylibraryResourceApi {
  final commons.ApiRequester _requester;

  MylibraryAnnotationsResourceApi get annotations => new MylibraryAnnotationsResourceApi(_requester);
  MylibraryBookshelvesResourceApi get bookshelves => new MylibraryBookshelvesResourceApi(_requester);
  MylibraryReadingpositionsResourceApi get readingpositions => new MylibraryReadingpositionsResourceApi(_requester);

  MylibraryResourceApi(commons.ApiRequester client) : 
      _requester = client;
}


class MylibraryAnnotationsResourceApi {
  final commons.ApiRequester _requester;

  MylibraryAnnotationsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes an annotation.
   *
   * Request parameters:
   *
   * [annotationId] - The ID for the annotation to delete.
   *
   * [source] - String to identify the originator of this request.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String annotationId, {core.String source}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (annotationId == null) {
      throw new core.ArgumentError("Parameter annotationId is required.");
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }

    _downloadOptions = null;

    _url = 'mylibrary/annotations/' + commons.Escaper.ecapeVariable('$annotationId');

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
   * Inserts a new annotation.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [country] - ISO-3166-1 code to override the IP-based location.
   *
   * [showOnlySummaryInResponse] - Requests that only the summary of the
   * specified layer be provided in the response.
   *
   * [source] - String to identify the originator of this request.
   *
   * Completes with a [Annotation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Annotation> insert(Annotation request, {core.String country, core.bool showOnlySummaryInResponse, core.String source}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (country != null) {
      _queryParams["country"] = [country];
    }
    if (showOnlySummaryInResponse != null) {
      _queryParams["showOnlySummaryInResponse"] = ["${showOnlySummaryInResponse}"];
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }

    _url = 'mylibrary/annotations';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Annotation.fromJson(data));
  }

  /**
   * Retrieves a list of annotations, possibly filtered.
   *
   * Request parameters:
   *
   * [contentVersion] - The content version for the requested volume.
   *
   * [layerId] - The layer ID to limit annotation by.
   *
   * [layerIds] - The layer ID(s) to limit annotation by.
   *
   * [maxResults] - Maximum number of results to return
   * Value must be between "0" and "40".
   *
   * [pageToken] - The value of the nextToken from the previous page.
   *
   * [showDeleted] - Set to true to return deleted annotations. updatedMin must
   * be in the request to use this. Defaults to false.
   *
   * [source] - String to identify the originator of this request.
   *
   * [updatedMax] - RFC 3339 timestamp to restrict to items updated prior to
   * this timestamp (exclusive).
   *
   * [updatedMin] - RFC 3339 timestamp to restrict to items updated since this
   * timestamp (inclusive).
   *
   * [volumeId] - The volume to restrict annotations to.
   *
   * Completes with a [Annotations].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Annotations> list({core.String contentVersion, core.String layerId, core.List<core.String> layerIds, core.int maxResults, core.String pageToken, core.bool showDeleted, core.String source, core.String updatedMax, core.String updatedMin, core.String volumeId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (contentVersion != null) {
      _queryParams["contentVersion"] = [contentVersion];
    }
    if (layerId != null) {
      _queryParams["layerId"] = [layerId];
    }
    if (layerIds != null) {
      _queryParams["layerIds"] = layerIds;
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (showDeleted != null) {
      _queryParams["showDeleted"] = ["${showDeleted}"];
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }
    if (updatedMax != null) {
      _queryParams["updatedMax"] = [updatedMax];
    }
    if (updatedMin != null) {
      _queryParams["updatedMin"] = [updatedMin];
    }
    if (volumeId != null) {
      _queryParams["volumeId"] = [volumeId];
    }

    _url = 'mylibrary/annotations';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Annotations.fromJson(data));
  }

  /**
   * Gets the summary of specified layers.
   *
   * Request parameters:
   *
   * [layerIds] - Array of layer IDs to get the summary for.
   *
   * [volumeId] - Volume id to get the summary for.
   *
   * Completes with a [AnnotationsSummary].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AnnotationsSummary> summary(core.List<core.String> layerIds, core.String volumeId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (layerIds == null || layerIds.isEmpty) {
      throw new core.ArgumentError("Parameter layerIds is required.");
    }
    _queryParams["layerIds"] = layerIds;
    if (volumeId == null) {
      throw new core.ArgumentError("Parameter volumeId is required.");
    }
    _queryParams["volumeId"] = [volumeId];

    _url = 'mylibrary/annotations/summary';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AnnotationsSummary.fromJson(data));
  }

  /**
   * Updates an existing annotation.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [annotationId] - The ID for the annotation to update.
   *
   * [source] - String to identify the originator of this request.
   *
   * Completes with a [Annotation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Annotation> update(Annotation request, core.String annotationId, {core.String source}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (annotationId == null) {
      throw new core.ArgumentError("Parameter annotationId is required.");
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }

    _url = 'mylibrary/annotations/' + commons.Escaper.ecapeVariable('$annotationId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Annotation.fromJson(data));
  }

}


class MylibraryBookshelvesResourceApi {
  final commons.ApiRequester _requester;

  MylibraryBookshelvesVolumesResourceApi get volumes => new MylibraryBookshelvesVolumesResourceApi(_requester);

  MylibraryBookshelvesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Adds a volume to a bookshelf.
   *
   * Request parameters:
   *
   * [shelf] - ID of bookshelf to which to add a volume.
   *
   * [volumeId] - ID of volume to add.
   *
   * [reason] - The reason for which the book is added to the library.
   * Possible string values are:
   * - "IOS_PREX" : Volumes added from the PREX flow on iOS.
   * - "IOS_SEARCH" : Volumes added from the Search flow on iOS.
   * - "ONBOARDING" : Volumes added from the Onboarding flow.
   *
   * [source] - String to identify the originator of this request.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future addVolume(core.String shelf, core.String volumeId, {core.String reason, core.String source}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (shelf == null) {
      throw new core.ArgumentError("Parameter shelf is required.");
    }
    if (volumeId == null) {
      throw new core.ArgumentError("Parameter volumeId is required.");
    }
    _queryParams["volumeId"] = [volumeId];
    if (reason != null) {
      _queryParams["reason"] = [reason];
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }

    _downloadOptions = null;

    _url = 'mylibrary/bookshelves/' + commons.Escaper.ecapeVariable('$shelf') + '/addVolume';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Clears all volumes from a bookshelf.
   *
   * Request parameters:
   *
   * [shelf] - ID of bookshelf from which to remove a volume.
   *
   * [source] - String to identify the originator of this request.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future clearVolumes(core.String shelf, {core.String source}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (shelf == null) {
      throw new core.ArgumentError("Parameter shelf is required.");
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }

    _downloadOptions = null;

    _url = 'mylibrary/bookshelves/' + commons.Escaper.ecapeVariable('$shelf') + '/clearVolumes';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Retrieves metadata for a specific bookshelf belonging to the authenticated
   * user.
   *
   * Request parameters:
   *
   * [shelf] - ID of bookshelf to retrieve.
   *
   * [source] - String to identify the originator of this request.
   *
   * Completes with a [Bookshelf].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Bookshelf> get(core.String shelf, {core.String source}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (shelf == null) {
      throw new core.ArgumentError("Parameter shelf is required.");
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }

    _url = 'mylibrary/bookshelves/' + commons.Escaper.ecapeVariable('$shelf');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Bookshelf.fromJson(data));
  }

  /**
   * Retrieves a list of bookshelves belonging to the authenticated user.
   *
   * Request parameters:
   *
   * [source] - String to identify the originator of this request.
   *
   * Completes with a [Bookshelves].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Bookshelves> list({core.String source}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (source != null) {
      _queryParams["source"] = [source];
    }

    _url = 'mylibrary/bookshelves';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Bookshelves.fromJson(data));
  }

  /**
   * Moves a volume within a bookshelf.
   *
   * Request parameters:
   *
   * [shelf] - ID of bookshelf with the volume.
   *
   * [volumeId] - ID of volume to move.
   *
   * [volumePosition] - Position on shelf to move the item (0 puts the item
   * before the current first item, 1 puts it between the first and the second
   * and so on.)
   *
   * [source] - String to identify the originator of this request.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future moveVolume(core.String shelf, core.String volumeId, core.int volumePosition, {core.String source}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (shelf == null) {
      throw new core.ArgumentError("Parameter shelf is required.");
    }
    if (volumeId == null) {
      throw new core.ArgumentError("Parameter volumeId is required.");
    }
    _queryParams["volumeId"] = [volumeId];
    if (volumePosition == null) {
      throw new core.ArgumentError("Parameter volumePosition is required.");
    }
    _queryParams["volumePosition"] = ["${volumePosition}"];
    if (source != null) {
      _queryParams["source"] = [source];
    }

    _downloadOptions = null;

    _url = 'mylibrary/bookshelves/' + commons.Escaper.ecapeVariable('$shelf') + '/moveVolume';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Removes a volume from a bookshelf.
   *
   * Request parameters:
   *
   * [shelf] - ID of bookshelf from which to remove a volume.
   *
   * [volumeId] - ID of volume to remove.
   *
   * [reason] - The reason for which the book is removed from the library.
   * Possible string values are:
   * - "ONBOARDING" : Samples removed from the Onboarding flow.
   *
   * [source] - String to identify the originator of this request.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future removeVolume(core.String shelf, core.String volumeId, {core.String reason, core.String source}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (shelf == null) {
      throw new core.ArgumentError("Parameter shelf is required.");
    }
    if (volumeId == null) {
      throw new core.ArgumentError("Parameter volumeId is required.");
    }
    _queryParams["volumeId"] = [volumeId];
    if (reason != null) {
      _queryParams["reason"] = [reason];
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }

    _downloadOptions = null;

    _url = 'mylibrary/bookshelves/' + commons.Escaper.ecapeVariable('$shelf') + '/removeVolume';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

}


class MylibraryBookshelvesVolumesResourceApi {
  final commons.ApiRequester _requester;

  MylibraryBookshelvesVolumesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets volume information for volumes on a bookshelf.
   *
   * Request parameters:
   *
   * [shelf] - The bookshelf ID or name retrieve volumes for.
   *
   * [country] - ISO-3166-1 code to override the IP-based location.
   *
   * [maxResults] - Maximum number of results to return
   *
   * [projection] - Restrict information returned to a set of selected fields.
   * Possible string values are:
   * - "full" : Includes all volume data.
   * - "lite" : Includes a subset of fields in volumeInfo and accessInfo.
   *
   * [q] - Full-text search query string in this bookshelf.
   *
   * [showPreorders] - Set to true to show pre-ordered books. Defaults to false.
   *
   * [source] - String to identify the originator of this request.
   *
   * [startIndex] - Index of the first element to return (starts at 0)
   *
   * Completes with a [Volumes].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Volumes> list(core.String shelf, {core.String country, core.int maxResults, core.String projection, core.String q, core.bool showPreorders, core.String source, core.int startIndex}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (shelf == null) {
      throw new core.ArgumentError("Parameter shelf is required.");
    }
    if (country != null) {
      _queryParams["country"] = [country];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (projection != null) {
      _queryParams["projection"] = [projection];
    }
    if (q != null) {
      _queryParams["q"] = [q];
    }
    if (showPreorders != null) {
      _queryParams["showPreorders"] = ["${showPreorders}"];
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }
    if (startIndex != null) {
      _queryParams["startIndex"] = ["${startIndex}"];
    }

    _url = 'mylibrary/bookshelves/' + commons.Escaper.ecapeVariable('$shelf') + '/volumes';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Volumes.fromJson(data));
  }

}


class MylibraryReadingpositionsResourceApi {
  final commons.ApiRequester _requester;

  MylibraryReadingpositionsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Retrieves my reading position information for a volume.
   *
   * Request parameters:
   *
   * [volumeId] - ID of volume for which to retrieve a reading position.
   *
   * [contentVersion] - Volume content version for which this reading position
   * is requested.
   *
   * [source] - String to identify the originator of this request.
   *
   * Completes with a [ReadingPosition].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ReadingPosition> get(core.String volumeId, {core.String contentVersion, core.String source}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (volumeId == null) {
      throw new core.ArgumentError("Parameter volumeId is required.");
    }
    if (contentVersion != null) {
      _queryParams["contentVersion"] = [contentVersion];
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }

    _url = 'mylibrary/readingpositions/' + commons.Escaper.ecapeVariable('$volumeId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ReadingPosition.fromJson(data));
  }

  /**
   * Sets my reading position information for a volume.
   *
   * Request parameters:
   *
   * [volumeId] - ID of volume for which to update the reading position.
   *
   * [timestamp] - RFC 3339 UTC format timestamp associated with this reading
   * position.
   *
   * [position] - Position string for the new volume reading position.
   *
   * [action] - Action that caused this reading position to be set.
   * Possible string values are:
   * - "bookmark" : User chose bookmark within volume.
   * - "chapter" : User selected chapter from list.
   * - "next-page" : Next page event.
   * - "prev-page" : Previous page event.
   * - "scroll" : User navigated to page.
   * - "search" : User chose search results within volume.
   *
   * [contentVersion] - Volume content version for which this reading position
   * applies.
   *
   * [deviceCookie] - Random persistent device cookie optional on set position.
   *
   * [source] - String to identify the originator of this request.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future setPosition(core.String volumeId, core.String timestamp, core.String position, {core.String action, core.String contentVersion, core.String deviceCookie, core.String source}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (volumeId == null) {
      throw new core.ArgumentError("Parameter volumeId is required.");
    }
    if (timestamp == null) {
      throw new core.ArgumentError("Parameter timestamp is required.");
    }
    _queryParams["timestamp"] = [timestamp];
    if (position == null) {
      throw new core.ArgumentError("Parameter position is required.");
    }
    _queryParams["position"] = [position];
    if (action != null) {
      _queryParams["action"] = [action];
    }
    if (contentVersion != null) {
      _queryParams["contentVersion"] = [contentVersion];
    }
    if (deviceCookie != null) {
      _queryParams["deviceCookie"] = [deviceCookie];
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }

    _downloadOptions = null;

    _url = 'mylibrary/readingpositions/' + commons.Escaper.ecapeVariable('$volumeId') + '/setPosition';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

}


class NotificationResourceApi {
  final commons.ApiRequester _requester;

  NotificationResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns notification details for a given notification id.
   *
   * Request parameters:
   *
   * [notificationId] - String to identify the notification.
   *
   * [locale] - ISO-639-1 language and ISO-3166-1 country code. Ex: 'en_US'.
   * Used for generating notification title and body.
   *
   * [source] - String to identify the originator of this request.
   *
   * Completes with a [Notification].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Notification> get(core.String notificationId, {core.String locale, core.String source}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (notificationId == null) {
      throw new core.ArgumentError("Parameter notificationId is required.");
    }
    _queryParams["notification_id"] = [notificationId];
    if (locale != null) {
      _queryParams["locale"] = [locale];
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }

    _url = 'notification/get';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Notification.fromJson(data));
  }

}


class OnboardingResourceApi {
  final commons.ApiRequester _requester;

  OnboardingResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * List categories for onboarding experience.
   *
   * Request parameters:
   *
   * [locale] - ISO-639-1 language and ISO-3166-1 country code. Default is en-US
   * if unset.
   *
   * Completes with a [Category].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Category> listCategories({core.String locale}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (locale != null) {
      _queryParams["locale"] = [locale];
    }

    _url = 'onboarding/listCategories';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Category.fromJson(data));
  }

  /**
   * List available volumes under categories for onboarding experience.
   *
   * Request parameters:
   *
   * [categoryId] - List of category ids requested.
   *
   * [locale] - ISO-639-1 language and ISO-3166-1 country code. Default is en-US
   * if unset.
   *
   * [maxAllowedMaturityRating] - The maximum allowed maturity rating of
   * returned volumes. Books with a higher maturity rating are filtered out.
   * Possible string values are:
   * - "mature" : Show books which are rated mature or lower.
   * - "not-mature" : Show books which are rated not mature.
   *
   * [pageSize] - Number of maximum results per page to be included in the
   * response.
   *
   * [pageToken] - The value of the nextToken from the previous page.
   *
   * Completes with a [Volume2].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Volume2> listCategoryVolumes({core.List<core.String> categoryId, core.String locale, core.String maxAllowedMaturityRating, core.int pageSize, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (categoryId != null) {
      _queryParams["categoryId"] = categoryId;
    }
    if (locale != null) {
      _queryParams["locale"] = [locale];
    }
    if (maxAllowedMaturityRating != null) {
      _queryParams["maxAllowedMaturityRating"] = [maxAllowedMaturityRating];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }

    _url = 'onboarding/listCategoryVolumes';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Volume2.fromJson(data));
  }

}


class PersonalizedstreamResourceApi {
  final commons.ApiRequester _requester;

  PersonalizedstreamResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns a stream of personalized book clusters
   *
   * Request parameters:
   *
   * [locale] - ISO-639-1 language and ISO-3166-1 country code. Ex: 'en_US'.
   * Used for generating recommendations.
   *
   * [maxAllowedMaturityRating] - The maximum allowed maturity rating of
   * returned recommendations. Books with a higher maturity rating are filtered
   * out.
   * Possible string values are:
   * - "mature" : Show books which are rated mature or lower.
   * - "not-mature" : Show books which are rated not mature.
   *
   * [source] - String to identify the originator of this request.
   *
   * Completes with a [Discoveryclusters].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Discoveryclusters> get({core.String locale, core.String maxAllowedMaturityRating, core.String source}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (locale != null) {
      _queryParams["locale"] = [locale];
    }
    if (maxAllowedMaturityRating != null) {
      _queryParams["maxAllowedMaturityRating"] = [maxAllowedMaturityRating];
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }

    _url = 'personalizedstream/get';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Discoveryclusters.fromJson(data));
  }

}


class PromoofferResourceApi {
  final commons.ApiRequester _requester;

  PromoofferResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Request parameters:
   *
   * [androidId] - device android_id
   *
   * [device] - device device
   *
   * [manufacturer] - device manufacturer
   *
   * [model] - device model
   *
   * [offerId] - null
   *
   * [product] - device product
   *
   * [serial] - device serial
   *
   * [volumeId] - Volume id to exercise the offer
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future accept({core.String androidId, core.String device, core.String manufacturer, core.String model, core.String offerId, core.String product, core.String serial, core.String volumeId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (androidId != null) {
      _queryParams["androidId"] = [androidId];
    }
    if (device != null) {
      _queryParams["device"] = [device];
    }
    if (manufacturer != null) {
      _queryParams["manufacturer"] = [manufacturer];
    }
    if (model != null) {
      _queryParams["model"] = [model];
    }
    if (offerId != null) {
      _queryParams["offerId"] = [offerId];
    }
    if (product != null) {
      _queryParams["product"] = [product];
    }
    if (serial != null) {
      _queryParams["serial"] = [serial];
    }
    if (volumeId != null) {
      _queryParams["volumeId"] = [volumeId];
    }

    _downloadOptions = null;

    _url = 'promooffer/accept';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Request parameters:
   *
   * [androidId] - device android_id
   *
   * [device] - device device
   *
   * [manufacturer] - device manufacturer
   *
   * [model] - device model
   *
   * [offerId] - Offer to dimiss
   *
   * [product] - device product
   *
   * [serial] - device serial
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future dismiss({core.String androidId, core.String device, core.String manufacturer, core.String model, core.String offerId, core.String product, core.String serial}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (androidId != null) {
      _queryParams["androidId"] = [androidId];
    }
    if (device != null) {
      _queryParams["device"] = [device];
    }
    if (manufacturer != null) {
      _queryParams["manufacturer"] = [manufacturer];
    }
    if (model != null) {
      _queryParams["model"] = [model];
    }
    if (offerId != null) {
      _queryParams["offerId"] = [offerId];
    }
    if (product != null) {
      _queryParams["product"] = [product];
    }
    if (serial != null) {
      _queryParams["serial"] = [serial];
    }

    _downloadOptions = null;

    _url = 'promooffer/dismiss';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Returns a list of promo offers available to the user
   *
   * Request parameters:
   *
   * [androidId] - device android_id
   *
   * [device] - device device
   *
   * [manufacturer] - device manufacturer
   *
   * [model] - device model
   *
   * [product] - device product
   *
   * [serial] - device serial
   *
   * Completes with a [Offers].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Offers> get({core.String androidId, core.String device, core.String manufacturer, core.String model, core.String product, core.String serial}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (androidId != null) {
      _queryParams["androidId"] = [androidId];
    }
    if (device != null) {
      _queryParams["device"] = [device];
    }
    if (manufacturer != null) {
      _queryParams["manufacturer"] = [manufacturer];
    }
    if (model != null) {
      _queryParams["model"] = [model];
    }
    if (product != null) {
      _queryParams["product"] = [product];
    }
    if (serial != null) {
      _queryParams["serial"] = [serial];
    }

    _url = 'promooffer/get';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Offers.fromJson(data));
  }

}


class SeriesResourceApi {
  final commons.ApiRequester _requester;

  SeriesMembershipResourceApi get membership => new SeriesMembershipResourceApi(_requester);

  SeriesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns Series metadata for the given series ids.
   *
   * Request parameters:
   *
   * [seriesId] - String that identifies the series
   *
   * Completes with a [Series].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Series> get(core.List<core.String> seriesId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (seriesId == null || seriesId.isEmpty) {
      throw new core.ArgumentError("Parameter seriesId is required.");
    }
    _queryParams["series_id"] = seriesId;

    _url = 'series/get';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Series.fromJson(data));
  }

}


class SeriesMembershipResourceApi {
  final commons.ApiRequester _requester;

  SeriesMembershipResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Returns Series membership data given the series id.
   *
   * Request parameters:
   *
   * [seriesId] - String that identifies the series
   *
   * [pageSize] - Number of maximum results per page to be included in the
   * response.
   *
   * [pageToken] - The value of the nextToken from the previous page.
   *
   * Completes with a [Seriesmembership].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Seriesmembership> get(core.String seriesId, {core.int pageSize, core.String pageToken}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (seriesId == null) {
      throw new core.ArgumentError("Parameter seriesId is required.");
    }
    _queryParams["series_id"] = [seriesId];
    if (pageSize != null) {
      _queryParams["page_size"] = ["${pageSize}"];
    }
    if (pageToken != null) {
      _queryParams["page_token"] = [pageToken];
    }

    _url = 'series/membership/get';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Seriesmembership.fromJson(data));
  }

}


class VolumesResourceApi {
  final commons.ApiRequester _requester;

  VolumesAssociatedResourceApi get associated => new VolumesAssociatedResourceApi(_requester);
  VolumesMybooksResourceApi get mybooks => new VolumesMybooksResourceApi(_requester);
  VolumesRecommendedResourceApi get recommended => new VolumesRecommendedResourceApi(_requester);
  VolumesUseruploadedResourceApi get useruploaded => new VolumesUseruploadedResourceApi(_requester);

  VolumesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets volume information for a single volume.
   *
   * Request parameters:
   *
   * [volumeId] - ID of volume to retrieve.
   *
   * [country] - ISO-3166-1 code to override the IP-based location.
   *
   * [includeNonComicsSeries] - Set to true to include non-comics series.
   * Defaults to false.
   *
   * [partner] - Brand results for partner ID.
   *
   * [projection] - Restrict information returned to a set of selected fields.
   * Possible string values are:
   * - "full" : Includes all volume data.
   * - "lite" : Includes a subset of fields in volumeInfo and accessInfo.
   *
   * [source] - String to identify the originator of this request.
   *
   * [userLibraryConsistentRead] - null
   *
   * Completes with a [Volume].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Volume> get(core.String volumeId, {core.String country, core.bool includeNonComicsSeries, core.String partner, core.String projection, core.String source, core.bool userLibraryConsistentRead}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (volumeId == null) {
      throw new core.ArgumentError("Parameter volumeId is required.");
    }
    if (country != null) {
      _queryParams["country"] = [country];
    }
    if (includeNonComicsSeries != null) {
      _queryParams["includeNonComicsSeries"] = ["${includeNonComicsSeries}"];
    }
    if (partner != null) {
      _queryParams["partner"] = [partner];
    }
    if (projection != null) {
      _queryParams["projection"] = [projection];
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }
    if (userLibraryConsistentRead != null) {
      _queryParams["user_library_consistent_read"] = ["${userLibraryConsistentRead}"];
    }

    _url = 'volumes/' + commons.Escaper.ecapeVariable('$volumeId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Volume.fromJson(data));
  }

  /**
   * Performs a book search.
   *
   * Request parameters:
   *
   * [q] - Full-text search query string.
   *
   * [download] - Restrict to volumes by download availability.
   * Possible string values are:
   * - "epub" : All volumes with epub.
   *
   * [filter] - Filter search results.
   * Possible string values are:
   * - "ebooks" : All Google eBooks.
   * - "free-ebooks" : Google eBook with full volume text viewability.
   * - "full" : Public can view entire volume text.
   * - "paid-ebooks" : Google eBook with a price.
   * - "partial" : Public able to see parts of text.
   *
   * [langRestrict] - Restrict results to books with this language code.
   *
   * [libraryRestrict] - Restrict search to this user's library.
   * Possible string values are:
   * - "my-library" : Restrict to the user's library, any shelf.
   * - "no-restrict" : Do not restrict based on user's library.
   *
   * [maxAllowedMaturityRating] - The maximum allowed maturity rating of
   * returned recommendations. Books with a higher maturity rating are filtered
   * out.
   * Possible string values are:
   * - "mature" : Show books which are rated mature or lower.
   * - "not-mature" : Show books which are rated not mature.
   *
   * [maxResults] - Maximum number of results to return.
   * Value must be between "0" and "40".
   *
   * [orderBy] - Sort search results.
   * Possible string values are:
   * - "newest" : Most recently published.
   * - "relevance" : Relevance to search terms.
   *
   * [partner] - Restrict and brand results for partner ID.
   *
   * [printType] - Restrict to books or magazines.
   * Possible string values are:
   * - "all" : All volume content types.
   * - "books" : Just books.
   * - "magazines" : Just magazines.
   *
   * [projection] - Restrict information returned to a set of selected fields.
   * Possible string values are:
   * - "full" : Includes all volume data.
   * - "lite" : Includes a subset of fields in volumeInfo and accessInfo.
   *
   * [showPreorders] - Set to true to show books available for preorder.
   * Defaults to false.
   *
   * [source] - String to identify the originator of this request.
   *
   * [startIndex] - Index of the first result to return (starts at 0)
   *
   * Completes with a [Volumes].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Volumes> list(core.String q, {core.String download, core.String filter, core.String langRestrict, core.String libraryRestrict, core.String maxAllowedMaturityRating, core.int maxResults, core.String orderBy, core.String partner, core.String printType, core.String projection, core.bool showPreorders, core.String source, core.int startIndex}) {
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
    if (download != null) {
      _queryParams["download"] = [download];
    }
    if (filter != null) {
      _queryParams["filter"] = [filter];
    }
    if (langRestrict != null) {
      _queryParams["langRestrict"] = [langRestrict];
    }
    if (libraryRestrict != null) {
      _queryParams["libraryRestrict"] = [libraryRestrict];
    }
    if (maxAllowedMaturityRating != null) {
      _queryParams["maxAllowedMaturityRating"] = [maxAllowedMaturityRating];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (orderBy != null) {
      _queryParams["orderBy"] = [orderBy];
    }
    if (partner != null) {
      _queryParams["partner"] = [partner];
    }
    if (printType != null) {
      _queryParams["printType"] = [printType];
    }
    if (projection != null) {
      _queryParams["projection"] = [projection];
    }
    if (showPreorders != null) {
      _queryParams["showPreorders"] = ["${showPreorders}"];
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }
    if (startIndex != null) {
      _queryParams["startIndex"] = ["${startIndex}"];
    }

    _url = 'volumes';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Volumes.fromJson(data));
  }

}


class VolumesAssociatedResourceApi {
  final commons.ApiRequester _requester;

  VolumesAssociatedResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Return a list of associated books.
   *
   * Request parameters:
   *
   * [volumeId] - ID of the source volume.
   *
   * [association] - Association type.
   * Possible string values are:
   * - "end-of-sample" : Recommendations for display end-of-sample.
   * - "end-of-volume" : Recommendations for display end-of-volume.
   * - "related-for-play" : Related volumes for Play Store.
   *
   * [locale] - ISO-639-1 language and ISO-3166-1 country code. Ex: 'en_US'.
   * Used for generating recommendations.
   *
   * [maxAllowedMaturityRating] - The maximum allowed maturity rating of
   * returned recommendations. Books with a higher maturity rating are filtered
   * out.
   * Possible string values are:
   * - "mature" : Show books which are rated mature or lower.
   * - "not-mature" : Show books which are rated not mature.
   *
   * [source] - String to identify the originator of this request.
   *
   * Completes with a [Volumes].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Volumes> list(core.String volumeId, {core.String association, core.String locale, core.String maxAllowedMaturityRating, core.String source}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (volumeId == null) {
      throw new core.ArgumentError("Parameter volumeId is required.");
    }
    if (association != null) {
      _queryParams["association"] = [association];
    }
    if (locale != null) {
      _queryParams["locale"] = [locale];
    }
    if (maxAllowedMaturityRating != null) {
      _queryParams["maxAllowedMaturityRating"] = [maxAllowedMaturityRating];
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }

    _url = 'volumes/' + commons.Escaper.ecapeVariable('$volumeId') + '/associated';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Volumes.fromJson(data));
  }

}


class VolumesMybooksResourceApi {
  final commons.ApiRequester _requester;

  VolumesMybooksResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Return a list of books in My Library.
   *
   * Request parameters:
   *
   * [acquireMethod] - How the book was acquired
   *
   * [country] - ISO-3166-1 code to override the IP-based location.
   *
   * [locale] - ISO-639-1 language and ISO-3166-1 country code. Ex:'en_US'. Used
   * for generating recommendations.
   *
   * [maxResults] - Maximum number of results to return.
   * Value must be between "0" and "100".
   *
   * [processingState] - The processing state of the user uploaded volumes to be
   * returned. Applicable only if the UPLOADED is specified in the
   * acquireMethod.
   *
   * [source] - String to identify the originator of this request.
   *
   * [startIndex] - Index of the first result to return (starts at 0)
   *
   * Completes with a [Volumes].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Volumes> list({core.List<core.String> acquireMethod, core.String country, core.String locale, core.int maxResults, core.List<core.String> processingState, core.String source, core.int startIndex}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (acquireMethod != null) {
      _queryParams["acquireMethod"] = acquireMethod;
    }
    if (country != null) {
      _queryParams["country"] = [country];
    }
    if (locale != null) {
      _queryParams["locale"] = [locale];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (processingState != null) {
      _queryParams["processingState"] = processingState;
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }
    if (startIndex != null) {
      _queryParams["startIndex"] = ["${startIndex}"];
    }

    _url = 'volumes/mybooks';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Volumes.fromJson(data));
  }

}


class VolumesRecommendedResourceApi {
  final commons.ApiRequester _requester;

  VolumesRecommendedResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Return a list of recommended books for the current user.
   *
   * Request parameters:
   *
   * [locale] - ISO-639-1 language and ISO-3166-1 country code. Ex: 'en_US'.
   * Used for generating recommendations.
   *
   * [maxAllowedMaturityRating] - The maximum allowed maturity rating of
   * returned recommendations. Books with a higher maturity rating are filtered
   * out.
   * Possible string values are:
   * - "mature" : Show books which are rated mature or lower.
   * - "not-mature" : Show books which are rated not mature.
   *
   * [source] - String to identify the originator of this request.
   *
   * Completes with a [Volumes].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Volumes> list({core.String locale, core.String maxAllowedMaturityRating, core.String source}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (locale != null) {
      _queryParams["locale"] = [locale];
    }
    if (maxAllowedMaturityRating != null) {
      _queryParams["maxAllowedMaturityRating"] = [maxAllowedMaturityRating];
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }

    _url = 'volumes/recommended';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Volumes.fromJson(data));
  }

  /**
   * Rate a recommended book for the current user.
   *
   * Request parameters:
   *
   * [rating] - Rating to be given to the volume.
   * Possible string values are:
   * - "HAVE_IT" : Rating indicating a dismissal due to ownership.
   * - "NOT_INTERESTED" : Rating indicating a negative dismissal of a volume.
   *
   * [volumeId] - ID of the source volume.
   *
   * [locale] - ISO-639-1 language and ISO-3166-1 country code. Ex: 'en_US'.
   * Used for generating recommendations.
   *
   * [source] - String to identify the originator of this request.
   *
   * Completes with a [BooksVolumesRecommendedRateResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<BooksVolumesRecommendedRateResponse> rate(core.String rating, core.String volumeId, {core.String locale, core.String source}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (rating == null) {
      throw new core.ArgumentError("Parameter rating is required.");
    }
    _queryParams["rating"] = [rating];
    if (volumeId == null) {
      throw new core.ArgumentError("Parameter volumeId is required.");
    }
    _queryParams["volumeId"] = [volumeId];
    if (locale != null) {
      _queryParams["locale"] = [locale];
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }

    _url = 'volumes/recommended/rate';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new BooksVolumesRecommendedRateResponse.fromJson(data));
  }

}


class VolumesUseruploadedResourceApi {
  final commons.ApiRequester _requester;

  VolumesUseruploadedResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Return a list of books uploaded by the current user.
   *
   * Request parameters:
   *
   * [locale] - ISO-639-1 language and ISO-3166-1 country code. Ex: 'en_US'.
   * Used for generating recommendations.
   *
   * [maxResults] - Maximum number of results to return.
   * Value must be between "0" and "40".
   *
   * [processingState] - The processing state of the user uploaded volumes to be
   * returned.
   *
   * [source] - String to identify the originator of this request.
   *
   * [startIndex] - Index of the first result to return (starts at 0)
   *
   * [volumeId] - The ids of the volumes to be returned. If not specified all
   * that match the processingState are returned.
   *
   * Completes with a [Volumes].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Volumes> list({core.String locale, core.int maxResults, core.List<core.String> processingState, core.String source, core.int startIndex, core.List<core.String> volumeId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (locale != null) {
      _queryParams["locale"] = [locale];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (processingState != null) {
      _queryParams["processingState"] = processingState;
    }
    if (source != null) {
      _queryParams["source"] = [source];
    }
    if (startIndex != null) {
      _queryParams["startIndex"] = ["${startIndex}"];
    }
    if (volumeId != null) {
      _queryParams["volumeId"] = volumeId;
    }

    _url = 'volumes/useruploaded';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Volumes.fromJson(data));
  }

}



/** Selection ranges sent from the client. */
class AnnotationClientVersionRanges {
  /** Range in CFI format for this annotation sent by client. */
  BooksAnnotationsRange cfiRange;
  /** Content version the client sent in. */
  core.String contentVersion;
  /** Range in GB image format for this annotation sent by client. */
  BooksAnnotationsRange gbImageRange;
  /** Range in GB text format for this annotation sent by client. */
  BooksAnnotationsRange gbTextRange;
  /** Range in image CFI format for this annotation sent by client. */
  BooksAnnotationsRange imageCfiRange;

  AnnotationClientVersionRanges();

  AnnotationClientVersionRanges.fromJson(core.Map _json) {
    if (_json.containsKey("cfiRange")) {
      cfiRange = new BooksAnnotationsRange.fromJson(_json["cfiRange"]);
    }
    if (_json.containsKey("contentVersion")) {
      contentVersion = _json["contentVersion"];
    }
    if (_json.containsKey("gbImageRange")) {
      gbImageRange = new BooksAnnotationsRange.fromJson(_json["gbImageRange"]);
    }
    if (_json.containsKey("gbTextRange")) {
      gbTextRange = new BooksAnnotationsRange.fromJson(_json["gbTextRange"]);
    }
    if (_json.containsKey("imageCfiRange")) {
      imageCfiRange = new BooksAnnotationsRange.fromJson(_json["imageCfiRange"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cfiRange != null) {
      _json["cfiRange"] = (cfiRange).toJson();
    }
    if (contentVersion != null) {
      _json["contentVersion"] = contentVersion;
    }
    if (gbImageRange != null) {
      _json["gbImageRange"] = (gbImageRange).toJson();
    }
    if (gbTextRange != null) {
      _json["gbTextRange"] = (gbTextRange).toJson();
    }
    if (imageCfiRange != null) {
      _json["imageCfiRange"] = (imageCfiRange).toJson();
    }
    return _json;
  }
}

/** Selection ranges for the most recent content version. */
class AnnotationCurrentVersionRanges {
  /** Range in CFI format for this annotation for version above. */
  BooksAnnotationsRange cfiRange;
  /** Content version applicable to ranges below. */
  core.String contentVersion;
  /** Range in GB image format for this annotation for version above. */
  BooksAnnotationsRange gbImageRange;
  /** Range in GB text format for this annotation for version above. */
  BooksAnnotationsRange gbTextRange;
  /** Range in image CFI format for this annotation for version above. */
  BooksAnnotationsRange imageCfiRange;

  AnnotationCurrentVersionRanges();

  AnnotationCurrentVersionRanges.fromJson(core.Map _json) {
    if (_json.containsKey("cfiRange")) {
      cfiRange = new BooksAnnotationsRange.fromJson(_json["cfiRange"]);
    }
    if (_json.containsKey("contentVersion")) {
      contentVersion = _json["contentVersion"];
    }
    if (_json.containsKey("gbImageRange")) {
      gbImageRange = new BooksAnnotationsRange.fromJson(_json["gbImageRange"]);
    }
    if (_json.containsKey("gbTextRange")) {
      gbTextRange = new BooksAnnotationsRange.fromJson(_json["gbTextRange"]);
    }
    if (_json.containsKey("imageCfiRange")) {
      imageCfiRange = new BooksAnnotationsRange.fromJson(_json["imageCfiRange"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cfiRange != null) {
      _json["cfiRange"] = (cfiRange).toJson();
    }
    if (contentVersion != null) {
      _json["contentVersion"] = contentVersion;
    }
    if (gbImageRange != null) {
      _json["gbImageRange"] = (gbImageRange).toJson();
    }
    if (gbTextRange != null) {
      _json["gbTextRange"] = (gbTextRange).toJson();
    }
    if (imageCfiRange != null) {
      _json["imageCfiRange"] = (imageCfiRange).toJson();
    }
    return _json;
  }
}

class AnnotationLayerSummary {
  /**
   * Maximum allowed characters on this layer, especially for the "copy" layer.
   */
  core.int allowedCharacterCount;
  /**
   * Type of limitation on this layer. "limited" or "unlimited" for the "copy"
   * layer.
   */
  core.String limitType;
  /**
   * Remaining allowed characters on this layer, especially for the "copy"
   * layer.
   */
  core.int remainingCharacterCount;

  AnnotationLayerSummary();

  AnnotationLayerSummary.fromJson(core.Map _json) {
    if (_json.containsKey("allowedCharacterCount")) {
      allowedCharacterCount = _json["allowedCharacterCount"];
    }
    if (_json.containsKey("limitType")) {
      limitType = _json["limitType"];
    }
    if (_json.containsKey("remainingCharacterCount")) {
      remainingCharacterCount = _json["remainingCharacterCount"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (allowedCharacterCount != null) {
      _json["allowedCharacterCount"] = allowedCharacterCount;
    }
    if (limitType != null) {
      _json["limitType"] = limitType;
    }
    if (remainingCharacterCount != null) {
      _json["remainingCharacterCount"] = remainingCharacterCount;
    }
    return _json;
  }
}

class Annotation {
  /**
   * Anchor text after excerpt. For requests, if the user bookmarked a screen
   * that has no flowing text on it, then this field should be empty.
   */
  core.String afterSelectedText;
  /**
   * Anchor text before excerpt. For requests, if the user bookmarked a screen
   * that has no flowing text on it, then this field should be empty.
   */
  core.String beforeSelectedText;
  /** Selection ranges sent from the client. */
  AnnotationClientVersionRanges clientVersionRanges;
  /** Timestamp for the created time of this annotation. */
  core.DateTime created;
  /** Selection ranges for the most recent content version. */
  AnnotationCurrentVersionRanges currentVersionRanges;
  /** User-created data for this annotation. */
  core.String data;
  /** Indicates that this annotation is deleted. */
  core.bool deleted;
  /** The highlight style for this annotation. */
  core.String highlightStyle;
  /** Id of this annotation, in the form of a GUID. */
  core.String id;
  /** Resource type. */
  core.String kind;
  /** The layer this annotation is for. */
  core.String layerId;
  AnnotationLayerSummary layerSummary;
  /** Pages that this annotation spans. */
  core.List<core.String> pageIds;
  /** Excerpt from the volume. */
  core.String selectedText;
  /** URL to this resource. */
  core.String selfLink;
  /** Timestamp for the last time this annotation was modified. */
  core.DateTime updated;
  /** The volume that this annotation belongs to. */
  core.String volumeId;

  Annotation();

  Annotation.fromJson(core.Map _json) {
    if (_json.containsKey("afterSelectedText")) {
      afterSelectedText = _json["afterSelectedText"];
    }
    if (_json.containsKey("beforeSelectedText")) {
      beforeSelectedText = _json["beforeSelectedText"];
    }
    if (_json.containsKey("clientVersionRanges")) {
      clientVersionRanges = new AnnotationClientVersionRanges.fromJson(_json["clientVersionRanges"]);
    }
    if (_json.containsKey("created")) {
      created = core.DateTime.parse(_json["created"]);
    }
    if (_json.containsKey("currentVersionRanges")) {
      currentVersionRanges = new AnnotationCurrentVersionRanges.fromJson(_json["currentVersionRanges"]);
    }
    if (_json.containsKey("data")) {
      data = _json["data"];
    }
    if (_json.containsKey("deleted")) {
      deleted = _json["deleted"];
    }
    if (_json.containsKey("highlightStyle")) {
      highlightStyle = _json["highlightStyle"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("layerId")) {
      layerId = _json["layerId"];
    }
    if (_json.containsKey("layerSummary")) {
      layerSummary = new AnnotationLayerSummary.fromJson(_json["layerSummary"]);
    }
    if (_json.containsKey("pageIds")) {
      pageIds = _json["pageIds"];
    }
    if (_json.containsKey("selectedText")) {
      selectedText = _json["selectedText"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
    if (_json.containsKey("volumeId")) {
      volumeId = _json["volumeId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (afterSelectedText != null) {
      _json["afterSelectedText"] = afterSelectedText;
    }
    if (beforeSelectedText != null) {
      _json["beforeSelectedText"] = beforeSelectedText;
    }
    if (clientVersionRanges != null) {
      _json["clientVersionRanges"] = (clientVersionRanges).toJson();
    }
    if (created != null) {
      _json["created"] = (created).toIso8601String();
    }
    if (currentVersionRanges != null) {
      _json["currentVersionRanges"] = (currentVersionRanges).toJson();
    }
    if (data != null) {
      _json["data"] = data;
    }
    if (deleted != null) {
      _json["deleted"] = deleted;
    }
    if (highlightStyle != null) {
      _json["highlightStyle"] = highlightStyle;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (layerId != null) {
      _json["layerId"] = layerId;
    }
    if (layerSummary != null) {
      _json["layerSummary"] = (layerSummary).toJson();
    }
    if (pageIds != null) {
      _json["pageIds"] = pageIds;
    }
    if (selectedText != null) {
      _json["selectedText"] = selectedText;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    if (volumeId != null) {
      _json["volumeId"] = volumeId;
    }
    return _json;
  }
}

class Annotationdata {
  /** The type of annotation this data is for. */
  core.String annotationType;
  /**
   *
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Object data;
  /** Base64 encoded data for this annotation data. */
  core.String encodedData;
  core.List<core.int> get encodedDataAsBytes {
    return convert.BASE64.decode(encodedData);
  }

  void set encodedDataAsBytes(core.List<core.int> _bytes) {
    encodedData = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /** Unique id for this annotation data. */
  core.String id;
  /** Resource Type */
  core.String kind;
  /** The Layer id for this data. * */
  core.String layerId;
  /** URL for this resource. * */
  core.String selfLink;
  /**
   * Timestamp for the last time this data was updated. (RFC 3339 UTC date-time
   * format).
   */
  core.DateTime updated;
  /** The volume id for this data. * */
  core.String volumeId;

  Annotationdata();

  Annotationdata.fromJson(core.Map _json) {
    if (_json.containsKey("annotationType")) {
      annotationType = _json["annotationType"];
    }
    if (_json.containsKey("data")) {
      data = _json["data"];
    }
    if (_json.containsKey("encoded_data")) {
      encodedData = _json["encoded_data"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("layerId")) {
      layerId = _json["layerId"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
    if (_json.containsKey("volumeId")) {
      volumeId = _json["volumeId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (annotationType != null) {
      _json["annotationType"] = annotationType;
    }
    if (data != null) {
      _json["data"] = data;
    }
    if (encodedData != null) {
      _json["encoded_data"] = encodedData;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (layerId != null) {
      _json["layerId"] = layerId;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    if (volumeId != null) {
      _json["volumeId"] = volumeId;
    }
    return _json;
  }
}

class Annotations {
  /** A list of annotations. */
  core.List<Annotation> items;
  /** Resource type. */
  core.String kind;
  /**
   * Token to pass in for pagination for the next page. This will not be present
   * if this request does not have more results.
   */
  core.String nextPageToken;
  /**
   * Total number of annotations found. This may be greater than the number of
   * notes returned in this response if results have been paginated.
   */
  core.int totalItems;

  Annotations();

  Annotations.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Annotation.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("totalItems")) {
      totalItems = _json["totalItems"];
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
    if (totalItems != null) {
      _json["totalItems"] = totalItems;
    }
    return _json;
  }
}

class AnnotationsSummaryLayers {
  core.int allowedCharacterCount;
  core.String layerId;
  core.String limitType;
  core.int remainingCharacterCount;
  core.DateTime updated;

  AnnotationsSummaryLayers();

  AnnotationsSummaryLayers.fromJson(core.Map _json) {
    if (_json.containsKey("allowedCharacterCount")) {
      allowedCharacterCount = _json["allowedCharacterCount"];
    }
    if (_json.containsKey("layerId")) {
      layerId = _json["layerId"];
    }
    if (_json.containsKey("limitType")) {
      limitType = _json["limitType"];
    }
    if (_json.containsKey("remainingCharacterCount")) {
      remainingCharacterCount = _json["remainingCharacterCount"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (allowedCharacterCount != null) {
      _json["allowedCharacterCount"] = allowedCharacterCount;
    }
    if (layerId != null) {
      _json["layerId"] = layerId;
    }
    if (limitType != null) {
      _json["limitType"] = limitType;
    }
    if (remainingCharacterCount != null) {
      _json["remainingCharacterCount"] = remainingCharacterCount;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    return _json;
  }
}

class AnnotationsSummary {
  core.String kind;
  core.List<AnnotationsSummaryLayers> layers;

  AnnotationsSummary();

  AnnotationsSummary.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("layers")) {
      layers = _json["layers"].map((value) => new AnnotationsSummaryLayers.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (layers != null) {
      _json["layers"] = layers.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class Annotationsdata {
  /** A list of Annotation Data. */
  core.List<Annotationdata> items;
  /** Resource type */
  core.String kind;
  /**
   * Token to pass in for pagination for the next page. This will not be present
   * if this request does not have more results.
   */
  core.String nextPageToken;
  /** The total number of volume annotations found. */
  core.int totalItems;

  Annotationsdata();

  Annotationsdata.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Annotationdata.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("totalItems")) {
      totalItems = _json["totalItems"];
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
    if (totalItems != null) {
      _json["totalItems"] = totalItems;
    }
    return _json;
  }
}

class BooksAnnotationsRange {
  /** The offset from the ending position. */
  core.String endOffset;
  /** The ending position for the range. */
  core.String endPosition;
  /** The offset from the starting position. */
  core.String startOffset;
  /** The starting position for the range. */
  core.String startPosition;

  BooksAnnotationsRange();

  BooksAnnotationsRange.fromJson(core.Map _json) {
    if (_json.containsKey("endOffset")) {
      endOffset = _json["endOffset"];
    }
    if (_json.containsKey("endPosition")) {
      endPosition = _json["endPosition"];
    }
    if (_json.containsKey("startOffset")) {
      startOffset = _json["startOffset"];
    }
    if (_json.containsKey("startPosition")) {
      startPosition = _json["startPosition"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (endOffset != null) {
      _json["endOffset"] = endOffset;
    }
    if (endPosition != null) {
      _json["endPosition"] = endPosition;
    }
    if (startOffset != null) {
      _json["startOffset"] = startOffset;
    }
    if (startPosition != null) {
      _json["startPosition"] = startPosition;
    }
    return _json;
  }
}

class BooksCloudloadingResource {
  core.String author;
  core.String processingState;
  core.String title;
  core.String volumeId;

  BooksCloudloadingResource();

  BooksCloudloadingResource.fromJson(core.Map _json) {
    if (_json.containsKey("author")) {
      author = _json["author"];
    }
    if (_json.containsKey("processingState")) {
      processingState = _json["processingState"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("volumeId")) {
      volumeId = _json["volumeId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (author != null) {
      _json["author"] = author;
    }
    if (processingState != null) {
      _json["processingState"] = processingState;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (volumeId != null) {
      _json["volumeId"] = volumeId;
    }
    return _json;
  }
}

class BooksVolumesRecommendedRateResponse {
  core.String consistencyToken;

  BooksVolumesRecommendedRateResponse();

  BooksVolumesRecommendedRateResponse.fromJson(core.Map _json) {
    if (_json.containsKey("consistency_token")) {
      consistencyToken = _json["consistency_token"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (consistencyToken != null) {
      _json["consistency_token"] = consistencyToken;
    }
    return _json;
  }
}

class Bookshelf {
  /** Whether this bookshelf is PUBLIC or PRIVATE. */
  core.String access;
  /**
   * Created time for this bookshelf (formatted UTC timestamp with millisecond
   * resolution).
   */
  core.DateTime created;
  /** Description of this bookshelf. */
  core.String description;
  /** Id of this bookshelf, only unique by user. */
  core.int id;
  /** Resource type for bookshelf metadata. */
  core.String kind;
  /** URL to this resource. */
  core.String selfLink;
  /** Title of this bookshelf. */
  core.String title;
  /**
   * Last modified time of this bookshelf (formatted UTC timestamp with
   * millisecond resolution).
   */
  core.DateTime updated;
  /** Number of volumes in this bookshelf. */
  core.int volumeCount;
  /**
   * Last time a volume was added or removed from this bookshelf (formatted UTC
   * timestamp with millisecond resolution).
   */
  core.DateTime volumesLastUpdated;

  Bookshelf();

  Bookshelf.fromJson(core.Map _json) {
    if (_json.containsKey("access")) {
      access = _json["access"];
    }
    if (_json.containsKey("created")) {
      created = core.DateTime.parse(_json["created"]);
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
    if (_json.containsKey("volumeCount")) {
      volumeCount = _json["volumeCount"];
    }
    if (_json.containsKey("volumesLastUpdated")) {
      volumesLastUpdated = core.DateTime.parse(_json["volumesLastUpdated"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (access != null) {
      _json["access"] = access;
    }
    if (created != null) {
      _json["created"] = (created).toIso8601String();
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    if (volumeCount != null) {
      _json["volumeCount"] = volumeCount;
    }
    if (volumesLastUpdated != null) {
      _json["volumesLastUpdated"] = (volumesLastUpdated).toIso8601String();
    }
    return _json;
  }
}

class Bookshelves {
  /** A list of bookshelves. */
  core.List<Bookshelf> items;
  /** Resource type. */
  core.String kind;

  Bookshelves();

  Bookshelves.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Bookshelf.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
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
    return _json;
  }
}

class CategoryItems {
  core.String badgeUrl;
  core.String categoryId;
  core.String name;

  CategoryItems();

  CategoryItems.fromJson(core.Map _json) {
    if (_json.containsKey("badgeUrl")) {
      badgeUrl = _json["badgeUrl"];
    }
    if (_json.containsKey("categoryId")) {
      categoryId = _json["categoryId"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (badgeUrl != null) {
      _json["badgeUrl"] = badgeUrl;
    }
    if (categoryId != null) {
      _json["categoryId"] = categoryId;
    }
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

class Category {
  /** A list of onboarding categories. */
  core.List<CategoryItems> items;
  /** Resource type. */
  core.String kind;

  Category();

  Category.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new CategoryItems.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
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
    return _json;
  }
}

class ConcurrentAccessRestriction {
  /** Whether access is granted for this (user, device, volume). */
  core.bool deviceAllowed;
  /** Resource type. */
  core.String kind;
  /** The maximum number of concurrent access licenses for this volume. */
  core.int maxConcurrentDevices;
  /** Error/warning message. */
  core.String message;
  /**
   * Client nonce for verification. Download access and client-validation only.
   */
  core.String nonce;
  /** Error/warning reason code. */
  core.String reasonCode;
  /** Whether this volume has any concurrent access restrictions. */
  core.bool restricted;
  /** Response signature. */
  core.String signature;
  /**
   * Client app identifier for verification. Download access and
   * client-validation only.
   */
  core.String source;
  /** Time in seconds for license auto-expiration. */
  core.int timeWindowSeconds;
  /** Identifies the volume for which this entry applies. */
  core.String volumeId;

  ConcurrentAccessRestriction();

  ConcurrentAccessRestriction.fromJson(core.Map _json) {
    if (_json.containsKey("deviceAllowed")) {
      deviceAllowed = _json["deviceAllowed"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("maxConcurrentDevices")) {
      maxConcurrentDevices = _json["maxConcurrentDevices"];
    }
    if (_json.containsKey("message")) {
      message = _json["message"];
    }
    if (_json.containsKey("nonce")) {
      nonce = _json["nonce"];
    }
    if (_json.containsKey("reasonCode")) {
      reasonCode = _json["reasonCode"];
    }
    if (_json.containsKey("restricted")) {
      restricted = _json["restricted"];
    }
    if (_json.containsKey("signature")) {
      signature = _json["signature"];
    }
    if (_json.containsKey("source")) {
      source = _json["source"];
    }
    if (_json.containsKey("timeWindowSeconds")) {
      timeWindowSeconds = _json["timeWindowSeconds"];
    }
    if (_json.containsKey("volumeId")) {
      volumeId = _json["volumeId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deviceAllowed != null) {
      _json["deviceAllowed"] = deviceAllowed;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (maxConcurrentDevices != null) {
      _json["maxConcurrentDevices"] = maxConcurrentDevices;
    }
    if (message != null) {
      _json["message"] = message;
    }
    if (nonce != null) {
      _json["nonce"] = nonce;
    }
    if (reasonCode != null) {
      _json["reasonCode"] = reasonCode;
    }
    if (restricted != null) {
      _json["restricted"] = restricted;
    }
    if (signature != null) {
      _json["signature"] = signature;
    }
    if (source != null) {
      _json["source"] = source;
    }
    if (timeWindowSeconds != null) {
      _json["timeWindowSeconds"] = timeWindowSeconds;
    }
    if (volumeId != null) {
      _json["volumeId"] = volumeId;
    }
    return _json;
  }
}

class DictlayerdataCommon {
  /**
   * The display title and localized canonical name to use when searching for
   * this entity on Google search.
   */
  core.String title;

  DictlayerdataCommon();

  DictlayerdataCommon.fromJson(core.Map _json) {
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

/** The source, url and attribution for this dictionary data. */
class DictlayerdataDictSource {
  core.String attribution;
  core.String url;

  DictlayerdataDictSource();

  DictlayerdataDictSource.fromJson(core.Map _json) {
    if (_json.containsKey("attribution")) {
      attribution = _json["attribution"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (attribution != null) {
      _json["attribution"] = attribution;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

class DictlayerdataDictWordsDerivativesSource {
  core.String attribution;
  core.String url;

  DictlayerdataDictWordsDerivativesSource();

  DictlayerdataDictWordsDerivativesSource.fromJson(core.Map _json) {
    if (_json.containsKey("attribution")) {
      attribution = _json["attribution"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (attribution != null) {
      _json["attribution"] = attribution;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

class DictlayerdataDictWordsDerivatives {
  DictlayerdataDictWordsDerivativesSource source;
  core.String text;

  DictlayerdataDictWordsDerivatives();

  DictlayerdataDictWordsDerivatives.fromJson(core.Map _json) {
    if (_json.containsKey("source")) {
      source = new DictlayerdataDictWordsDerivativesSource.fromJson(_json["source"]);
    }
    if (_json.containsKey("text")) {
      text = _json["text"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (source != null) {
      _json["source"] = (source).toJson();
    }
    if (text != null) {
      _json["text"] = text;
    }
    return _json;
  }
}

class DictlayerdataDictWordsExamplesSource {
  core.String attribution;
  core.String url;

  DictlayerdataDictWordsExamplesSource();

  DictlayerdataDictWordsExamplesSource.fromJson(core.Map _json) {
    if (_json.containsKey("attribution")) {
      attribution = _json["attribution"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (attribution != null) {
      _json["attribution"] = attribution;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

class DictlayerdataDictWordsExamples {
  DictlayerdataDictWordsExamplesSource source;
  core.String text;

  DictlayerdataDictWordsExamples();

  DictlayerdataDictWordsExamples.fromJson(core.Map _json) {
    if (_json.containsKey("source")) {
      source = new DictlayerdataDictWordsExamplesSource.fromJson(_json["source"]);
    }
    if (_json.containsKey("text")) {
      text = _json["text"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (source != null) {
      _json["source"] = (source).toJson();
    }
    if (text != null) {
      _json["text"] = text;
    }
    return _json;
  }
}

class DictlayerdataDictWordsSensesConjugations {
  core.String type;
  core.String value;

  DictlayerdataDictWordsSensesConjugations();

  DictlayerdataDictWordsSensesConjugations.fromJson(core.Map _json) {
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("value")) {
      value = _json["value"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (type != null) {
      _json["type"] = type;
    }
    if (value != null) {
      _json["value"] = value;
    }
    return _json;
  }
}

class DictlayerdataDictWordsSensesDefinitionsExamplesSource {
  core.String attribution;
  core.String url;

  DictlayerdataDictWordsSensesDefinitionsExamplesSource();

  DictlayerdataDictWordsSensesDefinitionsExamplesSource.fromJson(core.Map _json) {
    if (_json.containsKey("attribution")) {
      attribution = _json["attribution"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (attribution != null) {
      _json["attribution"] = attribution;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

class DictlayerdataDictWordsSensesDefinitionsExamples {
  DictlayerdataDictWordsSensesDefinitionsExamplesSource source;
  core.String text;

  DictlayerdataDictWordsSensesDefinitionsExamples();

  DictlayerdataDictWordsSensesDefinitionsExamples.fromJson(core.Map _json) {
    if (_json.containsKey("source")) {
      source = new DictlayerdataDictWordsSensesDefinitionsExamplesSource.fromJson(_json["source"]);
    }
    if (_json.containsKey("text")) {
      text = _json["text"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (source != null) {
      _json["source"] = (source).toJson();
    }
    if (text != null) {
      _json["text"] = text;
    }
    return _json;
  }
}

class DictlayerdataDictWordsSensesDefinitions {
  core.String definition;
  core.List<DictlayerdataDictWordsSensesDefinitionsExamples> examples;

  DictlayerdataDictWordsSensesDefinitions();

  DictlayerdataDictWordsSensesDefinitions.fromJson(core.Map _json) {
    if (_json.containsKey("definition")) {
      definition = _json["definition"];
    }
    if (_json.containsKey("examples")) {
      examples = _json["examples"].map((value) => new DictlayerdataDictWordsSensesDefinitionsExamples.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (definition != null) {
      _json["definition"] = definition;
    }
    if (examples != null) {
      _json["examples"] = examples.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class DictlayerdataDictWordsSensesSource {
  core.String attribution;
  core.String url;

  DictlayerdataDictWordsSensesSource();

  DictlayerdataDictWordsSensesSource.fromJson(core.Map _json) {
    if (_json.containsKey("attribution")) {
      attribution = _json["attribution"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (attribution != null) {
      _json["attribution"] = attribution;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

class DictlayerdataDictWordsSensesSynonymsSource {
  core.String attribution;
  core.String url;

  DictlayerdataDictWordsSensesSynonymsSource();

  DictlayerdataDictWordsSensesSynonymsSource.fromJson(core.Map _json) {
    if (_json.containsKey("attribution")) {
      attribution = _json["attribution"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (attribution != null) {
      _json["attribution"] = attribution;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

class DictlayerdataDictWordsSensesSynonyms {
  DictlayerdataDictWordsSensesSynonymsSource source;
  core.String text;

  DictlayerdataDictWordsSensesSynonyms();

  DictlayerdataDictWordsSensesSynonyms.fromJson(core.Map _json) {
    if (_json.containsKey("source")) {
      source = new DictlayerdataDictWordsSensesSynonymsSource.fromJson(_json["source"]);
    }
    if (_json.containsKey("text")) {
      text = _json["text"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (source != null) {
      _json["source"] = (source).toJson();
    }
    if (text != null) {
      _json["text"] = text;
    }
    return _json;
  }
}

class DictlayerdataDictWordsSenses {
  core.List<DictlayerdataDictWordsSensesConjugations> conjugations;
  core.List<DictlayerdataDictWordsSensesDefinitions> definitions;
  core.String partOfSpeech;
  core.String pronunciation;
  core.String pronunciationUrl;
  DictlayerdataDictWordsSensesSource source;
  core.String syllabification;
  core.List<DictlayerdataDictWordsSensesSynonyms> synonyms;

  DictlayerdataDictWordsSenses();

  DictlayerdataDictWordsSenses.fromJson(core.Map _json) {
    if (_json.containsKey("conjugations")) {
      conjugations = _json["conjugations"].map((value) => new DictlayerdataDictWordsSensesConjugations.fromJson(value)).toList();
    }
    if (_json.containsKey("definitions")) {
      definitions = _json["definitions"].map((value) => new DictlayerdataDictWordsSensesDefinitions.fromJson(value)).toList();
    }
    if (_json.containsKey("partOfSpeech")) {
      partOfSpeech = _json["partOfSpeech"];
    }
    if (_json.containsKey("pronunciation")) {
      pronunciation = _json["pronunciation"];
    }
    if (_json.containsKey("pronunciationUrl")) {
      pronunciationUrl = _json["pronunciationUrl"];
    }
    if (_json.containsKey("source")) {
      source = new DictlayerdataDictWordsSensesSource.fromJson(_json["source"]);
    }
    if (_json.containsKey("syllabification")) {
      syllabification = _json["syllabification"];
    }
    if (_json.containsKey("synonyms")) {
      synonyms = _json["synonyms"].map((value) => new DictlayerdataDictWordsSensesSynonyms.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (conjugations != null) {
      _json["conjugations"] = conjugations.map((value) => (value).toJson()).toList();
    }
    if (definitions != null) {
      _json["definitions"] = definitions.map((value) => (value).toJson()).toList();
    }
    if (partOfSpeech != null) {
      _json["partOfSpeech"] = partOfSpeech;
    }
    if (pronunciation != null) {
      _json["pronunciation"] = pronunciation;
    }
    if (pronunciationUrl != null) {
      _json["pronunciationUrl"] = pronunciationUrl;
    }
    if (source != null) {
      _json["source"] = (source).toJson();
    }
    if (syllabification != null) {
      _json["syllabification"] = syllabification;
    }
    if (synonyms != null) {
      _json["synonyms"] = synonyms.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * The words with different meanings but not related words, e.g. "go" (game) and
 * "go" (verb).
 */
class DictlayerdataDictWordsSource {
  core.String attribution;
  core.String url;

  DictlayerdataDictWordsSource();

  DictlayerdataDictWordsSource.fromJson(core.Map _json) {
    if (_json.containsKey("attribution")) {
      attribution = _json["attribution"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (attribution != null) {
      _json["attribution"] = attribution;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

class DictlayerdataDictWords {
  core.List<DictlayerdataDictWordsDerivatives> derivatives;
  core.List<DictlayerdataDictWordsExamples> examples;
  core.List<DictlayerdataDictWordsSenses> senses;
  /**
   * The words with different meanings but not related words, e.g. "go" (game)
   * and "go" (verb).
   */
  DictlayerdataDictWordsSource source;

  DictlayerdataDictWords();

  DictlayerdataDictWords.fromJson(core.Map _json) {
    if (_json.containsKey("derivatives")) {
      derivatives = _json["derivatives"].map((value) => new DictlayerdataDictWordsDerivatives.fromJson(value)).toList();
    }
    if (_json.containsKey("examples")) {
      examples = _json["examples"].map((value) => new DictlayerdataDictWordsExamples.fromJson(value)).toList();
    }
    if (_json.containsKey("senses")) {
      senses = _json["senses"].map((value) => new DictlayerdataDictWordsSenses.fromJson(value)).toList();
    }
    if (_json.containsKey("source")) {
      source = new DictlayerdataDictWordsSource.fromJson(_json["source"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (derivatives != null) {
      _json["derivatives"] = derivatives.map((value) => (value).toJson()).toList();
    }
    if (examples != null) {
      _json["examples"] = examples.map((value) => (value).toJson()).toList();
    }
    if (senses != null) {
      _json["senses"] = senses.map((value) => (value).toJson()).toList();
    }
    if (source != null) {
      _json["source"] = (source).toJson();
    }
    return _json;
  }
}

class DictlayerdataDict {
  /** The source, url and attribution for this dictionary data. */
  DictlayerdataDictSource source;
  core.List<DictlayerdataDictWords> words;

  DictlayerdataDict();

  DictlayerdataDict.fromJson(core.Map _json) {
    if (_json.containsKey("source")) {
      source = new DictlayerdataDictSource.fromJson(_json["source"]);
    }
    if (_json.containsKey("words")) {
      words = _json["words"].map((value) => new DictlayerdataDictWords.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (source != null) {
      _json["source"] = (source).toJson();
    }
    if (words != null) {
      _json["words"] = words.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class Dictlayerdata {
  DictlayerdataCommon common;
  DictlayerdataDict dict;
  core.String kind;

  Dictlayerdata();

  Dictlayerdata.fromJson(core.Map _json) {
    if (_json.containsKey("common")) {
      common = new DictlayerdataCommon.fromJson(_json["common"]);
    }
    if (_json.containsKey("dict")) {
      dict = new DictlayerdataDict.fromJson(_json["dict"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (common != null) {
      _json["common"] = (common).toJson();
    }
    if (dict != null) {
      _json["dict"] = (dict).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class DiscoveryclustersClustersBannerWithContentContainer {
  core.String fillColorArgb;
  core.String imageUrl;
  core.String maskColorArgb;
  core.String moreButtonText;
  core.String moreButtonUrl;
  core.String textColorArgb;

  DiscoveryclustersClustersBannerWithContentContainer();

  DiscoveryclustersClustersBannerWithContentContainer.fromJson(core.Map _json) {
    if (_json.containsKey("fillColorArgb")) {
      fillColorArgb = _json["fillColorArgb"];
    }
    if (_json.containsKey("imageUrl")) {
      imageUrl = _json["imageUrl"];
    }
    if (_json.containsKey("maskColorArgb")) {
      maskColorArgb = _json["maskColorArgb"];
    }
    if (_json.containsKey("moreButtonText")) {
      moreButtonText = _json["moreButtonText"];
    }
    if (_json.containsKey("moreButtonUrl")) {
      moreButtonUrl = _json["moreButtonUrl"];
    }
    if (_json.containsKey("textColorArgb")) {
      textColorArgb = _json["textColorArgb"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (fillColorArgb != null) {
      _json["fillColorArgb"] = fillColorArgb;
    }
    if (imageUrl != null) {
      _json["imageUrl"] = imageUrl;
    }
    if (maskColorArgb != null) {
      _json["maskColorArgb"] = maskColorArgb;
    }
    if (moreButtonText != null) {
      _json["moreButtonText"] = moreButtonText;
    }
    if (moreButtonUrl != null) {
      _json["moreButtonUrl"] = moreButtonUrl;
    }
    if (textColorArgb != null) {
      _json["textColorArgb"] = textColorArgb;
    }
    return _json;
  }
}

class DiscoveryclustersClusters {
  DiscoveryclustersClustersBannerWithContentContainer bannerWithContentContainer;
  core.String subTitle;
  core.String title;
  core.int totalVolumes;
  core.String uid;
  core.List<Volume> volumes;

  DiscoveryclustersClusters();

  DiscoveryclustersClusters.fromJson(core.Map _json) {
    if (_json.containsKey("banner_with_content_container")) {
      bannerWithContentContainer = new DiscoveryclustersClustersBannerWithContentContainer.fromJson(_json["banner_with_content_container"]);
    }
    if (_json.containsKey("subTitle")) {
      subTitle = _json["subTitle"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("totalVolumes")) {
      totalVolumes = _json["totalVolumes"];
    }
    if (_json.containsKey("uid")) {
      uid = _json["uid"];
    }
    if (_json.containsKey("volumes")) {
      volumes = _json["volumes"].map((value) => new Volume.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (bannerWithContentContainer != null) {
      _json["banner_with_content_container"] = (bannerWithContentContainer).toJson();
    }
    if (subTitle != null) {
      _json["subTitle"] = subTitle;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (totalVolumes != null) {
      _json["totalVolumes"] = totalVolumes;
    }
    if (uid != null) {
      _json["uid"] = uid;
    }
    if (volumes != null) {
      _json["volumes"] = volumes.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class Discoveryclusters {
  core.List<DiscoveryclustersClusters> clusters;
  /** Resorce type. */
  core.String kind;
  core.int totalClusters;

  Discoveryclusters();

  Discoveryclusters.fromJson(core.Map _json) {
    if (_json.containsKey("clusters")) {
      clusters = _json["clusters"].map((value) => new DiscoveryclustersClusters.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("totalClusters")) {
      totalClusters = _json["totalClusters"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (clusters != null) {
      _json["clusters"] = clusters.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (totalClusters != null) {
      _json["totalClusters"] = totalClusters;
    }
    return _json;
  }
}

class DownloadAccessRestriction {
  /**
   * If restricted, whether access is granted for this (user, device, volume).
   */
  core.bool deviceAllowed;
  /**
   * If restricted, the number of content download licenses already acquired
   * (including the requesting client, if licensed).
   */
  core.int downloadsAcquired;
  /** If deviceAllowed, whether access was just acquired with this request. */
  core.bool justAcquired;
  /** Resource type. */
  core.String kind;
  /**
   * If restricted, the maximum number of content download licenses for this
   * volume.
   */
  core.int maxDownloadDevices;
  /** Error/warning message. */
  core.String message;
  /**
   * Client nonce for verification. Download access and client-validation only.
   */
  core.String nonce;
  /**
   * Error/warning reason code. Additional codes may be added in the future. 0
   * OK 100 ACCESS_DENIED_PUBLISHER_LIMIT 101 ACCESS_DENIED_LIMIT 200
   * WARNING_USED_LAST_ACCESS
   */
  core.String reasonCode;
  /** Whether this volume has any download access restrictions. */
  core.bool restricted;
  /** Response signature. */
  core.String signature;
  /**
   * Client app identifier for verification. Download access and
   * client-validation only.
   */
  core.String source;
  /** Identifies the volume for which this entry applies. */
  core.String volumeId;

  DownloadAccessRestriction();

  DownloadAccessRestriction.fromJson(core.Map _json) {
    if (_json.containsKey("deviceAllowed")) {
      deviceAllowed = _json["deviceAllowed"];
    }
    if (_json.containsKey("downloadsAcquired")) {
      downloadsAcquired = _json["downloadsAcquired"];
    }
    if (_json.containsKey("justAcquired")) {
      justAcquired = _json["justAcquired"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("maxDownloadDevices")) {
      maxDownloadDevices = _json["maxDownloadDevices"];
    }
    if (_json.containsKey("message")) {
      message = _json["message"];
    }
    if (_json.containsKey("nonce")) {
      nonce = _json["nonce"];
    }
    if (_json.containsKey("reasonCode")) {
      reasonCode = _json["reasonCode"];
    }
    if (_json.containsKey("restricted")) {
      restricted = _json["restricted"];
    }
    if (_json.containsKey("signature")) {
      signature = _json["signature"];
    }
    if (_json.containsKey("source")) {
      source = _json["source"];
    }
    if (_json.containsKey("volumeId")) {
      volumeId = _json["volumeId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deviceAllowed != null) {
      _json["deviceAllowed"] = deviceAllowed;
    }
    if (downloadsAcquired != null) {
      _json["downloadsAcquired"] = downloadsAcquired;
    }
    if (justAcquired != null) {
      _json["justAcquired"] = justAcquired;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (maxDownloadDevices != null) {
      _json["maxDownloadDevices"] = maxDownloadDevices;
    }
    if (message != null) {
      _json["message"] = message;
    }
    if (nonce != null) {
      _json["nonce"] = nonce;
    }
    if (reasonCode != null) {
      _json["reasonCode"] = reasonCode;
    }
    if (restricted != null) {
      _json["restricted"] = restricted;
    }
    if (signature != null) {
      _json["signature"] = signature;
    }
    if (source != null) {
      _json["source"] = source;
    }
    if (volumeId != null) {
      _json["volumeId"] = volumeId;
    }
    return _json;
  }
}

class DownloadAccesses {
  /** A list of download access responses. */
  core.List<DownloadAccessRestriction> downloadAccessList;
  /** Resource type. */
  core.String kind;

  DownloadAccesses();

  DownloadAccesses.fromJson(core.Map _json) {
    if (_json.containsKey("downloadAccessList")) {
      downloadAccessList = _json["downloadAccessList"].map((value) => new DownloadAccessRestriction.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (downloadAccessList != null) {
      _json["downloadAccessList"] = downloadAccessList.map((value) => (value).toJson()).toList();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class GeolayerdataCommon {
  /** The language of the information url and description. */
  core.String lang;
  /** The URL for the preview image information. */
  core.String previewImageUrl;
  /** The description for this location. */
  core.String snippet;
  /** The URL for information for this location. Ex: wikipedia link. */
  core.String snippetUrl;
  /**
   * The display title and localized canonical name to use when searching for
   * this entity on Google search.
   */
  core.String title;

  GeolayerdataCommon();

  GeolayerdataCommon.fromJson(core.Map _json) {
    if (_json.containsKey("lang")) {
      lang = _json["lang"];
    }
    if (_json.containsKey("previewImageUrl")) {
      previewImageUrl = _json["previewImageUrl"];
    }
    if (_json.containsKey("snippet")) {
      snippet = _json["snippet"];
    }
    if (_json.containsKey("snippetUrl")) {
      snippetUrl = _json["snippetUrl"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (lang != null) {
      _json["lang"] = lang;
    }
    if (previewImageUrl != null) {
      _json["previewImageUrl"] = previewImageUrl;
    }
    if (snippet != null) {
      _json["snippet"] = snippet;
    }
    if (snippetUrl != null) {
      _json["snippetUrl"] = snippetUrl;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

class GeolayerdataGeoBoundary {
  core.int latitude;
  core.int longitude;

  GeolayerdataGeoBoundary();

  GeolayerdataGeoBoundary.fromJson(core.Map _json) {
    if (_json.containsKey("latitude")) {
      latitude = _json["latitude"];
    }
    if (_json.containsKey("longitude")) {
      longitude = _json["longitude"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (latitude != null) {
      _json["latitude"] = latitude;
    }
    if (longitude != null) {
      _json["longitude"] = longitude;
    }
    return _json;
  }
}

class GeolayerdataGeoViewportHi {
  core.double latitude;
  core.double longitude;

  GeolayerdataGeoViewportHi();

  GeolayerdataGeoViewportHi.fromJson(core.Map _json) {
    if (_json.containsKey("latitude")) {
      latitude = _json["latitude"];
    }
    if (_json.containsKey("longitude")) {
      longitude = _json["longitude"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (latitude != null) {
      _json["latitude"] = latitude;
    }
    if (longitude != null) {
      _json["longitude"] = longitude;
    }
    return _json;
  }
}

class GeolayerdataGeoViewportLo {
  core.double latitude;
  core.double longitude;

  GeolayerdataGeoViewportLo();

  GeolayerdataGeoViewportLo.fromJson(core.Map _json) {
    if (_json.containsKey("latitude")) {
      latitude = _json["latitude"];
    }
    if (_json.containsKey("longitude")) {
      longitude = _json["longitude"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (latitude != null) {
      _json["latitude"] = latitude;
    }
    if (longitude != null) {
      _json["longitude"] = longitude;
    }
    return _json;
  }
}

/**
 * The viewport for showing this location. This is a latitude, longitude
 * rectangle.
 */
class GeolayerdataGeoViewport {
  GeolayerdataGeoViewportHi hi;
  GeolayerdataGeoViewportLo lo;

  GeolayerdataGeoViewport();

  GeolayerdataGeoViewport.fromJson(core.Map _json) {
    if (_json.containsKey("hi")) {
      hi = new GeolayerdataGeoViewportHi.fromJson(_json["hi"]);
    }
    if (_json.containsKey("lo")) {
      lo = new GeolayerdataGeoViewportLo.fromJson(_json["lo"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (hi != null) {
      _json["hi"] = (hi).toJson();
    }
    if (lo != null) {
      _json["lo"] = (lo).toJson();
    }
    return _json;
  }
}

class GeolayerdataGeo {
  /**
   * The boundary of the location as a set of loops containing pairs of
   * latitude, longitude coordinates.
   */
  core.List<core.List<GeolayerdataGeoBoundary>> boundary;
  /**
   * The cache policy active for this data. EX: UNRESTRICTED, RESTRICTED, NEVER
   */
  core.String cachePolicy;
  /** The country code of the location. */
  core.String countryCode;
  /** The latitude of the location. */
  core.double latitude;
  /** The longitude of the location. */
  core.double longitude;
  /**
   * The type of map that should be used for this location. EX: HYBRID, ROADMAP,
   * SATELLITE, TERRAIN
   */
  core.String mapType;
  /**
   * The viewport for showing this location. This is a latitude, longitude
   * rectangle.
   */
  GeolayerdataGeoViewport viewport;
  /**
   * The Zoom level to use for the map. Zoom levels between 0 (the lowest zoom
   * level, in which the entire world can be seen on one map) to 21+ (down to
   * individual buildings). See:
   * https://developers.google.com/maps/documentation/staticmaps/#Zoomlevels
   */
  core.int zoom;

  GeolayerdataGeo();

  GeolayerdataGeo.fromJson(core.Map _json) {
    if (_json.containsKey("boundary")) {
      boundary = _json["boundary"].map((value) => value.map((value) => new GeolayerdataGeoBoundary.fromJson(value)).toList()).toList();
    }
    if (_json.containsKey("cachePolicy")) {
      cachePolicy = _json["cachePolicy"];
    }
    if (_json.containsKey("countryCode")) {
      countryCode = _json["countryCode"];
    }
    if (_json.containsKey("latitude")) {
      latitude = _json["latitude"];
    }
    if (_json.containsKey("longitude")) {
      longitude = _json["longitude"];
    }
    if (_json.containsKey("mapType")) {
      mapType = _json["mapType"];
    }
    if (_json.containsKey("viewport")) {
      viewport = new GeolayerdataGeoViewport.fromJson(_json["viewport"]);
    }
    if (_json.containsKey("zoom")) {
      zoom = _json["zoom"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (boundary != null) {
      _json["boundary"] = boundary.map((value) => value.map((value) => (value).toJson()).toList()).toList();
    }
    if (cachePolicy != null) {
      _json["cachePolicy"] = cachePolicy;
    }
    if (countryCode != null) {
      _json["countryCode"] = countryCode;
    }
    if (latitude != null) {
      _json["latitude"] = latitude;
    }
    if (longitude != null) {
      _json["longitude"] = longitude;
    }
    if (mapType != null) {
      _json["mapType"] = mapType;
    }
    if (viewport != null) {
      _json["viewport"] = (viewport).toJson();
    }
    if (zoom != null) {
      _json["zoom"] = zoom;
    }
    return _json;
  }
}

class Geolayerdata {
  GeolayerdataCommon common;
  GeolayerdataGeo geo;
  core.String kind;

  Geolayerdata();

  Geolayerdata.fromJson(core.Map _json) {
    if (_json.containsKey("common")) {
      common = new GeolayerdataCommon.fromJson(_json["common"]);
    }
    if (_json.containsKey("geo")) {
      geo = new GeolayerdataGeo.fromJson(_json["geo"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (common != null) {
      _json["common"] = (common).toJson();
    }
    if (geo != null) {
      _json["geo"] = (geo).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

class Layersummaries {
  /** A list of layer summary items. */
  core.List<Layersummary> items;
  /** Resource type. */
  core.String kind;
  /** The total number of layer summaries found. */
  core.int totalItems;

  Layersummaries();

  Layersummaries.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Layersummary.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("totalItems")) {
      totalItems = _json["totalItems"];
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
    if (totalItems != null) {
      _json["totalItems"] = totalItems;
    }
    return _json;
  }
}

class Layersummary {
  /** The number of annotations for this layer. */
  core.int annotationCount;
  /** The list of annotation types contained for this layer. */
  core.List<core.String> annotationTypes;
  /** Link to get data for this annotation. */
  core.String annotationsDataLink;
  /** The link to get the annotations for this layer. */
  core.String annotationsLink;
  /** The content version this resource is for. */
  core.String contentVersion;
  /** The number of data items for this layer. */
  core.int dataCount;
  /** Unique id of this layer summary. */
  core.String id;
  /** Resource Type */
  core.String kind;
  /** The layer id for this summary. */
  core.String layerId;
  /** URL to this resource. */
  core.String selfLink;
  /**
   * Timestamp for the last time an item in this layer was updated. (RFC 3339
   * UTC date-time format).
   */
  core.DateTime updated;
  /**
   * The current version of this layer's volume annotations. Note that this
   * version applies only to the data in the books.layers.volumeAnnotations.*
   * responses. The actual annotation data is versioned separately.
   */
  core.String volumeAnnotationsVersion;
  /** The volume id this resource is for. */
  core.String volumeId;

  Layersummary();

  Layersummary.fromJson(core.Map _json) {
    if (_json.containsKey("annotationCount")) {
      annotationCount = _json["annotationCount"];
    }
    if (_json.containsKey("annotationTypes")) {
      annotationTypes = _json["annotationTypes"];
    }
    if (_json.containsKey("annotationsDataLink")) {
      annotationsDataLink = _json["annotationsDataLink"];
    }
    if (_json.containsKey("annotationsLink")) {
      annotationsLink = _json["annotationsLink"];
    }
    if (_json.containsKey("contentVersion")) {
      contentVersion = _json["contentVersion"];
    }
    if (_json.containsKey("dataCount")) {
      dataCount = _json["dataCount"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("layerId")) {
      layerId = _json["layerId"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
    if (_json.containsKey("volumeAnnotationsVersion")) {
      volumeAnnotationsVersion = _json["volumeAnnotationsVersion"];
    }
    if (_json.containsKey("volumeId")) {
      volumeId = _json["volumeId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (annotationCount != null) {
      _json["annotationCount"] = annotationCount;
    }
    if (annotationTypes != null) {
      _json["annotationTypes"] = annotationTypes;
    }
    if (annotationsDataLink != null) {
      _json["annotationsDataLink"] = annotationsDataLink;
    }
    if (annotationsLink != null) {
      _json["annotationsLink"] = annotationsLink;
    }
    if (contentVersion != null) {
      _json["contentVersion"] = contentVersion;
    }
    if (dataCount != null) {
      _json["dataCount"] = dataCount;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (layerId != null) {
      _json["layerId"] = layerId;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    if (volumeAnnotationsVersion != null) {
      _json["volumeAnnotationsVersion"] = volumeAnnotationsVersion;
    }
    if (volumeId != null) {
      _json["volumeId"] = volumeId;
    }
    return _json;
  }
}

class MetadataItems {
  core.String downloadUrl;
  core.String encryptedKey;
  core.String language;
  core.String size;
  core.String version;

  MetadataItems();

  MetadataItems.fromJson(core.Map _json) {
    if (_json.containsKey("download_url")) {
      downloadUrl = _json["download_url"];
    }
    if (_json.containsKey("encrypted_key")) {
      encryptedKey = _json["encrypted_key"];
    }
    if (_json.containsKey("language")) {
      language = _json["language"];
    }
    if (_json.containsKey("size")) {
      size = _json["size"];
    }
    if (_json.containsKey("version")) {
      version = _json["version"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (downloadUrl != null) {
      _json["download_url"] = downloadUrl;
    }
    if (encryptedKey != null) {
      _json["encrypted_key"] = encryptedKey;
    }
    if (language != null) {
      _json["language"] = language;
    }
    if (size != null) {
      _json["size"] = size;
    }
    if (version != null) {
      _json["version"] = version;
    }
    return _json;
  }
}

class Metadata {
  /** A list of offline dictionary metadata. */
  core.List<MetadataItems> items;
  /** Resource type. */
  core.String kind;

  Metadata();

  Metadata.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new MetadataItems.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
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
    return _json;
  }
}

class Notification {
  core.String body;
  /** The list of crm experiment ids. */
  core.List<core.String> crmExperimentIds;
  core.String docId;
  core.String docType;
  core.bool dontShowNotification;
  core.String iconUrl;
  /** Resource type. */
  core.String kind;
  core.String notificationGroup;
  core.String notificationType;
  core.String pcampaignId;
  core.String reason;
  core.bool showNotificationSettingsAction;
  core.String targetUrl;
  core.String title;

  Notification();

  Notification.fromJson(core.Map _json) {
    if (_json.containsKey("body")) {
      body = _json["body"];
    }
    if (_json.containsKey("crmExperimentIds")) {
      crmExperimentIds = _json["crmExperimentIds"];
    }
    if (_json.containsKey("doc_id")) {
      docId = _json["doc_id"];
    }
    if (_json.containsKey("doc_type")) {
      docType = _json["doc_type"];
    }
    if (_json.containsKey("dont_show_notification")) {
      dontShowNotification = _json["dont_show_notification"];
    }
    if (_json.containsKey("iconUrl")) {
      iconUrl = _json["iconUrl"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("notificationGroup")) {
      notificationGroup = _json["notificationGroup"];
    }
    if (_json.containsKey("notification_type")) {
      notificationType = _json["notification_type"];
    }
    if (_json.containsKey("pcampaign_id")) {
      pcampaignId = _json["pcampaign_id"];
    }
    if (_json.containsKey("reason")) {
      reason = _json["reason"];
    }
    if (_json.containsKey("show_notification_settings_action")) {
      showNotificationSettingsAction = _json["show_notification_settings_action"];
    }
    if (_json.containsKey("targetUrl")) {
      targetUrl = _json["targetUrl"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (body != null) {
      _json["body"] = body;
    }
    if (crmExperimentIds != null) {
      _json["crmExperimentIds"] = crmExperimentIds;
    }
    if (docId != null) {
      _json["doc_id"] = docId;
    }
    if (docType != null) {
      _json["doc_type"] = docType;
    }
    if (dontShowNotification != null) {
      _json["dont_show_notification"] = dontShowNotification;
    }
    if (iconUrl != null) {
      _json["iconUrl"] = iconUrl;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (notificationGroup != null) {
      _json["notificationGroup"] = notificationGroup;
    }
    if (notificationType != null) {
      _json["notification_type"] = notificationType;
    }
    if (pcampaignId != null) {
      _json["pcampaign_id"] = pcampaignId;
    }
    if (reason != null) {
      _json["reason"] = reason;
    }
    if (showNotificationSettingsAction != null) {
      _json["show_notification_settings_action"] = showNotificationSettingsAction;
    }
    if (targetUrl != null) {
      _json["targetUrl"] = targetUrl;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

class OffersItemsItems {
  core.String author;
  core.String canonicalVolumeLink;
  core.String coverUrl;
  core.String description;
  core.String title;
  core.String volumeId;

  OffersItemsItems();

  OffersItemsItems.fromJson(core.Map _json) {
    if (_json.containsKey("author")) {
      author = _json["author"];
    }
    if (_json.containsKey("canonicalVolumeLink")) {
      canonicalVolumeLink = _json["canonicalVolumeLink"];
    }
    if (_json.containsKey("coverUrl")) {
      coverUrl = _json["coverUrl"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("volumeId")) {
      volumeId = _json["volumeId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (author != null) {
      _json["author"] = author;
    }
    if (canonicalVolumeLink != null) {
      _json["canonicalVolumeLink"] = canonicalVolumeLink;
    }
    if (coverUrl != null) {
      _json["coverUrl"] = coverUrl;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (volumeId != null) {
      _json["volumeId"] = volumeId;
    }
    return _json;
  }
}

class OffersItems {
  core.String artUrl;
  core.String gservicesKey;
  core.String id;
  core.List<OffersItemsItems> items;

  OffersItems();

  OffersItems.fromJson(core.Map _json) {
    if (_json.containsKey("artUrl")) {
      artUrl = _json["artUrl"];
    }
    if (_json.containsKey("gservicesKey")) {
      gservicesKey = _json["gservicesKey"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new OffersItemsItems.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (artUrl != null) {
      _json["artUrl"] = artUrl;
    }
    if (gservicesKey != null) {
      _json["gservicesKey"] = gservicesKey;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (items != null) {
      _json["items"] = items.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class Offers {
  /** A list of offers. */
  core.List<OffersItems> items;
  /** Resource type. */
  core.String kind;

  Offers();

  Offers.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new OffersItems.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
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
    return _json;
  }
}

class ReadingPosition {
  /** Position in an EPUB as a CFI. */
  core.String epubCfiPosition;
  /** Position in a volume for image-based content. */
  core.String gbImagePosition;
  /** Position in a volume for text-based content. */
  core.String gbTextPosition;
  /** Resource type for a reading position. */
  core.String kind;
  /** Position in a PDF file. */
  core.String pdfPosition;
  /**
   * Timestamp when this reading position was last updated (formatted UTC
   * timestamp with millisecond resolution).
   */
  core.DateTime updated;
  /** Volume id associated with this reading position. */
  core.String volumeId;

  ReadingPosition();

  ReadingPosition.fromJson(core.Map _json) {
    if (_json.containsKey("epubCfiPosition")) {
      epubCfiPosition = _json["epubCfiPosition"];
    }
    if (_json.containsKey("gbImagePosition")) {
      gbImagePosition = _json["gbImagePosition"];
    }
    if (_json.containsKey("gbTextPosition")) {
      gbTextPosition = _json["gbTextPosition"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("pdfPosition")) {
      pdfPosition = _json["pdfPosition"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
    if (_json.containsKey("volumeId")) {
      volumeId = _json["volumeId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (epubCfiPosition != null) {
      _json["epubCfiPosition"] = epubCfiPosition;
    }
    if (gbImagePosition != null) {
      _json["gbImagePosition"] = gbImagePosition;
    }
    if (gbTextPosition != null) {
      _json["gbTextPosition"] = gbTextPosition;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (pdfPosition != null) {
      _json["pdfPosition"] = pdfPosition;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    if (volumeId != null) {
      _json["volumeId"] = volumeId;
    }
    return _json;
  }
}

class RequestAccess {
  /** A concurrent access response. */
  ConcurrentAccessRestriction concurrentAccess;
  /** A download access response. */
  DownloadAccessRestriction downloadAccess;
  /** Resource type. */
  core.String kind;

  RequestAccess();

  RequestAccess.fromJson(core.Map _json) {
    if (_json.containsKey("concurrentAccess")) {
      concurrentAccess = new ConcurrentAccessRestriction.fromJson(_json["concurrentAccess"]);
    }
    if (_json.containsKey("downloadAccess")) {
      downloadAccess = new DownloadAccessRestriction.fromJson(_json["downloadAccess"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (concurrentAccess != null) {
      _json["concurrentAccess"] = (concurrentAccess).toJson();
    }
    if (downloadAccess != null) {
      _json["downloadAccess"] = (downloadAccess).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    return _json;
  }
}

/** Author of this review. */
class ReviewAuthor {
  /** Name of this person. */
  core.String displayName;

  ReviewAuthor();

  ReviewAuthor.fromJson(core.Map _json) {
    if (_json.containsKey("displayName")) {
      displayName = _json["displayName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (displayName != null) {
      _json["displayName"] = displayName;
    }
    return _json;
  }
}

/**
 * Information regarding the source of this review, when the review is not from
 * a Google Books user.
 */
class ReviewSource {
  /** Name of the source. */
  core.String description;
  /** Extra text about the source of the review. */
  core.String extraDescription;
  /** URL of the source of the review. */
  core.String url;

  ReviewSource();

  ReviewSource.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("extraDescription")) {
      extraDescription = _json["extraDescription"];
    }
    if (_json.containsKey("url")) {
      url = _json["url"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (extraDescription != null) {
      _json["extraDescription"] = extraDescription;
    }
    if (url != null) {
      _json["url"] = url;
    }
    return _json;
  }
}

class Review {
  /** Author of this review. */
  ReviewAuthor author;
  /** Review text. */
  core.String content;
  /** Date of this review. */
  core.String date;
  /** URL for the full review text, for reviews gathered from the web. */
  core.String fullTextUrl;
  /** Resource type for a review. */
  core.String kind;
  /**
   * Star rating for this review. Possible values are ONE, TWO, THREE, FOUR,
   * FIVE or NOT_RATED.
   */
  core.String rating;
  /**
   * Information regarding the source of this review, when the review is not
   * from a Google Books user.
   */
  ReviewSource source;
  /** Title for this review. */
  core.String title;
  /**
   * Source type for this review. Possible values are EDITORIAL, WEB_USER or
   * GOOGLE_USER.
   */
  core.String type;
  /** Volume that this review is for. */
  core.String volumeId;

  Review();

  Review.fromJson(core.Map _json) {
    if (_json.containsKey("author")) {
      author = new ReviewAuthor.fromJson(_json["author"]);
    }
    if (_json.containsKey("content")) {
      content = _json["content"];
    }
    if (_json.containsKey("date")) {
      date = _json["date"];
    }
    if (_json.containsKey("fullTextUrl")) {
      fullTextUrl = _json["fullTextUrl"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("rating")) {
      rating = _json["rating"];
    }
    if (_json.containsKey("source")) {
      source = new ReviewSource.fromJson(_json["source"]);
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("volumeId")) {
      volumeId = _json["volumeId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (author != null) {
      _json["author"] = (author).toJson();
    }
    if (content != null) {
      _json["content"] = content;
    }
    if (date != null) {
      _json["date"] = date;
    }
    if (fullTextUrl != null) {
      _json["fullTextUrl"] = fullTextUrl;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (rating != null) {
      _json["rating"] = rating;
    }
    if (source != null) {
      _json["source"] = (source).toJson();
    }
    if (title != null) {
      _json["title"] = title;
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (volumeId != null) {
      _json["volumeId"] = volumeId;
    }
    return _json;
  }
}

class SeriesSeries {
  core.String bannerImageUrl;
  core.String imageUrl;
  core.String seriesId;
  core.String seriesType;
  core.String title;

  SeriesSeries();

  SeriesSeries.fromJson(core.Map _json) {
    if (_json.containsKey("bannerImageUrl")) {
      bannerImageUrl = _json["bannerImageUrl"];
    }
    if (_json.containsKey("imageUrl")) {
      imageUrl = _json["imageUrl"];
    }
    if (_json.containsKey("seriesId")) {
      seriesId = _json["seriesId"];
    }
    if (_json.containsKey("seriesType")) {
      seriesType = _json["seriesType"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (bannerImageUrl != null) {
      _json["bannerImageUrl"] = bannerImageUrl;
    }
    if (imageUrl != null) {
      _json["imageUrl"] = imageUrl;
    }
    if (seriesId != null) {
      _json["seriesId"] = seriesId;
    }
    if (seriesType != null) {
      _json["seriesType"] = seriesType;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

class Series {
  /** Resource type. */
  core.String kind;
  core.List<SeriesSeries> series;

  Series();

  Series.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("series")) {
      series = _json["series"].map((value) => new SeriesSeries.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (series != null) {
      _json["series"] = series.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class Seriesmembership {
  /** Resorce type. */
  core.String kind;
  core.List<Volume> member;
  core.String nextPageToken;

  Seriesmembership();

  Seriesmembership.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("member")) {
      member = _json["member"].map((value) => new Volume.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (member != null) {
      _json["member"] = member.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** User settings in sub-objects, each for different purposes. */
class UsersettingsNotesExport {
  core.String folderName;
  core.bool isEnabled;

  UsersettingsNotesExport();

  UsersettingsNotesExport.fromJson(core.Map _json) {
    if (_json.containsKey("folderName")) {
      folderName = _json["folderName"];
    }
    if (_json.containsKey("isEnabled")) {
      isEnabled = _json["isEnabled"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (folderName != null) {
      _json["folderName"] = folderName;
    }
    if (isEnabled != null) {
      _json["isEnabled"] = isEnabled;
    }
    return _json;
  }
}

class UsersettingsNotificationMoreFromAuthors {
  core.String optedState;

  UsersettingsNotificationMoreFromAuthors();

  UsersettingsNotificationMoreFromAuthors.fromJson(core.Map _json) {
    if (_json.containsKey("opted_state")) {
      optedState = _json["opted_state"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (optedState != null) {
      _json["opted_state"] = optedState;
    }
    return _json;
  }
}

class UsersettingsNotificationMoreFromSeries {
  core.String optedState;

  UsersettingsNotificationMoreFromSeries();

  UsersettingsNotificationMoreFromSeries.fromJson(core.Map _json) {
    if (_json.containsKey("opted_state")) {
      optedState = _json["opted_state"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (optedState != null) {
      _json["opted_state"] = optedState;
    }
    return _json;
  }
}

class UsersettingsNotification {
  UsersettingsNotificationMoreFromAuthors moreFromAuthors;
  UsersettingsNotificationMoreFromSeries moreFromSeries;

  UsersettingsNotification();

  UsersettingsNotification.fromJson(core.Map _json) {
    if (_json.containsKey("moreFromAuthors")) {
      moreFromAuthors = new UsersettingsNotificationMoreFromAuthors.fromJson(_json["moreFromAuthors"]);
    }
    if (_json.containsKey("moreFromSeries")) {
      moreFromSeries = new UsersettingsNotificationMoreFromSeries.fromJson(_json["moreFromSeries"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (moreFromAuthors != null) {
      _json["moreFromAuthors"] = (moreFromAuthors).toJson();
    }
    if (moreFromSeries != null) {
      _json["moreFromSeries"] = (moreFromSeries).toJson();
    }
    return _json;
  }
}

class Usersettings {
  /** Resource type. */
  core.String kind;
  /** User settings in sub-objects, each for different purposes. */
  UsersettingsNotesExport notesExport;
  UsersettingsNotification notification;

  Usersettings();

  Usersettings.fromJson(core.Map _json) {
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("notesExport")) {
      notesExport = new UsersettingsNotesExport.fromJson(_json["notesExport"]);
    }
    if (_json.containsKey("notification")) {
      notification = new UsersettingsNotification.fromJson(_json["notification"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (notesExport != null) {
      _json["notesExport"] = (notesExport).toJson();
    }
    if (notification != null) {
      _json["notification"] = (notification).toJson();
    }
    return _json;
  }
}

/** Information about epub content. (In LITE projection.) */
class VolumeAccessInfoEpub {
  /** URL to retrieve ACS token for epub download. (In LITE projection.) */
  core.String acsTokenLink;
  /** URL to download epub. (In LITE projection.) */
  core.String downloadLink;
  /**
   * Is a flowing text epub available either as public domain or for purchase.
   * (In LITE projection.)
   */
  core.bool isAvailable;

  VolumeAccessInfoEpub();

  VolumeAccessInfoEpub.fromJson(core.Map _json) {
    if (_json.containsKey("acsTokenLink")) {
      acsTokenLink = _json["acsTokenLink"];
    }
    if (_json.containsKey("downloadLink")) {
      downloadLink = _json["downloadLink"];
    }
    if (_json.containsKey("isAvailable")) {
      isAvailable = _json["isAvailable"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (acsTokenLink != null) {
      _json["acsTokenLink"] = acsTokenLink;
    }
    if (downloadLink != null) {
      _json["downloadLink"] = downloadLink;
    }
    if (isAvailable != null) {
      _json["isAvailable"] = isAvailable;
    }
    return _json;
  }
}

/** Information about pdf content. (In LITE projection.) */
class VolumeAccessInfoPdf {
  /** URL to retrieve ACS token for pdf download. (In LITE projection.) */
  core.String acsTokenLink;
  /** URL to download pdf. (In LITE projection.) */
  core.String downloadLink;
  /**
   * Is a scanned image pdf available either as public domain or for purchase.
   * (In LITE projection.)
   */
  core.bool isAvailable;

  VolumeAccessInfoPdf();

  VolumeAccessInfoPdf.fromJson(core.Map _json) {
    if (_json.containsKey("acsTokenLink")) {
      acsTokenLink = _json["acsTokenLink"];
    }
    if (_json.containsKey("downloadLink")) {
      downloadLink = _json["downloadLink"];
    }
    if (_json.containsKey("isAvailable")) {
      isAvailable = _json["isAvailable"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (acsTokenLink != null) {
      _json["acsTokenLink"] = acsTokenLink;
    }
    if (downloadLink != null) {
      _json["downloadLink"] = downloadLink;
    }
    if (isAvailable != null) {
      _json["isAvailable"] = isAvailable;
    }
    return _json;
  }
}

/**
 * Any information about a volume related to reading or obtaining that volume
 * text. This information can depend on country (books may be public domain in
 * one country but not in another, e.g.).
 */
class VolumeAccessInfo {
  /**
   * Combines the access and viewability of this volume into a single status
   * field for this user. Values can be FULL_PURCHASED, FULL_PUBLIC_DOMAIN,
   * SAMPLE or NONE. (In LITE projection.)
   */
  core.String accessViewStatus;
  /**
   * The two-letter ISO_3166-1 country code for which this access information is
   * valid. (In LITE projection.)
   */
  core.String country;
  /** Information about a volume's download license access restrictions. */
  DownloadAccessRestriction downloadAccess;
  /**
   * URL to the Google Drive viewer if this volume is uploaded by the user by
   * selecting the file from Google Drive.
   */
  core.String driveImportedContentLink;
  /**
   * Whether this volume can be embedded in a viewport using the Embedded Viewer
   * API.
   */
  core.bool embeddable;
  /** Information about epub content. (In LITE projection.) */
  VolumeAccessInfoEpub epub;
  /**
   * Whether this volume requires that the client explicitly request offline
   * download license rather than have it done automatically when loading the
   * content, if the client supports it.
   */
  core.bool explicitOfflineLicenseManagement;
  /** Information about pdf content. (In LITE projection.) */
  VolumeAccessInfoPdf pdf;
  /** Whether or not this book is public domain in the country listed above. */
  core.bool publicDomain;
  /** Whether quote sharing is allowed for this volume. */
  core.bool quoteSharingAllowed;
  /**
   * Whether text-to-speech is permitted for this volume. Values can be ALLOWED,
   * ALLOWED_FOR_ACCESSIBILITY, or NOT_ALLOWED.
   */
  core.String textToSpeechPermission;
  /**
   * For ordered but not yet processed orders, we give a URL that can be used to
   * go to the appropriate Google Wallet page.
   */
  core.String viewOrderUrl;
  /**
   * The read access of a volume. Possible values are PARTIAL, ALL_PAGES,
   * NO_PAGES or UNKNOWN. This value depends on the country listed above. A
   * value of PARTIAL means that the publisher has allowed some portion of the
   * volume to be viewed publicly, without purchase. This can apply to eBooks as
   * well as non-eBooks. Public domain books will always have a value of
   * ALL_PAGES.
   */
  core.String viewability;
  /**
   * URL to read this volume on the Google Books site. Link will not allow users
   * to read non-viewable volumes.
   */
  core.String webReaderLink;

  VolumeAccessInfo();

  VolumeAccessInfo.fromJson(core.Map _json) {
    if (_json.containsKey("accessViewStatus")) {
      accessViewStatus = _json["accessViewStatus"];
    }
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("downloadAccess")) {
      downloadAccess = new DownloadAccessRestriction.fromJson(_json["downloadAccess"]);
    }
    if (_json.containsKey("driveImportedContentLink")) {
      driveImportedContentLink = _json["driveImportedContentLink"];
    }
    if (_json.containsKey("embeddable")) {
      embeddable = _json["embeddable"];
    }
    if (_json.containsKey("epub")) {
      epub = new VolumeAccessInfoEpub.fromJson(_json["epub"]);
    }
    if (_json.containsKey("explicitOfflineLicenseManagement")) {
      explicitOfflineLicenseManagement = _json["explicitOfflineLicenseManagement"];
    }
    if (_json.containsKey("pdf")) {
      pdf = new VolumeAccessInfoPdf.fromJson(_json["pdf"]);
    }
    if (_json.containsKey("publicDomain")) {
      publicDomain = _json["publicDomain"];
    }
    if (_json.containsKey("quoteSharingAllowed")) {
      quoteSharingAllowed = _json["quoteSharingAllowed"];
    }
    if (_json.containsKey("textToSpeechPermission")) {
      textToSpeechPermission = _json["textToSpeechPermission"];
    }
    if (_json.containsKey("viewOrderUrl")) {
      viewOrderUrl = _json["viewOrderUrl"];
    }
    if (_json.containsKey("viewability")) {
      viewability = _json["viewability"];
    }
    if (_json.containsKey("webReaderLink")) {
      webReaderLink = _json["webReaderLink"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accessViewStatus != null) {
      _json["accessViewStatus"] = accessViewStatus;
    }
    if (country != null) {
      _json["country"] = country;
    }
    if (downloadAccess != null) {
      _json["downloadAccess"] = (downloadAccess).toJson();
    }
    if (driveImportedContentLink != null) {
      _json["driveImportedContentLink"] = driveImportedContentLink;
    }
    if (embeddable != null) {
      _json["embeddable"] = embeddable;
    }
    if (epub != null) {
      _json["epub"] = (epub).toJson();
    }
    if (explicitOfflineLicenseManagement != null) {
      _json["explicitOfflineLicenseManagement"] = explicitOfflineLicenseManagement;
    }
    if (pdf != null) {
      _json["pdf"] = (pdf).toJson();
    }
    if (publicDomain != null) {
      _json["publicDomain"] = publicDomain;
    }
    if (quoteSharingAllowed != null) {
      _json["quoteSharingAllowed"] = quoteSharingAllowed;
    }
    if (textToSpeechPermission != null) {
      _json["textToSpeechPermission"] = textToSpeechPermission;
    }
    if (viewOrderUrl != null) {
      _json["viewOrderUrl"] = viewOrderUrl;
    }
    if (viewability != null) {
      _json["viewability"] = viewability;
    }
    if (webReaderLink != null) {
      _json["webReaderLink"] = webReaderLink;
    }
    return _json;
  }
}

class VolumeLayerInfoLayers {
  /** The layer id of this layer (e.g. "geo"). */
  core.String layerId;
  /**
   * The current version of this layer's volume annotations. Note that this
   * version applies only to the data in the books.layers.volumeAnnotations.*
   * responses. The actual annotation data is versioned separately.
   */
  core.String volumeAnnotationsVersion;

  VolumeLayerInfoLayers();

  VolumeLayerInfoLayers.fromJson(core.Map _json) {
    if (_json.containsKey("layerId")) {
      layerId = _json["layerId"];
    }
    if (_json.containsKey("volumeAnnotationsVersion")) {
      volumeAnnotationsVersion = _json["volumeAnnotationsVersion"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (layerId != null) {
      _json["layerId"] = layerId;
    }
    if (volumeAnnotationsVersion != null) {
      _json["volumeAnnotationsVersion"] = volumeAnnotationsVersion;
    }
    return _json;
  }
}

/** What layers exist in this volume and high level information about them. */
class VolumeLayerInfo {
  /**
   * A layer should appear here if and only if the layer exists for this book.
   */
  core.List<VolumeLayerInfoLayers> layers;

  VolumeLayerInfo();

  VolumeLayerInfo.fromJson(core.Map _json) {
    if (_json.containsKey("layers")) {
      layers = _json["layers"].map((value) => new VolumeLayerInfoLayers.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (layers != null) {
      _json["layers"] = layers.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Recommendation related information for this volume. */
class VolumeRecommendedInfo {
  /** A text explaining why this volume is recommended. */
  core.String explanation;

  VolumeRecommendedInfo();

  VolumeRecommendedInfo.fromJson(core.Map _json) {
    if (_json.containsKey("explanation")) {
      explanation = _json["explanation"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (explanation != null) {
      _json["explanation"] = explanation;
    }
    return _json;
  }
}

/** Suggested retail price. (In LITE projection.) */
class VolumeSaleInfoListPrice {
  /** Amount in the currency listed below. (In LITE projection.) */
  core.double amount;
  /** An ISO 4217, three-letter currency code. (In LITE projection.) */
  core.String currencyCode;

  VolumeSaleInfoListPrice();

  VolumeSaleInfoListPrice.fromJson(core.Map _json) {
    if (_json.containsKey("amount")) {
      amount = _json["amount"];
    }
    if (_json.containsKey("currencyCode")) {
      currencyCode = _json["currencyCode"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (amount != null) {
      _json["amount"] = amount;
    }
    if (currencyCode != null) {
      _json["currencyCode"] = currencyCode;
    }
    return _json;
  }
}

/** Offer list (=undiscounted) price in Micros. */
class VolumeSaleInfoOffersListPrice {
  core.double amountInMicros;
  core.String currencyCode;

  VolumeSaleInfoOffersListPrice();

  VolumeSaleInfoOffersListPrice.fromJson(core.Map _json) {
    if (_json.containsKey("amountInMicros")) {
      amountInMicros = _json["amountInMicros"];
    }
    if (_json.containsKey("currencyCode")) {
      currencyCode = _json["currencyCode"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (amountInMicros != null) {
      _json["amountInMicros"] = amountInMicros;
    }
    if (currencyCode != null) {
      _json["currencyCode"] = currencyCode;
    }
    return _json;
  }
}

/** The rental duration (for rental offers only). */
class VolumeSaleInfoOffersRentalDuration {
  core.double count;
  core.String unit;

  VolumeSaleInfoOffersRentalDuration();

  VolumeSaleInfoOffersRentalDuration.fromJson(core.Map _json) {
    if (_json.containsKey("count")) {
      count = _json["count"];
    }
    if (_json.containsKey("unit")) {
      unit = _json["unit"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (count != null) {
      _json["count"] = count;
    }
    if (unit != null) {
      _json["unit"] = unit;
    }
    return _json;
  }
}

/** Offer retail (=discounted) price in Micros */
class VolumeSaleInfoOffersRetailPrice {
  core.double amountInMicros;
  core.String currencyCode;

  VolumeSaleInfoOffersRetailPrice();

  VolumeSaleInfoOffersRetailPrice.fromJson(core.Map _json) {
    if (_json.containsKey("amountInMicros")) {
      amountInMicros = _json["amountInMicros"];
    }
    if (_json.containsKey("currencyCode")) {
      currencyCode = _json["currencyCode"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (amountInMicros != null) {
      _json["amountInMicros"] = amountInMicros;
    }
    if (currencyCode != null) {
      _json["currencyCode"] = currencyCode;
    }
    return _json;
  }
}

class VolumeSaleInfoOffers {
  /** The finsky offer type (e.g., PURCHASE=0 RENTAL=3) */
  core.int finskyOfferType;
  /** Indicates whether the offer is giftable. */
  core.bool giftable;
  /** Offer list (=undiscounted) price in Micros. */
  VolumeSaleInfoOffersListPrice listPrice;
  /** The rental duration (for rental offers only). */
  VolumeSaleInfoOffersRentalDuration rentalDuration;
  /** Offer retail (=discounted) price in Micros */
  VolumeSaleInfoOffersRetailPrice retailPrice;

  VolumeSaleInfoOffers();

  VolumeSaleInfoOffers.fromJson(core.Map _json) {
    if (_json.containsKey("finskyOfferType")) {
      finskyOfferType = _json["finskyOfferType"];
    }
    if (_json.containsKey("giftable")) {
      giftable = _json["giftable"];
    }
    if (_json.containsKey("listPrice")) {
      listPrice = new VolumeSaleInfoOffersListPrice.fromJson(_json["listPrice"]);
    }
    if (_json.containsKey("rentalDuration")) {
      rentalDuration = new VolumeSaleInfoOffersRentalDuration.fromJson(_json["rentalDuration"]);
    }
    if (_json.containsKey("retailPrice")) {
      retailPrice = new VolumeSaleInfoOffersRetailPrice.fromJson(_json["retailPrice"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (finskyOfferType != null) {
      _json["finskyOfferType"] = finskyOfferType;
    }
    if (giftable != null) {
      _json["giftable"] = giftable;
    }
    if (listPrice != null) {
      _json["listPrice"] = (listPrice).toJson();
    }
    if (rentalDuration != null) {
      _json["rentalDuration"] = (rentalDuration).toJson();
    }
    if (retailPrice != null) {
      _json["retailPrice"] = (retailPrice).toJson();
    }
    return _json;
  }
}

/**
 * The actual selling price of the book. This is the same as the suggested
 * retail or list price unless there are offers or discounts on this volume. (In
 * LITE projection.)
 */
class VolumeSaleInfoRetailPrice {
  /** Amount in the currency listed below. (In LITE projection.) */
  core.double amount;
  /** An ISO 4217, three-letter currency code. (In LITE projection.) */
  core.String currencyCode;

  VolumeSaleInfoRetailPrice();

  VolumeSaleInfoRetailPrice.fromJson(core.Map _json) {
    if (_json.containsKey("amount")) {
      amount = _json["amount"];
    }
    if (_json.containsKey("currencyCode")) {
      currencyCode = _json["currencyCode"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (amount != null) {
      _json["amount"] = amount;
    }
    if (currencyCode != null) {
      _json["currencyCode"] = currencyCode;
    }
    return _json;
  }
}

/**
 * Any information about a volume related to the eBookstore and/or
 * purchaseability. This information can depend on the country where the request
 * originates from (i.e. books may not be for sale in certain countries).
 */
class VolumeSaleInfo {
  /**
   * URL to purchase this volume on the Google Books site. (In LITE projection)
   */
  core.String buyLink;
  /**
   * The two-letter ISO_3166-1 country code for which this sale information is
   * valid. (In LITE projection.)
   */
  core.String country;
  /**
   * Whether or not this volume is an eBook (can be added to the My eBooks
   * shelf).
   */
  core.bool isEbook;
  /** Suggested retail price. (In LITE projection.) */
  VolumeSaleInfoListPrice listPrice;
  /** Offers available for this volume (sales and rentals). */
  core.List<VolumeSaleInfoOffers> offers;
  /** The date on which this book is available for sale. */
  core.DateTime onSaleDate;
  /**
   * The actual selling price of the book. This is the same as the suggested
   * retail or list price unless there are offers or discounts on this volume.
   * (In LITE projection.)
   */
  VolumeSaleInfoRetailPrice retailPrice;
  /**
   * Whether or not this book is available for sale or offered for free in the
   * Google eBookstore for the country listed above. Possible values are
   * FOR_SALE, FOR_RENTAL_ONLY, FOR_SALE_AND_RENTAL, FREE, NOT_FOR_SALE, or
   * FOR_PREORDER.
   */
  core.String saleability;

  VolumeSaleInfo();

  VolumeSaleInfo.fromJson(core.Map _json) {
    if (_json.containsKey("buyLink")) {
      buyLink = _json["buyLink"];
    }
    if (_json.containsKey("country")) {
      country = _json["country"];
    }
    if (_json.containsKey("isEbook")) {
      isEbook = _json["isEbook"];
    }
    if (_json.containsKey("listPrice")) {
      listPrice = new VolumeSaleInfoListPrice.fromJson(_json["listPrice"]);
    }
    if (_json.containsKey("offers")) {
      offers = _json["offers"].map((value) => new VolumeSaleInfoOffers.fromJson(value)).toList();
    }
    if (_json.containsKey("onSaleDate")) {
      onSaleDate = core.DateTime.parse(_json["onSaleDate"]);
    }
    if (_json.containsKey("retailPrice")) {
      retailPrice = new VolumeSaleInfoRetailPrice.fromJson(_json["retailPrice"]);
    }
    if (_json.containsKey("saleability")) {
      saleability = _json["saleability"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (buyLink != null) {
      _json["buyLink"] = buyLink;
    }
    if (country != null) {
      _json["country"] = country;
    }
    if (isEbook != null) {
      _json["isEbook"] = isEbook;
    }
    if (listPrice != null) {
      _json["listPrice"] = (listPrice).toJson();
    }
    if (offers != null) {
      _json["offers"] = offers.map((value) => (value).toJson()).toList();
    }
    if (onSaleDate != null) {
      _json["onSaleDate"] = (onSaleDate).toIso8601String();
    }
    if (retailPrice != null) {
      _json["retailPrice"] = (retailPrice).toJson();
    }
    if (saleability != null) {
      _json["saleability"] = saleability;
    }
    return _json;
  }
}

/** Search result information related to this volume. */
class VolumeSearchInfo {
  /** A text snippet containing the search query. */
  core.String textSnippet;

  VolumeSearchInfo();

  VolumeSearchInfo.fromJson(core.Map _json) {
    if (_json.containsKey("textSnippet")) {
      textSnippet = _json["textSnippet"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (textSnippet != null) {
      _json["textSnippet"] = textSnippet;
    }
    return _json;
  }
}

/** Copy/Paste accounting information. */
class VolumeUserInfoCopy {
  core.int allowedCharacterCount;
  core.String limitType;
  core.int remainingCharacterCount;
  core.DateTime updated;

  VolumeUserInfoCopy();

  VolumeUserInfoCopy.fromJson(core.Map _json) {
    if (_json.containsKey("allowedCharacterCount")) {
      allowedCharacterCount = _json["allowedCharacterCount"];
    }
    if (_json.containsKey("limitType")) {
      limitType = _json["limitType"];
    }
    if (_json.containsKey("remainingCharacterCount")) {
      remainingCharacterCount = _json["remainingCharacterCount"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (allowedCharacterCount != null) {
      _json["allowedCharacterCount"] = allowedCharacterCount;
    }
    if (limitType != null) {
      _json["limitType"] = limitType;
    }
    if (remainingCharacterCount != null) {
      _json["remainingCharacterCount"] = remainingCharacterCount;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    return _json;
  }
}

/** Information on the ability to share with the family. */
class VolumeUserInfoFamilySharing {
  /** The role of the user in the family. */
  core.String familyRole;
  /**
   * Whether or not this volume can be shared with the family by the user. This
   * includes sharing eligibility of both the volume and the user. If the value
   * is true, the user can initiate a family sharing action.
   */
  core.bool isSharingAllowed;
  /**
   * Whether or not sharing this volume is temporarily disabled due to issues
   * with the Family Wallet.
   */
  core.bool isSharingDisabledByFop;

  VolumeUserInfoFamilySharing();

  VolumeUserInfoFamilySharing.fromJson(core.Map _json) {
    if (_json.containsKey("familyRole")) {
      familyRole = _json["familyRole"];
    }
    if (_json.containsKey("isSharingAllowed")) {
      isSharingAllowed = _json["isSharingAllowed"];
    }
    if (_json.containsKey("isSharingDisabledByFop")) {
      isSharingDisabledByFop = _json["isSharingDisabledByFop"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (familyRole != null) {
      _json["familyRole"] = familyRole;
    }
    if (isSharingAllowed != null) {
      _json["isSharingAllowed"] = isSharingAllowed;
    }
    if (isSharingDisabledByFop != null) {
      _json["isSharingDisabledByFop"] = isSharingDisabledByFop;
    }
    return _json;
  }
}

/** Period during this book is/was a valid rental. */
class VolumeUserInfoRentalPeriod {
  core.String endUtcSec;
  core.String startUtcSec;

  VolumeUserInfoRentalPeriod();

  VolumeUserInfoRentalPeriod.fromJson(core.Map _json) {
    if (_json.containsKey("endUtcSec")) {
      endUtcSec = _json["endUtcSec"];
    }
    if (_json.containsKey("startUtcSec")) {
      startUtcSec = _json["startUtcSec"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (endUtcSec != null) {
      _json["endUtcSec"] = endUtcSec;
    }
    if (startUtcSec != null) {
      _json["startUtcSec"] = startUtcSec;
    }
    return _json;
  }
}

class VolumeUserInfoUserUploadedVolumeInfo {
  core.String processingState;

  VolumeUserInfoUserUploadedVolumeInfo();

  VolumeUserInfoUserUploadedVolumeInfo.fromJson(core.Map _json) {
    if (_json.containsKey("processingState")) {
      processingState = _json["processingState"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (processingState != null) {
      _json["processingState"] = processingState;
    }
    return _json;
  }
}

/**
 * User specific information related to this volume. (e.g. page this user last
 * read or whether they purchased this book)
 */
class VolumeUserInfo {
  /**
   * Timestamp when this volume was acquired by the user. (RFC 3339 UTC
   * date-time format) Acquiring includes purchase, user upload, receiving
   * family sharing, etc.
   */
  core.DateTime acquiredTime;
  /** How this volume was acquired. */
  core.int acquisitionType;
  /** Copy/Paste accounting information. */
  VolumeUserInfoCopy copy;
  /** Whether this volume is purchased, sample, pd download etc. */
  core.int entitlementType;
  /** Information on the ability to share with the family. */
  VolumeUserInfoFamilySharing familySharing;
  /** Whether or not the user shared this volume with the family. */
  core.bool isFamilySharedFromUser;
  /** Whether or not the user received this volume through family sharing. */
  core.bool isFamilySharedToUser;
  /** Deprecated: Replaced by familySharing. */
  core.bool isFamilySharingAllowed;
  /** Deprecated: Replaced by familySharing. */
  core.bool isFamilySharingDisabledByFop;
  /** Whether or not this volume is currently in "my books." */
  core.bool isInMyBooks;
  /**
   * Whether or not this volume was pre-ordered by the authenticated user making
   * the request. (In LITE projection.)
   */
  core.bool isPreordered;
  /**
   * Whether or not this volume was purchased by the authenticated user making
   * the request. (In LITE projection.)
   */
  core.bool isPurchased;
  /** Whether or not this volume was user uploaded. */
  core.bool isUploaded;
  /**
   * The user's current reading position in the volume, if one is available. (In
   * LITE projection.)
   */
  ReadingPosition readingPosition;
  /** Period during this book is/was a valid rental. */
  VolumeUserInfoRentalPeriod rentalPeriod;
  /** Whether this book is an active or an expired rental. */
  core.String rentalState;
  /** This user's review of this volume, if one exists. */
  Review review;
  /**
   * Timestamp when this volume was last modified by a user action, such as a
   * reading position update, volume purchase or writing a review. (RFC 3339 UTC
   * date-time format).
   */
  core.DateTime updated;
  VolumeUserInfoUserUploadedVolumeInfo userUploadedVolumeInfo;

  VolumeUserInfo();

  VolumeUserInfo.fromJson(core.Map _json) {
    if (_json.containsKey("acquiredTime")) {
      acquiredTime = core.DateTime.parse(_json["acquiredTime"]);
    }
    if (_json.containsKey("acquisitionType")) {
      acquisitionType = _json["acquisitionType"];
    }
    if (_json.containsKey("copy")) {
      copy = new VolumeUserInfoCopy.fromJson(_json["copy"]);
    }
    if (_json.containsKey("entitlementType")) {
      entitlementType = _json["entitlementType"];
    }
    if (_json.containsKey("familySharing")) {
      familySharing = new VolumeUserInfoFamilySharing.fromJson(_json["familySharing"]);
    }
    if (_json.containsKey("isFamilySharedFromUser")) {
      isFamilySharedFromUser = _json["isFamilySharedFromUser"];
    }
    if (_json.containsKey("isFamilySharedToUser")) {
      isFamilySharedToUser = _json["isFamilySharedToUser"];
    }
    if (_json.containsKey("isFamilySharingAllowed")) {
      isFamilySharingAllowed = _json["isFamilySharingAllowed"];
    }
    if (_json.containsKey("isFamilySharingDisabledByFop")) {
      isFamilySharingDisabledByFop = _json["isFamilySharingDisabledByFop"];
    }
    if (_json.containsKey("isInMyBooks")) {
      isInMyBooks = _json["isInMyBooks"];
    }
    if (_json.containsKey("isPreordered")) {
      isPreordered = _json["isPreordered"];
    }
    if (_json.containsKey("isPurchased")) {
      isPurchased = _json["isPurchased"];
    }
    if (_json.containsKey("isUploaded")) {
      isUploaded = _json["isUploaded"];
    }
    if (_json.containsKey("readingPosition")) {
      readingPosition = new ReadingPosition.fromJson(_json["readingPosition"]);
    }
    if (_json.containsKey("rentalPeriod")) {
      rentalPeriod = new VolumeUserInfoRentalPeriod.fromJson(_json["rentalPeriod"]);
    }
    if (_json.containsKey("rentalState")) {
      rentalState = _json["rentalState"];
    }
    if (_json.containsKey("review")) {
      review = new Review.fromJson(_json["review"]);
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
    if (_json.containsKey("userUploadedVolumeInfo")) {
      userUploadedVolumeInfo = new VolumeUserInfoUserUploadedVolumeInfo.fromJson(_json["userUploadedVolumeInfo"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (acquiredTime != null) {
      _json["acquiredTime"] = (acquiredTime).toIso8601String();
    }
    if (acquisitionType != null) {
      _json["acquisitionType"] = acquisitionType;
    }
    if (copy != null) {
      _json["copy"] = (copy).toJson();
    }
    if (entitlementType != null) {
      _json["entitlementType"] = entitlementType;
    }
    if (familySharing != null) {
      _json["familySharing"] = (familySharing).toJson();
    }
    if (isFamilySharedFromUser != null) {
      _json["isFamilySharedFromUser"] = isFamilySharedFromUser;
    }
    if (isFamilySharedToUser != null) {
      _json["isFamilySharedToUser"] = isFamilySharedToUser;
    }
    if (isFamilySharingAllowed != null) {
      _json["isFamilySharingAllowed"] = isFamilySharingAllowed;
    }
    if (isFamilySharingDisabledByFop != null) {
      _json["isFamilySharingDisabledByFop"] = isFamilySharingDisabledByFop;
    }
    if (isInMyBooks != null) {
      _json["isInMyBooks"] = isInMyBooks;
    }
    if (isPreordered != null) {
      _json["isPreordered"] = isPreordered;
    }
    if (isPurchased != null) {
      _json["isPurchased"] = isPurchased;
    }
    if (isUploaded != null) {
      _json["isUploaded"] = isUploaded;
    }
    if (readingPosition != null) {
      _json["readingPosition"] = (readingPosition).toJson();
    }
    if (rentalPeriod != null) {
      _json["rentalPeriod"] = (rentalPeriod).toJson();
    }
    if (rentalState != null) {
      _json["rentalState"] = rentalState;
    }
    if (review != null) {
      _json["review"] = (review).toJson();
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    if (userUploadedVolumeInfo != null) {
      _json["userUploadedVolumeInfo"] = (userUploadedVolumeInfo).toJson();
    }
    return _json;
  }
}

/** Physical dimensions of this volume. */
class VolumeVolumeInfoDimensions {
  /** Height or length of this volume (in cm). */
  core.String height;
  /** Thickness of this volume (in cm). */
  core.String thickness;
  /** Width of this volume (in cm). */
  core.String width;

  VolumeVolumeInfoDimensions();

  VolumeVolumeInfoDimensions.fromJson(core.Map _json) {
    if (_json.containsKey("height")) {
      height = _json["height"];
    }
    if (_json.containsKey("thickness")) {
      thickness = _json["thickness"];
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
    if (thickness != null) {
      _json["thickness"] = thickness;
    }
    if (width != null) {
      _json["width"] = width;
    }
    return _json;
  }
}

/**
 * A list of image links for all the sizes that are available. (In LITE
 * projection.)
 */
class VolumeVolumeInfoImageLinks {
  /**
   * Image link for extra large size (width of ~1280 pixels). (In LITE
   * projection)
   */
  core.String extraLarge;
  /** Image link for large size (width of ~800 pixels). (In LITE projection) */
  core.String large;
  /**
   * Image link for medium size (width of ~575 pixels). (In LITE projection)
   */
  core.String medium;
  /** Image link for small size (width of ~300 pixels). (In LITE projection) */
  core.String small;
  /**
   * Image link for small thumbnail size (width of ~80 pixels). (In LITE
   * projection)
   */
  core.String smallThumbnail;
  /**
   * Image link for thumbnail size (width of ~128 pixels). (In LITE projection)
   */
  core.String thumbnail;

  VolumeVolumeInfoImageLinks();

  VolumeVolumeInfoImageLinks.fromJson(core.Map _json) {
    if (_json.containsKey("extraLarge")) {
      extraLarge = _json["extraLarge"];
    }
    if (_json.containsKey("large")) {
      large = _json["large"];
    }
    if (_json.containsKey("medium")) {
      medium = _json["medium"];
    }
    if (_json.containsKey("small")) {
      small = _json["small"];
    }
    if (_json.containsKey("smallThumbnail")) {
      smallThumbnail = _json["smallThumbnail"];
    }
    if (_json.containsKey("thumbnail")) {
      thumbnail = _json["thumbnail"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (extraLarge != null) {
      _json["extraLarge"] = extraLarge;
    }
    if (large != null) {
      _json["large"] = large;
    }
    if (medium != null) {
      _json["medium"] = medium;
    }
    if (small != null) {
      _json["small"] = small;
    }
    if (smallThumbnail != null) {
      _json["smallThumbnail"] = smallThumbnail;
    }
    if (thumbnail != null) {
      _json["thumbnail"] = thumbnail;
    }
    return _json;
  }
}

class VolumeVolumeInfoIndustryIdentifiers {
  /** Industry specific volume identifier. */
  core.String identifier;
  /** Identifier type. Possible values are ISBN_10, ISBN_13, ISSN and OTHER. */
  core.String type;

  VolumeVolumeInfoIndustryIdentifiers();

  VolumeVolumeInfoIndustryIdentifiers.fromJson(core.Map _json) {
    if (_json.containsKey("identifier")) {
      identifier = _json["identifier"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (identifier != null) {
      _json["identifier"] = identifier;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** A top-level summary of the panelization info in this volume. */
class VolumeVolumeInfoPanelizationSummary {
  core.bool containsEpubBubbles;
  core.bool containsImageBubbles;
  core.String epubBubbleVersion;
  core.String imageBubbleVersion;

  VolumeVolumeInfoPanelizationSummary();

  VolumeVolumeInfoPanelizationSummary.fromJson(core.Map _json) {
    if (_json.containsKey("containsEpubBubbles")) {
      containsEpubBubbles = _json["containsEpubBubbles"];
    }
    if (_json.containsKey("containsImageBubbles")) {
      containsImageBubbles = _json["containsImageBubbles"];
    }
    if (_json.containsKey("epubBubbleVersion")) {
      epubBubbleVersion = _json["epubBubbleVersion"];
    }
    if (_json.containsKey("imageBubbleVersion")) {
      imageBubbleVersion = _json["imageBubbleVersion"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (containsEpubBubbles != null) {
      _json["containsEpubBubbles"] = containsEpubBubbles;
    }
    if (containsImageBubbles != null) {
      _json["containsImageBubbles"] = containsImageBubbles;
    }
    if (epubBubbleVersion != null) {
      _json["epubBubbleVersion"] = epubBubbleVersion;
    }
    if (imageBubbleVersion != null) {
      _json["imageBubbleVersion"] = imageBubbleVersion;
    }
    return _json;
  }
}

/** General volume information. */
class VolumeVolumeInfo {
  /** Whether anonymous logging should be allowed. */
  core.bool allowAnonLogging;
  /**
   * The names of the authors and/or editors for this volume. (In LITE
   * projection)
   */
  core.List<core.String> authors;
  /** The mean review rating for this volume. (min = 1.0, max = 5.0) */
  core.double averageRating;
  /** Canonical URL for a volume. (In LITE projection.) */
  core.String canonicalVolumeLink;
  /** A list of subject categories, such as "Fiction", "Suspense", etc. */
  core.List<core.String> categories;
  /**
   * An identifier for the version of the volume content (text & images). (In
   * LITE projection)
   */
  core.String contentVersion;
  /**
   * A synopsis of the volume. The text of the description is formatted in HTML
   * and includes simple formatting elements, such as b, i, and br tags. (In
   * LITE projection.)
   */
  core.String description;
  /** Physical dimensions of this volume. */
  VolumeVolumeInfoDimensions dimensions;
  /**
   * A list of image links for all the sizes that are available. (In LITE
   * projection.)
   */
  VolumeVolumeInfoImageLinks imageLinks;
  /** Industry standard identifiers for this volume. */
  core.List<VolumeVolumeInfoIndustryIdentifiers> industryIdentifiers;
  /**
   * URL to view information about this volume on the Google Books site. (In
   * LITE projection)
   */
  core.String infoLink;
  /**
   * Best language for this volume (based on content). It is the two-letter ISO
   * 639-1 code such as 'fr', 'en', etc.
   */
  core.String language;
  /**
   * The main category to which this volume belongs. It will be the category
   * from the categories list returned below that has the highest weight.
   */
  core.String mainCategory;
  core.String maturityRating;
  /** Total number of pages as per publisher metadata. */
  core.int pageCount;
  /** A top-level summary of the panelization info in this volume. */
  VolumeVolumeInfoPanelizationSummary panelizationSummary;
  /** URL to preview this volume on the Google Books site. */
  core.String previewLink;
  /**
   * Type of publication of this volume. Possible values are BOOK or MAGAZINE.
   */
  core.String printType;
  /** Total number of printed pages in generated pdf representation. */
  core.int printedPageCount;
  /** Date of publication. (In LITE projection.) */
  core.String publishedDate;
  /** Publisher of this volume. (In LITE projection.) */
  core.String publisher;
  /** The number of review ratings for this volume. */
  core.int ratingsCount;
  /**
   * The reading modes available for this volume.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Object readingModes;
  /** Total number of sample pages as per publisher metadata. */
  core.int samplePageCount;
  Volumeseriesinfo seriesInfo;
  /** Volume subtitle. (In LITE projection.) */
  core.String subtitle;
  /** Volume title. (In LITE projection.) */
  core.String title;

  VolumeVolumeInfo();

  VolumeVolumeInfo.fromJson(core.Map _json) {
    if (_json.containsKey("allowAnonLogging")) {
      allowAnonLogging = _json["allowAnonLogging"];
    }
    if (_json.containsKey("authors")) {
      authors = _json["authors"];
    }
    if (_json.containsKey("averageRating")) {
      averageRating = _json["averageRating"];
    }
    if (_json.containsKey("canonicalVolumeLink")) {
      canonicalVolumeLink = _json["canonicalVolumeLink"];
    }
    if (_json.containsKey("categories")) {
      categories = _json["categories"];
    }
    if (_json.containsKey("contentVersion")) {
      contentVersion = _json["contentVersion"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("dimensions")) {
      dimensions = new VolumeVolumeInfoDimensions.fromJson(_json["dimensions"]);
    }
    if (_json.containsKey("imageLinks")) {
      imageLinks = new VolumeVolumeInfoImageLinks.fromJson(_json["imageLinks"]);
    }
    if (_json.containsKey("industryIdentifiers")) {
      industryIdentifiers = _json["industryIdentifiers"].map((value) => new VolumeVolumeInfoIndustryIdentifiers.fromJson(value)).toList();
    }
    if (_json.containsKey("infoLink")) {
      infoLink = _json["infoLink"];
    }
    if (_json.containsKey("language")) {
      language = _json["language"];
    }
    if (_json.containsKey("mainCategory")) {
      mainCategory = _json["mainCategory"];
    }
    if (_json.containsKey("maturityRating")) {
      maturityRating = _json["maturityRating"];
    }
    if (_json.containsKey("pageCount")) {
      pageCount = _json["pageCount"];
    }
    if (_json.containsKey("panelizationSummary")) {
      panelizationSummary = new VolumeVolumeInfoPanelizationSummary.fromJson(_json["panelizationSummary"]);
    }
    if (_json.containsKey("previewLink")) {
      previewLink = _json["previewLink"];
    }
    if (_json.containsKey("printType")) {
      printType = _json["printType"];
    }
    if (_json.containsKey("printedPageCount")) {
      printedPageCount = _json["printedPageCount"];
    }
    if (_json.containsKey("publishedDate")) {
      publishedDate = _json["publishedDate"];
    }
    if (_json.containsKey("publisher")) {
      publisher = _json["publisher"];
    }
    if (_json.containsKey("ratingsCount")) {
      ratingsCount = _json["ratingsCount"];
    }
    if (_json.containsKey("readingModes")) {
      readingModes = _json["readingModes"];
    }
    if (_json.containsKey("samplePageCount")) {
      samplePageCount = _json["samplePageCount"];
    }
    if (_json.containsKey("seriesInfo")) {
      seriesInfo = new Volumeseriesinfo.fromJson(_json["seriesInfo"]);
    }
    if (_json.containsKey("subtitle")) {
      subtitle = _json["subtitle"];
    }
    if (_json.containsKey("title")) {
      title = _json["title"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (allowAnonLogging != null) {
      _json["allowAnonLogging"] = allowAnonLogging;
    }
    if (authors != null) {
      _json["authors"] = authors;
    }
    if (averageRating != null) {
      _json["averageRating"] = averageRating;
    }
    if (canonicalVolumeLink != null) {
      _json["canonicalVolumeLink"] = canonicalVolumeLink;
    }
    if (categories != null) {
      _json["categories"] = categories;
    }
    if (contentVersion != null) {
      _json["contentVersion"] = contentVersion;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (dimensions != null) {
      _json["dimensions"] = (dimensions).toJson();
    }
    if (imageLinks != null) {
      _json["imageLinks"] = (imageLinks).toJson();
    }
    if (industryIdentifiers != null) {
      _json["industryIdentifiers"] = industryIdentifiers.map((value) => (value).toJson()).toList();
    }
    if (infoLink != null) {
      _json["infoLink"] = infoLink;
    }
    if (language != null) {
      _json["language"] = language;
    }
    if (mainCategory != null) {
      _json["mainCategory"] = mainCategory;
    }
    if (maturityRating != null) {
      _json["maturityRating"] = maturityRating;
    }
    if (pageCount != null) {
      _json["pageCount"] = pageCount;
    }
    if (panelizationSummary != null) {
      _json["panelizationSummary"] = (panelizationSummary).toJson();
    }
    if (previewLink != null) {
      _json["previewLink"] = previewLink;
    }
    if (printType != null) {
      _json["printType"] = printType;
    }
    if (printedPageCount != null) {
      _json["printedPageCount"] = printedPageCount;
    }
    if (publishedDate != null) {
      _json["publishedDate"] = publishedDate;
    }
    if (publisher != null) {
      _json["publisher"] = publisher;
    }
    if (ratingsCount != null) {
      _json["ratingsCount"] = ratingsCount;
    }
    if (readingModes != null) {
      _json["readingModes"] = readingModes;
    }
    if (samplePageCount != null) {
      _json["samplePageCount"] = samplePageCount;
    }
    if (seriesInfo != null) {
      _json["seriesInfo"] = (seriesInfo).toJson();
    }
    if (subtitle != null) {
      _json["subtitle"] = subtitle;
    }
    if (title != null) {
      _json["title"] = title;
    }
    return _json;
  }
}

class Volume {
  /**
   * Any information about a volume related to reading or obtaining that volume
   * text. This information can depend on country (books may be public domain in
   * one country but not in another, e.g.).
   */
  VolumeAccessInfo accessInfo;
  /**
   * Opaque identifier for a specific version of a volume resource. (In LITE
   * projection)
   */
  core.String etag;
  /** Unique identifier for a volume. (In LITE projection.) */
  core.String id;
  /** Resource type for a volume. (In LITE projection.) */
  core.String kind;
  /**
   * What layers exist in this volume and high level information about them.
   */
  VolumeLayerInfo layerInfo;
  /** Recommendation related information for this volume. */
  VolumeRecommendedInfo recommendedInfo;
  /**
   * Any information about a volume related to the eBookstore and/or
   * purchaseability. This information can depend on the country where the
   * request originates from (i.e. books may not be for sale in certain
   * countries).
   */
  VolumeSaleInfo saleInfo;
  /** Search result information related to this volume. */
  VolumeSearchInfo searchInfo;
  /** URL to this resource. (In LITE projection.) */
  core.String selfLink;
  /**
   * User specific information related to this volume. (e.g. page this user last
   * read or whether they purchased this book)
   */
  VolumeUserInfo userInfo;
  /** General volume information. */
  VolumeVolumeInfo volumeInfo;

  Volume();

  Volume.fromJson(core.Map _json) {
    if (_json.containsKey("accessInfo")) {
      accessInfo = new VolumeAccessInfo.fromJson(_json["accessInfo"]);
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("layerInfo")) {
      layerInfo = new VolumeLayerInfo.fromJson(_json["layerInfo"]);
    }
    if (_json.containsKey("recommendedInfo")) {
      recommendedInfo = new VolumeRecommendedInfo.fromJson(_json["recommendedInfo"]);
    }
    if (_json.containsKey("saleInfo")) {
      saleInfo = new VolumeSaleInfo.fromJson(_json["saleInfo"]);
    }
    if (_json.containsKey("searchInfo")) {
      searchInfo = new VolumeSearchInfo.fromJson(_json["searchInfo"]);
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("userInfo")) {
      userInfo = new VolumeUserInfo.fromJson(_json["userInfo"]);
    }
    if (_json.containsKey("volumeInfo")) {
      volumeInfo = new VolumeVolumeInfo.fromJson(_json["volumeInfo"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accessInfo != null) {
      _json["accessInfo"] = (accessInfo).toJson();
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (layerInfo != null) {
      _json["layerInfo"] = (layerInfo).toJson();
    }
    if (recommendedInfo != null) {
      _json["recommendedInfo"] = (recommendedInfo).toJson();
    }
    if (saleInfo != null) {
      _json["saleInfo"] = (saleInfo).toJson();
    }
    if (searchInfo != null) {
      _json["searchInfo"] = (searchInfo).toJson();
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (userInfo != null) {
      _json["userInfo"] = (userInfo).toJson();
    }
    if (volumeInfo != null) {
      _json["volumeInfo"] = (volumeInfo).toJson();
    }
    return _json;
  }
}

class Volume2 {
  /** A list of volumes. */
  core.List<Volume> items;
  /** Resource type. */
  core.String kind;
  core.String nextPageToken;

  Volume2();

  Volume2.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Volume.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
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
    return _json;
  }
}

/** The content ranges to identify the selected text. */
class VolumeannotationContentRanges {
  /** Range in CFI format for this annotation for version above. */
  BooksAnnotationsRange cfiRange;
  /** Content version applicable to ranges below. */
  core.String contentVersion;
  /** Range in GB image format for this annotation for version above. */
  BooksAnnotationsRange gbImageRange;
  /** Range in GB text format for this annotation for version above. */
  BooksAnnotationsRange gbTextRange;

  VolumeannotationContentRanges();

  VolumeannotationContentRanges.fromJson(core.Map _json) {
    if (_json.containsKey("cfiRange")) {
      cfiRange = new BooksAnnotationsRange.fromJson(_json["cfiRange"]);
    }
    if (_json.containsKey("contentVersion")) {
      contentVersion = _json["contentVersion"];
    }
    if (_json.containsKey("gbImageRange")) {
      gbImageRange = new BooksAnnotationsRange.fromJson(_json["gbImageRange"]);
    }
    if (_json.containsKey("gbTextRange")) {
      gbTextRange = new BooksAnnotationsRange.fromJson(_json["gbTextRange"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cfiRange != null) {
      _json["cfiRange"] = (cfiRange).toJson();
    }
    if (contentVersion != null) {
      _json["contentVersion"] = contentVersion;
    }
    if (gbImageRange != null) {
      _json["gbImageRange"] = (gbImageRange).toJson();
    }
    if (gbTextRange != null) {
      _json["gbTextRange"] = (gbTextRange).toJson();
    }
    return _json;
  }
}

class Volumeannotation {
  /** The annotation data id for this volume annotation. */
  core.String annotationDataId;
  /** Link to get data for this annotation. */
  core.String annotationDataLink;
  /** The type of annotation this is. */
  core.String annotationType;
  /** The content ranges to identify the selected text. */
  VolumeannotationContentRanges contentRanges;
  /** Data for this annotation. */
  core.String data;
  /** Indicates that this annotation is deleted. */
  core.bool deleted;
  /** Unique id of this volume annotation. */
  core.String id;
  /** Resource Type */
  core.String kind;
  /** The Layer this annotation is for. */
  core.String layerId;
  /** Pages the annotation spans. */
  core.List<core.String> pageIds;
  /** Excerpt from the volume. */
  core.String selectedText;
  /** URL to this resource. */
  core.String selfLink;
  /**
   * Timestamp for the last time this anntoation was updated. (RFC 3339 UTC
   * date-time format).
   */
  core.DateTime updated;
  /** The Volume this annotation is for. */
  core.String volumeId;

  Volumeannotation();

  Volumeannotation.fromJson(core.Map _json) {
    if (_json.containsKey("annotationDataId")) {
      annotationDataId = _json["annotationDataId"];
    }
    if (_json.containsKey("annotationDataLink")) {
      annotationDataLink = _json["annotationDataLink"];
    }
    if (_json.containsKey("annotationType")) {
      annotationType = _json["annotationType"];
    }
    if (_json.containsKey("contentRanges")) {
      contentRanges = new VolumeannotationContentRanges.fromJson(_json["contentRanges"]);
    }
    if (_json.containsKey("data")) {
      data = _json["data"];
    }
    if (_json.containsKey("deleted")) {
      deleted = _json["deleted"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("layerId")) {
      layerId = _json["layerId"];
    }
    if (_json.containsKey("pageIds")) {
      pageIds = _json["pageIds"];
    }
    if (_json.containsKey("selectedText")) {
      selectedText = _json["selectedText"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
    if (_json.containsKey("volumeId")) {
      volumeId = _json["volumeId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (annotationDataId != null) {
      _json["annotationDataId"] = annotationDataId;
    }
    if (annotationDataLink != null) {
      _json["annotationDataLink"] = annotationDataLink;
    }
    if (annotationType != null) {
      _json["annotationType"] = annotationType;
    }
    if (contentRanges != null) {
      _json["contentRanges"] = (contentRanges).toJson();
    }
    if (data != null) {
      _json["data"] = data;
    }
    if (deleted != null) {
      _json["deleted"] = deleted;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (layerId != null) {
      _json["layerId"] = layerId;
    }
    if (pageIds != null) {
      _json["pageIds"] = pageIds;
    }
    if (selectedText != null) {
      _json["selectedText"] = selectedText;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    if (volumeId != null) {
      _json["volumeId"] = volumeId;
    }
    return _json;
  }
}

class Volumeannotations {
  /** A list of volume annotations. */
  core.List<Volumeannotation> items;
  /** Resource type */
  core.String kind;
  /**
   * Token to pass in for pagination for the next page. This will not be present
   * if this request does not have more results.
   */
  core.String nextPageToken;
  /** The total number of volume annotations found. */
  core.int totalItems;
  /**
   * The version string for all of the volume annotations in this layer (not
   * just the ones in this response). Note: the version string doesn't apply to
   * the annotation data, just the information in this response (e.g. the
   * location of annotations in the book).
   */
  core.String version;

  Volumeannotations();

  Volumeannotations.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Volumeannotation.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("totalItems")) {
      totalItems = _json["totalItems"];
    }
    if (_json.containsKey("version")) {
      version = _json["version"];
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
    if (totalItems != null) {
      _json["totalItems"] = totalItems;
    }
    if (version != null) {
      _json["version"] = version;
    }
    return _json;
  }
}

class Volumes {
  /** A list of volumes. */
  core.List<Volume> items;
  /** Resource type. */
  core.String kind;
  /**
   * Total number of volumes found. This might be greater than the number of
   * volumes returned in this response if results have been paginated.
   */
  core.int totalItems;

  Volumes();

  Volumes.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Volume.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("totalItems")) {
      totalItems = _json["totalItems"];
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
    if (totalItems != null) {
      _json["totalItems"] = totalItems;
    }
    return _json;
  }
}

class VolumeseriesinfoVolumeSeriesIssue {
  core.String issueDisplayNumber;
  core.int issueOrderNumber;

  VolumeseriesinfoVolumeSeriesIssue();

  VolumeseriesinfoVolumeSeriesIssue.fromJson(core.Map _json) {
    if (_json.containsKey("issueDisplayNumber")) {
      issueDisplayNumber = _json["issueDisplayNumber"];
    }
    if (_json.containsKey("issueOrderNumber")) {
      issueOrderNumber = _json["issueOrderNumber"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (issueDisplayNumber != null) {
      _json["issueDisplayNumber"] = issueDisplayNumber;
    }
    if (issueOrderNumber != null) {
      _json["issueOrderNumber"] = issueOrderNumber;
    }
    return _json;
  }
}

class VolumeseriesinfoVolumeSeries {
  /** List of issues. Applicable only for Collection Edition and Omnibus. */
  core.List<VolumeseriesinfoVolumeSeriesIssue> issue;
  /** The book order number in the series. */
  core.int orderNumber;
  /**
   * The book type in the context of series. Examples - Single Issue, Collection
   * Edition, etc.
   */
  core.String seriesBookType;
  /** The series id. */
  core.String seriesId;

  VolumeseriesinfoVolumeSeries();

  VolumeseriesinfoVolumeSeries.fromJson(core.Map _json) {
    if (_json.containsKey("issue")) {
      issue = _json["issue"].map((value) => new VolumeseriesinfoVolumeSeriesIssue.fromJson(value)).toList();
    }
    if (_json.containsKey("orderNumber")) {
      orderNumber = _json["orderNumber"];
    }
    if (_json.containsKey("seriesBookType")) {
      seriesBookType = _json["seriesBookType"];
    }
    if (_json.containsKey("seriesId")) {
      seriesId = _json["seriesId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (issue != null) {
      _json["issue"] = issue.map((value) => (value).toJson()).toList();
    }
    if (orderNumber != null) {
      _json["orderNumber"] = orderNumber;
    }
    if (seriesBookType != null) {
      _json["seriesBookType"] = seriesBookType;
    }
    if (seriesId != null) {
      _json["seriesId"] = seriesId;
    }
    return _json;
  }
}

class Volumeseriesinfo {
  /**
   * The display number string. This should be used only for display purposes
   * and the actual sequence should be inferred from the below orderNumber.
   */
  core.String bookDisplayNumber;
  /** Resource type. */
  core.String kind;
  /** Short book title in the context of the series. */
  core.String shortSeriesBookTitle;
  core.List<VolumeseriesinfoVolumeSeries> volumeSeries;

  Volumeseriesinfo();

  Volumeseriesinfo.fromJson(core.Map _json) {
    if (_json.containsKey("bookDisplayNumber")) {
      bookDisplayNumber = _json["bookDisplayNumber"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("shortSeriesBookTitle")) {
      shortSeriesBookTitle = _json["shortSeriesBookTitle"];
    }
    if (_json.containsKey("volumeSeries")) {
      volumeSeries = _json["volumeSeries"].map((value) => new VolumeseriesinfoVolumeSeries.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (bookDisplayNumber != null) {
      _json["bookDisplayNumber"] = bookDisplayNumber;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (shortSeriesBookTitle != null) {
      _json["shortSeriesBookTitle"] = shortSeriesBookTitle;
    }
    if (volumeSeries != null) {
      _json["volumeSeries"] = volumeSeries.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}
