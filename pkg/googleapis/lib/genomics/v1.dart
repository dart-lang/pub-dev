// This is a generated file (see the discoveryapis_generator project).

library googleapis.genomics.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client genomics/v1';

/** Upload, process, query, and search Genomics data in the cloud. */
class GenomicsApi {
  /** View and manage your data in Google BigQuery */
  static const BigqueryScope = "https://www.googleapis.com/auth/bigquery";

  /** View and manage your data across Google Cloud Platform services */
  static const CloudPlatformScope = "https://www.googleapis.com/auth/cloud-platform";

  /** Manage your data in Google Cloud Storage */
  static const DevstorageReadWriteScope = "https://www.googleapis.com/auth/devstorage.read_write";

  /** View and manage Genomics data */
  static const GenomicsScope = "https://www.googleapis.com/auth/genomics";

  /** View Genomics data */
  static const GenomicsReadonlyScope = "https://www.googleapis.com/auth/genomics.readonly";


  final commons.ApiRequester _requester;

  AnnotationsResourceApi get annotations => new AnnotationsResourceApi(_requester);
  AnnotationsetsResourceApi get annotationsets => new AnnotationsetsResourceApi(_requester);
  CallsetsResourceApi get callsets => new CallsetsResourceApi(_requester);
  DatasetsResourceApi get datasets => new DatasetsResourceApi(_requester);
  OperationsResourceApi get operations => new OperationsResourceApi(_requester);
  ReadgroupsetsResourceApi get readgroupsets => new ReadgroupsetsResourceApi(_requester);
  ReadsResourceApi get reads => new ReadsResourceApi(_requester);
  ReferencesResourceApi get references => new ReferencesResourceApi(_requester);
  ReferencesetsResourceApi get referencesets => new ReferencesetsResourceApi(_requester);
  VariantsResourceApi get variants => new VariantsResourceApi(_requester);
  VariantsetsResourceApi get variantsets => new VariantsetsResourceApi(_requester);

  GenomicsApi(http.Client client, {core.String rootUrl: "https://genomics.googleapis.com/", core.String servicePath: ""}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class AnnotationsResourceApi {
  final commons.ApiRequester _requester;

  AnnotationsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates one or more new annotations atomically. All annotations must
   * belong to the same annotation set. Caller must have WRITE
   * permission for this annotation set. For optimal performance, batch
   * positionally adjacent annotations together.
   *
   * If the request has a systemic issue, such as an attempt to write to
   * an inaccessible annotation set, the entire RPC will fail accordingly. For
   * lesser data issues, when possible an error will be isolated to the
   * corresponding batch entry in the response; the remaining well formed
   * annotations will be created normally.
   *
   * For details on the requirements for each individual annotation resource,
   * see
   * CreateAnnotation.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [BatchCreateAnnotationsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<BatchCreateAnnotationsResponse> batchCreate(BatchCreateAnnotationsRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/annotations:batchCreate';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new BatchCreateAnnotationsResponse.fromJson(data));
  }

  /**
   * Creates a new annotation. Caller must have WRITE permission
   * for the associated annotation set.
   *
   * The following fields are required:
   *
   * * annotationSetId
   * * referenceName or
   *   referenceId
   *
   * ### Transcripts
   *
   * For annotations of type TRANSCRIPT, the following fields of
   * transcript must be provided:
   *
   * * exons.start
   * * exons.end
   *
   * All other fields may be optionally specified, unless documented as being
   * server-generated (for example, the `id` field). The annotated
   * range must be no longer than 100Mbp (mega base pairs). See the
   * Annotation resource
   * for additional restrictions on each field.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [Annotation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Annotation> create(Annotation request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/annotations';

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
   * Deletes an annotation. Caller must have WRITE permission for
   * the associated annotation set.
   *
   * Request parameters:
   *
   * [annotationId] - The ID of the annotation to be deleted.
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> delete(core.String annotationId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (annotationId == null) {
      throw new core.ArgumentError("Parameter annotationId is required.");
    }

    _url = 'v1/annotations/' + commons.Escaper.ecapeVariable('$annotationId');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /**
   * Gets an annotation. Caller must have READ permission
   * for the associated annotation set.
   *
   * Request parameters:
   *
   * [annotationId] - The ID of the annotation to be retrieved.
   *
   * Completes with a [Annotation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Annotation> get(core.String annotationId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (annotationId == null) {
      throw new core.ArgumentError("Parameter annotationId is required.");
    }

    _url = 'v1/annotations/' + commons.Escaper.ecapeVariable('$annotationId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Annotation.fromJson(data));
  }

  /**
   * Searches for annotations that match the given criteria. Results are
   * ordered by genomic coordinate (by reference sequence, then position).
   * Annotations with equivalent genomic coordinates are returned in an
   * unspecified order. This order is consistent, such that two queries for the
   * same content (regardless of page size) yield annotations in the same order
   * across their respective streams of paginated responses. Caller must have
   * READ permission for the queried annotation sets.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [SearchAnnotationsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SearchAnnotationsResponse> search(SearchAnnotationsRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/annotations/search';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SearchAnnotationsResponse.fromJson(data));
  }

  /**
   * Updates an annotation. Caller must have
   * WRITE permission for the associated dataset.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [annotationId] - The ID of the annotation to be updated.
   *
   * [updateMask] - An optional mask specifying which fields to update. Mutable
   * fields are
   * name,
   * variant,
   * transcript, and
   * info. If unspecified, all mutable
   * fields will be updated.
   *
   * Completes with a [Annotation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Annotation> update(Annotation request, core.String annotationId, {core.String updateMask}) {
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
    if (updateMask != null) {
      _queryParams["updateMask"] = [updateMask];
    }

    _url = 'v1/annotations/' + commons.Escaper.ecapeVariable('$annotationId');

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


class AnnotationsetsResourceApi {
  final commons.ApiRequester _requester;

  AnnotationsetsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates a new annotation set. Caller must have WRITE permission for the
   * associated dataset.
   *
   * The following fields are required:
   *
   *   * datasetId
   *   * referenceSetId
   *
   * All other fields may be optionally specified, unless documented as being
   * server-generated (for example, the `id` field).
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [AnnotationSet].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AnnotationSet> create(AnnotationSet request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/annotationsets';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AnnotationSet.fromJson(data));
  }

  /**
   * Deletes an annotation set. Caller must have WRITE permission
   * for the associated annotation set.
   *
   * Request parameters:
   *
   * [annotationSetId] - The ID of the annotation set to be deleted.
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> delete(core.String annotationSetId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (annotationSetId == null) {
      throw new core.ArgumentError("Parameter annotationSetId is required.");
    }

    _url = 'v1/annotationsets/' + commons.Escaper.ecapeVariable('$annotationSetId');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /**
   * Gets an annotation set. Caller must have READ permission for
   * the associated dataset.
   *
   * Request parameters:
   *
   * [annotationSetId] - The ID of the annotation set to be retrieved.
   *
   * Completes with a [AnnotationSet].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AnnotationSet> get(core.String annotationSetId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (annotationSetId == null) {
      throw new core.ArgumentError("Parameter annotationSetId is required.");
    }

    _url = 'v1/annotationsets/' + commons.Escaper.ecapeVariable('$annotationSetId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AnnotationSet.fromJson(data));
  }

  /**
   * Searches for annotation sets that match the given criteria. Annotation sets
   * are returned in an unspecified order. This order is consistent, such that
   * two queries for the same content (regardless of page size) yield annotation
   * sets in the same order across their respective streams of paginated
   * responses. Caller must have READ permission for the queried datasets.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [SearchAnnotationSetsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SearchAnnotationSetsResponse> search(SearchAnnotationSetsRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/annotationsets/search';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SearchAnnotationSetsResponse.fromJson(data));
  }

  /**
   * Updates an annotation set. The update must respect all mutability
   * restrictions and other invariants described on the annotation set resource.
   * Caller must have WRITE permission for the associated dataset.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [annotationSetId] - The ID of the annotation set to be updated.
   *
   * [updateMask] - An optional mask specifying which fields to update. Mutable
   * fields are
   * name,
   * source_uri, and
   * info. If unspecified, all
   * mutable fields will be updated.
   *
   * Completes with a [AnnotationSet].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AnnotationSet> update(AnnotationSet request, core.String annotationSetId, {core.String updateMask}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (annotationSetId == null) {
      throw new core.ArgumentError("Parameter annotationSetId is required.");
    }
    if (updateMask != null) {
      _queryParams["updateMask"] = [updateMask];
    }

    _url = 'v1/annotationsets/' + commons.Escaper.ecapeVariable('$annotationSetId');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AnnotationSet.fromJson(data));
  }

}


class CallsetsResourceApi {
  final commons.ApiRequester _requester;

  CallsetsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates a new call set.
   *
   * For the definitions of call sets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [CallSet].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CallSet> create(CallSet request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/callsets';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CallSet.fromJson(data));
  }

  /**
   * Deletes a call set.
   *
   * For the definitions of call sets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * Request parameters:
   *
   * [callSetId] - The ID of the call set to be deleted.
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> delete(core.String callSetId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (callSetId == null) {
      throw new core.ArgumentError("Parameter callSetId is required.");
    }

    _url = 'v1/callsets/' + commons.Escaper.ecapeVariable('$callSetId');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /**
   * Gets a call set by ID.
   *
   * For the definitions of call sets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * Request parameters:
   *
   * [callSetId] - The ID of the call set.
   *
   * Completes with a [CallSet].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CallSet> get(core.String callSetId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (callSetId == null) {
      throw new core.ArgumentError("Parameter callSetId is required.");
    }

    _url = 'v1/callsets/' + commons.Escaper.ecapeVariable('$callSetId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CallSet.fromJson(data));
  }

  /**
   * Updates a call set.
   *
   * For the definitions of call sets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [callSetId] - The ID of the call set to be updated.
   *
   * [updateMask] - An optional mask specifying which fields to update. At this
   * time, the only
   * mutable field is name. The only
   * acceptable value is "name". If unspecified, all mutable fields will be
   * updated.
   *
   * Completes with a [CallSet].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CallSet> patch(CallSet request, core.String callSetId, {core.String updateMask}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (callSetId == null) {
      throw new core.ArgumentError("Parameter callSetId is required.");
    }
    if (updateMask != null) {
      _queryParams["updateMask"] = [updateMask];
    }

    _url = 'v1/callsets/' + commons.Escaper.ecapeVariable('$callSetId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CallSet.fromJson(data));
  }

  /**
   * Gets a list of call sets matching the criteria.
   *
   * For the definitions of call sets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * Implements
   * [GlobalAllianceApi.searchCallSets](https://github.com/ga4gh/schemas/blob/v0.5.1/src/main/resources/avro/variantmethods.avdl#L178).
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [SearchCallSetsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SearchCallSetsResponse> search(SearchCallSetsRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/callsets/search';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SearchCallSetsResponse.fromJson(data));
  }

}


class DatasetsResourceApi {
  final commons.ApiRequester _requester;

  DatasetsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates a new dataset.
   *
   * For the definitions of datasets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [Dataset].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Dataset> create(Dataset request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/datasets';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Dataset.fromJson(data));
  }

  /**
   * Deletes a dataset and all of its contents (all read group sets,
   * reference sets, variant sets, call sets, annotation sets, etc.)
   * This is reversible (up to one week after the deletion) via
   * the
   * datasets.undelete
   * operation.
   *
   * For the definitions of datasets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * Request parameters:
   *
   * [datasetId] - The ID of the dataset to be deleted.
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> delete(core.String datasetId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (datasetId == null) {
      throw new core.ArgumentError("Parameter datasetId is required.");
    }

    _url = 'v1/datasets/' + commons.Escaper.ecapeVariable('$datasetId');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /**
   * Gets a dataset by ID.
   *
   * For the definitions of datasets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * Request parameters:
   *
   * [datasetId] - The ID of the dataset.
   *
   * Completes with a [Dataset].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Dataset> get(core.String datasetId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (datasetId == null) {
      throw new core.ArgumentError("Parameter datasetId is required.");
    }

    _url = 'v1/datasets/' + commons.Escaper.ecapeVariable('$datasetId');

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
   * Gets the access control policy for the dataset. This is empty if the
   * policy or resource does not exist.
   *
   * See <a href="/iam/docs/managing-policies#getting_a_policy">Getting a
   * Policy</a> for more information.
   *
   * For the definitions of datasets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [resource] - REQUIRED: The resource for which policy is being specified.
   * Format is
   * `datasets/<dataset ID>`.
   * Value must have pattern "^datasets/[^/]+$".
   *
   * Completes with a [Policy].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Policy> getIamPolicy(GetIamPolicyRequest request, core.String resource) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (resource == null) {
      throw new core.ArgumentError("Parameter resource is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$resource') + ':getIamPolicy';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Policy.fromJson(data));
  }

  /**
   * Lists datasets within a project.
   *
   * For the definitions of datasets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * Request parameters:
   *
   * [pageToken] - The continuation token, which is used to page through large
   * result sets.
   * To get the next page of results, set this parameter to the value of
   * `nextPageToken` from the previous response.
   *
   * [pageSize] - The maximum number of results to return in a single page. If
   * unspecified,
   * defaults to 50. The maximum value is 1024.
   *
   * [projectId] - Required. The Google Cloud project ID to list datasets for.
   *
   * Completes with a [ListDatasetsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListDatasetsResponse> list({core.String pageToken, core.int pageSize, core.String projectId}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (projectId != null) {
      _queryParams["projectId"] = [projectId];
    }

    _url = 'v1/datasets';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListDatasetsResponse.fromJson(data));
  }

  /**
   * Updates a dataset.
   *
   * For the definitions of datasets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [datasetId] - The ID of the dataset to be updated.
   *
   * [updateMask] - An optional mask specifying which fields to update. At this
   * time, the only
   * mutable field is name. The only
   * acceptable value is "name". If unspecified, all mutable fields will be
   * updated.
   *
   * Completes with a [Dataset].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Dataset> patch(Dataset request, core.String datasetId, {core.String updateMask}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (datasetId == null) {
      throw new core.ArgumentError("Parameter datasetId is required.");
    }
    if (updateMask != null) {
      _queryParams["updateMask"] = [updateMask];
    }

    _url = 'v1/datasets/' + commons.Escaper.ecapeVariable('$datasetId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Dataset.fromJson(data));
  }

  /**
   * Sets the access control policy on the specified dataset. Replaces any
   * existing policy.
   *
   * For the definitions of datasets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * See <a href="/iam/docs/managing-policies#setting_a_policy">Setting a
   * Policy</a> for more information.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [resource] - REQUIRED: The resource for which policy is being specified.
   * Format is
   * `datasets/<dataset ID>`.
   * Value must have pattern "^datasets/[^/]+$".
   *
   * Completes with a [Policy].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Policy> setIamPolicy(SetIamPolicyRequest request, core.String resource) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (resource == null) {
      throw new core.ArgumentError("Parameter resource is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$resource') + ':setIamPolicy';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Policy.fromJson(data));
  }

  /**
   * Returns permissions that a caller has on the specified resource.
   * See <a href="/iam/docs/managing-policies#testing_permissions">Testing
   * Permissions</a> for more information.
   *
   * For the definitions of datasets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [resource] - REQUIRED: The resource for which policy is being specified.
   * Format is
   * `datasets/<dataset ID>`.
   * Value must have pattern "^datasets/[^/]+$".
   *
   * Completes with a [TestIamPermissionsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<TestIamPermissionsResponse> testIamPermissions(TestIamPermissionsRequest request, core.String resource) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (resource == null) {
      throw new core.ArgumentError("Parameter resource is required.");
    }

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$resource') + ':testIamPermissions';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new TestIamPermissionsResponse.fromJson(data));
  }

  /**
   * Undeletes a dataset by restoring a dataset which was deleted via this API.
   *
   * For the definitions of datasets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * This operation is only possible for a week after the deletion occurred.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [datasetId] - The ID of the dataset to be undeleted.
   *
   * Completes with a [Dataset].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Dataset> undelete(UndeleteDatasetRequest request, core.String datasetId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (datasetId == null) {
      throw new core.ArgumentError("Parameter datasetId is required.");
    }

    _url = 'v1/datasets/' + commons.Escaper.ecapeVariable('$datasetId') + ':undelete';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Dataset.fromJson(data));
  }

}


class OperationsResourceApi {
  final commons.ApiRequester _requester;

  OperationsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Starts asynchronous cancellation on a long-running operation. The server
   * makes a best effort to cancel the operation, but success is not guaranteed.
   * Clients may use Operations.GetOperation or Operations.ListOperations to
   * check whether the cancellation succeeded or the operation completed despite
   * cancellation.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [name] - The name of the operation resource to be cancelled.
   * Value must have pattern "^operations/.+$".
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> cancel(CancelOperationRequest request, core.String name) {
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

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$name') + ':cancel';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /**
   * Gets the latest state of a long-running operation.  Clients can use this
   * method to poll the operation result at intervals as recommended by the API
   * service.
   *
   * Request parameters:
   *
   * [name] - The name of the operation resource.
   * Value must have pattern "^operations/.+$".
   *
   * Completes with a [Operation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
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

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$name');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /**
   * Lists operations that match the specified filter in the request.
   *
   * Request parameters:
   *
   * [name] - The name of the operation collection.
   * Value must have pattern "^operations$".
   *
   * [pageToken] - The standard list page token.
   *
   * [pageSize] - The maximum number of results to return. If unspecified,
   * defaults to
   * 256. The maximum value is 2048.
   *
   * [filter] - A string for filtering Operations.
   * The following filter fields are supported&#58;
   *
   * * projectId&#58; Required. Corresponds to
   *   OperationMetadata.projectId.
   * * createTime&#58; The time this job was created, in seconds from the
   * [epoch](http://en.wikipedia.org/wiki/Unix_time). Can use `>=` and/or `<=`
   *   operators.
   * * status&#58; Can be `RUNNING`, `SUCCESS`, `FAILURE`, or `CANCELED`. Only
   *   one status may be specified.
   * * labels.key where key is a label key.
   *
   * Examples&#58;
   *
   * * `projectId = my-project AND createTime >= 1432140000`
   * * `projectId = my-project AND createTime >= 1432140000 AND createTime <=
   * 1432150000 AND status = RUNNING`
   * * `projectId = my-project AND labels.color = *`
   * * `projectId = my-project AND labels.color = red`
   *
   * Completes with a [ListOperationsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListOperationsResponse> list(core.String name, {core.String pageToken, core.int pageSize, core.String filter}) {
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

    _url = 'v1/' + commons.Escaper.ecapeVariableReserved('$name');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListOperationsResponse.fromJson(data));
  }

}


class ReadgroupsetsResourceApi {
  final commons.ApiRequester _requester;

  ReadgroupsetsCoveragebucketsResourceApi get coveragebuckets => new ReadgroupsetsCoveragebucketsResourceApi(_requester);

  ReadgroupsetsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Deletes a read group set.
   *
   * For the definitions of read group sets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * Request parameters:
   *
   * [readGroupSetId] - The ID of the read group set to be deleted. The caller
   * must have WRITE
   * permissions to the dataset associated with this read group set.
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> delete(core.String readGroupSetId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (readGroupSetId == null) {
      throw new core.ArgumentError("Parameter readGroupSetId is required.");
    }

    _url = 'v1/readgroupsets/' + commons.Escaper.ecapeVariable('$readGroupSetId');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /**
   * Exports a read group set to a BAM file in Google Cloud Storage.
   *
   * For the definitions of read group sets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * Note that currently there may be some differences between exported BAM
   * files and the original BAM file at the time of import. See
   * ImportReadGroupSets
   * for caveats.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [readGroupSetId] - Required. The ID of the read group set to export. The
   * caller must have
   * READ access to this read group set.
   *
   * Completes with a [Operation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Operation> export(ExportReadGroupSetRequest request, core.String readGroupSetId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (readGroupSetId == null) {
      throw new core.ArgumentError("Parameter readGroupSetId is required.");
    }

    _url = 'v1/readgroupsets/' + commons.Escaper.ecapeVariable('$readGroupSetId') + ':export';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /**
   * Gets a read group set by ID.
   *
   * For the definitions of read group sets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * Request parameters:
   *
   * [readGroupSetId] - The ID of the read group set.
   *
   * Completes with a [ReadGroupSet].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ReadGroupSet> get(core.String readGroupSetId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (readGroupSetId == null) {
      throw new core.ArgumentError("Parameter readGroupSetId is required.");
    }

    _url = 'v1/readgroupsets/' + commons.Escaper.ecapeVariable('$readGroupSetId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ReadGroupSet.fromJson(data));
  }

  /**
   * Creates read group sets by asynchronously importing the provided
   * information.
   *
   * For the definitions of read group sets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * The caller must have WRITE permissions to the dataset.
   *
   * ## Notes on [BAM](https://samtools.github.io/hts-specs/SAMv1.pdf) import
   *
   * - Tags will be converted to strings - tag types are not preserved
   * - Comments (`@CO`) in the input file header will not be preserved
   * - Original header order of references (`@SQ`) will not be preserved
   * - Any reverse stranded unmapped reads will be reverse complemented, and
   * their qualities (also the "BQ" and "OQ" tags, if any) will be reversed
   * - Unmapped reads will be stripped of positional information (reference name
   * and position)
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [Operation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Operation> import(ImportReadGroupSetsRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/readgroupsets:import';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /**
   * Updates a read group set.
   *
   * For the definitions of read group sets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [readGroupSetId] - The ID of the read group set to be updated. The caller
   * must have WRITE
   * permissions to the dataset associated with this read group set.
   *
   * [updateMask] - An optional mask specifying which fields to update.
   * Supported fields:
   *
   * * name.
   * * referenceSetId.
   *
   * Leaving `updateMask` unset is equivalent to specifying all mutable
   * fields.
   *
   * Completes with a [ReadGroupSet].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ReadGroupSet> patch(ReadGroupSet request, core.String readGroupSetId, {core.String updateMask}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (readGroupSetId == null) {
      throw new core.ArgumentError("Parameter readGroupSetId is required.");
    }
    if (updateMask != null) {
      _queryParams["updateMask"] = [updateMask];
    }

    _url = 'v1/readgroupsets/' + commons.Escaper.ecapeVariable('$readGroupSetId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ReadGroupSet.fromJson(data));
  }

  /**
   * Searches for read group sets matching the criteria.
   *
   * For the definitions of read group sets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * Implements
   * [GlobalAllianceApi.searchReadGroupSets](https://github.com/ga4gh/schemas/blob/v0.5.1/src/main/resources/avro/readmethods.avdl#L135).
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [SearchReadGroupSetsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SearchReadGroupSetsResponse> search(SearchReadGroupSetsRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/readgroupsets/search';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SearchReadGroupSetsResponse.fromJson(data));
  }

}


class ReadgroupsetsCoveragebucketsResourceApi {
  final commons.ApiRequester _requester;

  ReadgroupsetsCoveragebucketsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Lists fixed width coverage buckets for a read group set, each of which
   * correspond to a range of a reference sequence. Each bucket summarizes
   * coverage information across its corresponding genomic range.
   *
   * For the definitions of read group sets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * Coverage is defined as the number of reads which are aligned to a given
   * base in the reference sequence. Coverage buckets are available at several
   * precomputed bucket widths, enabling retrieval of various coverage 'zoom
   * levels'. The caller must have READ permissions for the target read group
   * set.
   *
   * Request parameters:
   *
   * [readGroupSetId] - Required. The ID of the read group set over which
   * coverage is requested.
   *
   * [start] - The start position of the range on the reference, 0-based
   * inclusive. If
   * specified, `referenceName` must also be specified. Defaults to 0.
   *
   * [targetBucketWidth] - The desired width of each reported coverage bucket in
   * base pairs. This
   * will be rounded down to the nearest precomputed bucket width; the value
   * of which is returned as `bucketWidth` in the response. Defaults
   * to infinity (each bucket spans an entire reference sequence) or the length
   * of the target range, if specified. The smallest precomputed
   * `bucketWidth` is currently 2048 base pairs; this is subject to
   * change.
   *
   * [referenceName] - The name of the reference to query, within the reference
   * set associated
   * with this query. Optional.
   *
   * [end] - The end position of the range on the reference, 0-based exclusive.
   * If
   * specified, `referenceName` must also be specified. If unset or 0, defaults
   * to the length of the reference.
   *
   * [pageToken] - The continuation token, which is used to page through large
   * result sets.
   * To get the next page of results, set this parameter to the value of
   * `nextPageToken` from the previous response.
   *
   * [pageSize] - The maximum number of results to return in a single page. If
   * unspecified,
   * defaults to 1024. The maximum value is 2048.
   *
   * Completes with a [ListCoverageBucketsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListCoverageBucketsResponse> list(core.String readGroupSetId, {core.String start, core.String targetBucketWidth, core.String referenceName, core.String end, core.String pageToken, core.int pageSize}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (readGroupSetId == null) {
      throw new core.ArgumentError("Parameter readGroupSetId is required.");
    }
    if (start != null) {
      _queryParams["start"] = [start];
    }
    if (targetBucketWidth != null) {
      _queryParams["targetBucketWidth"] = [targetBucketWidth];
    }
    if (referenceName != null) {
      _queryParams["referenceName"] = [referenceName];
    }
    if (end != null) {
      _queryParams["end"] = [end];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }

    _url = 'v1/readgroupsets/' + commons.Escaper.ecapeVariable('$readGroupSetId') + '/coveragebuckets';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListCoverageBucketsResponse.fromJson(data));
  }

}


class ReadsResourceApi {
  final commons.ApiRequester _requester;

  ReadsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets a list of reads for one or more read group sets.
   *
   * For the definitions of read group sets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * Reads search operates over a genomic coordinate space of reference sequence
   * & position defined over the reference sequences to which the requested
   * read group sets are aligned.
   *
   * If a target positional range is specified, search returns all reads whose
   * alignment to the reference genome overlap the range. A query which
   * specifies only read group set IDs yields all reads in those read group
   * sets, including unmapped reads.
   *
   * All reads returned (including reads on subsequent pages) are ordered by
   * genomic coordinate (by reference sequence, then position). Reads with
   * equivalent genomic coordinates are returned in an unspecified order. This
   * order is consistent, such that two queries for the same content (regardless
   * of page size) yield reads in the same order across their respective streams
   * of paginated responses.
   *
   * Implements
   * [GlobalAllianceApi.searchReads](https://github.com/ga4gh/schemas/blob/v0.5.1/src/main/resources/avro/readmethods.avdl#L85).
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [SearchReadsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SearchReadsResponse> search(SearchReadsRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/reads/search';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SearchReadsResponse.fromJson(data));
  }

}


class ReferencesResourceApi {
  final commons.ApiRequester _requester;

  ReferencesBasesResourceApi get bases => new ReferencesBasesResourceApi(_requester);

  ReferencesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets a reference.
   *
   * For the definitions of references and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * Implements
   * [GlobalAllianceApi.getReference](https://github.com/ga4gh/schemas/blob/v0.5.1/src/main/resources/avro/referencemethods.avdl#L158).
   *
   * Request parameters:
   *
   * [referenceId] - The ID of the reference.
   *
   * Completes with a [Reference].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Reference> get(core.String referenceId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (referenceId == null) {
      throw new core.ArgumentError("Parameter referenceId is required.");
    }

    _url = 'v1/references/' + commons.Escaper.ecapeVariable('$referenceId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Reference.fromJson(data));
  }

  /**
   * Searches for references which match the given criteria.
   *
   * For the definitions of references and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * Implements
   * [GlobalAllianceApi.searchReferences](https://github.com/ga4gh/schemas/blob/v0.5.1/src/main/resources/avro/referencemethods.avdl#L146).
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [SearchReferencesResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SearchReferencesResponse> search(SearchReferencesRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/references/search';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SearchReferencesResponse.fromJson(data));
  }

}


class ReferencesBasesResourceApi {
  final commons.ApiRequester _requester;

  ReferencesBasesResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Lists the bases in a reference, optionally restricted to a range.
   *
   * For the definitions of references and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * Implements
   * [GlobalAllianceApi.getReferenceBases](https://github.com/ga4gh/schemas/blob/v0.5.1/src/main/resources/avro/referencemethods.avdl#L221).
   *
   * Request parameters:
   *
   * [referenceId] - The ID of the reference.
   *
   * [pageToken] - The continuation token, which is used to page through large
   * result sets.
   * To get the next page of results, set this parameter to the value of
   * `nextPageToken` from the previous response.
   *
   * [pageSize] - The maximum number of bases to return in a single page. If
   * unspecified,
   * defaults to 200Kbp (kilo base pairs). The maximum value is 10Mbp (mega base
   * pairs).
   *
   * [start] - The start position (0-based) of this query. Defaults to 0.
   *
   * [end] - The end position (0-based, exclusive) of this query. Defaults to
   * the length
   * of this reference.
   *
   * Completes with a [ListBasesResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ListBasesResponse> list(core.String referenceId, {core.String pageToken, core.int pageSize, core.String start, core.String end}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (referenceId == null) {
      throw new core.ArgumentError("Parameter referenceId is required.");
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (pageSize != null) {
      _queryParams["pageSize"] = ["${pageSize}"];
    }
    if (start != null) {
      _queryParams["start"] = [start];
    }
    if (end != null) {
      _queryParams["end"] = [end];
    }

    _url = 'v1/references/' + commons.Escaper.ecapeVariable('$referenceId') + '/bases';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ListBasesResponse.fromJson(data));
  }

}


class ReferencesetsResourceApi {
  final commons.ApiRequester _requester;

  ReferencesetsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Gets a reference set.
   *
   * For the definitions of references and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * Implements
   * [GlobalAllianceApi.getReferenceSet](https://github.com/ga4gh/schemas/blob/v0.5.1/src/main/resources/avro/referencemethods.avdl#L83).
   *
   * Request parameters:
   *
   * [referenceSetId] - The ID of the reference set.
   *
   * Completes with a [ReferenceSet].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ReferenceSet> get(core.String referenceSetId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (referenceSetId == null) {
      throw new core.ArgumentError("Parameter referenceSetId is required.");
    }

    _url = 'v1/referencesets/' + commons.Escaper.ecapeVariable('$referenceSetId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ReferenceSet.fromJson(data));
  }

  /**
   * Searches for reference sets which match the given criteria.
   *
   * For the definitions of references and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * Implements
   * [GlobalAllianceApi.searchReferenceSets](https://github.com/ga4gh/schemas/blob/v0.5.1/src/main/resources/avro/referencemethods.avdl#L71)
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [SearchReferenceSetsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SearchReferenceSetsResponse> search(SearchReferenceSetsRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/referencesets/search';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SearchReferenceSetsResponse.fromJson(data));
  }

}


class VariantsResourceApi {
  final commons.ApiRequester _requester;

  VariantsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates a new variant.
   *
   * For the definitions of variants and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [Variant].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Variant> create(Variant request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/variants';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Variant.fromJson(data));
  }

  /**
   * Deletes a variant.
   *
   * For the definitions of variants and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * Request parameters:
   *
   * [variantId] - The ID of the variant to be deleted.
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> delete(core.String variantId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (variantId == null) {
      throw new core.ArgumentError("Parameter variantId is required.");
    }

    _url = 'v1/variants/' + commons.Escaper.ecapeVariable('$variantId');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /**
   * Gets a variant by ID.
   *
   * For the definitions of variants and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * Request parameters:
   *
   * [variantId] - The ID of the variant.
   *
   * Completes with a [Variant].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Variant> get(core.String variantId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (variantId == null) {
      throw new core.ArgumentError("Parameter variantId is required.");
    }

    _url = 'v1/variants/' + commons.Escaper.ecapeVariable('$variantId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Variant.fromJson(data));
  }

  /**
   * Creates variant data by asynchronously importing the provided information.
   *
   * For the definitions of variant sets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * The variants for import will be merged with any existing variant that
   * matches its reference sequence, start, end, reference bases, and
   * alternative bases. If no such variant exists, a new one will be created.
   *
   * When variants are merged, the call information from the new variant
   * is added to the existing variant, and Variant info fields are merged
   * as specified in
   * infoMergeConfig.
   * As a special case, for single-sample VCF files, QUAL and FILTER fields will
   * be moved to the call level; these are sometimes interpreted in a
   * call-specific context.
   * Imported VCF headers are appended to the metadata already in a variant set.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [Operation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Operation> import(ImportVariantsRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/variants:import';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /**
   * Merges the given variants with existing variants.
   *
   * For the definitions of variants and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * Each variant will be
   * merged with an existing variant that matches its reference sequence,
   * start, end, reference bases, and alternative bases. If no such variant
   * exists, a new one will be created.
   *
   * When variants are merged, the call information from the new variant
   * is added to the existing variant. Variant info fields are merged as
   * specified in the
   * infoMergeConfig
   * field of the MergeVariantsRequest.
   *
   * Please exercise caution when using this method!  It is easy to introduce
   * mistakes in existing variants and difficult to back out of them.  For
   * example,
   * suppose you were trying to merge a new variant with an existing one and
   * both
   * variants contain calls that belong to callsets with the same callset ID.
   *
   *     // Existing variant - irrelevant fields trimmed for clarity
   *     {
   *         "variantSetId": "10473108253681171589",
   *         "referenceName": "1",
   *         "start": "10582",
   *         "referenceBases": "G",
   *         "alternateBases": [
   *             "A"
   *         ],
   *         "calls": [
   *             {
   *                 "callSetId": "10473108253681171589-0",
   *                 "callSetName": "CALLSET0",
   *                 "genotype": [
   *                     0,
   *                     1
   *                 ],
   *             }
   *         ]
   *     }
   *
   *     // New variant with conflicting call information
   *     {
   *         "variantSetId": "10473108253681171589",
   *         "referenceName": "1",
   *         "start": "10582",
   *         "referenceBases": "G",
   *         "alternateBases": [
   *             "A"
   *         ],
   *         "calls": [
   *             {
   *                 "callSetId": "10473108253681171589-0",
   *                 "callSetName": "CALLSET0",
   *                 "genotype": [
   *                     1,
   *                     1
   *                 ],
   *             }
   *         ]
   *     }
   *
   * The resulting merged variant would overwrite the existing calls with those
   * from the new variant:
   *
   *     {
   *         "variantSetId": "10473108253681171589",
   *         "referenceName": "1",
   *         "start": "10582",
   *         "referenceBases": "G",
   *         "alternateBases": [
   *             "A"
   *         ],
   *         "calls": [
   *             {
   *                 "callSetId": "10473108253681171589-0",
   *                 "callSetName": "CALLSET0",
   *                 "genotype": [
   *                     1,
   *                     1
   *                 ],
   *             }
   *         ]
   *     }
   *
   * This may be the desired outcome, but it is up to the user to determine if
   * if that is indeed the case.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> merge(MergeVariantsRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/variants:merge';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /**
   * Updates a variant.
   *
   * For the definitions of variants and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * This method supports patch semantics. Returns the modified variant without
   * its calls.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [variantId] - The ID of the variant to be updated.
   *
   * [updateMask] - An optional mask specifying which fields to update. At this
   * time, mutable
   * fields are names and
   * info. Acceptable values are "names" and
   * "info". If unspecified, all mutable fields will be updated.
   *
   * Completes with a [Variant].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Variant> patch(Variant request, core.String variantId, {core.String updateMask}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (variantId == null) {
      throw new core.ArgumentError("Parameter variantId is required.");
    }
    if (updateMask != null) {
      _queryParams["updateMask"] = [updateMask];
    }

    _url = 'v1/variants/' + commons.Escaper.ecapeVariable('$variantId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Variant.fromJson(data));
  }

  /**
   * Gets a list of variants matching the criteria.
   *
   * For the definitions of variants and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * Implements
   * [GlobalAllianceApi.searchVariants](https://github.com/ga4gh/schemas/blob/v0.5.1/src/main/resources/avro/variantmethods.avdl#L126).
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [SearchVariantsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SearchVariantsResponse> search(SearchVariantsRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/variants/search';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SearchVariantsResponse.fromJson(data));
  }

}


class VariantsetsResourceApi {
  final commons.ApiRequester _requester;

  VariantsetsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Creates a new variant set.
   *
   * For the definitions of variant sets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * The provided variant set must have a valid `datasetId` set - all other
   * fields are optional. Note that the `id` field will be ignored, as this is
   * assigned by the server.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [VariantSet].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<VariantSet> create(VariantSet request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/variantsets';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new VariantSet.fromJson(data));
  }

  /**
   * Deletes a variant set including all variants, call sets, and calls within.
   * This is not reversible.
   *
   * For the definitions of variant sets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * Request parameters:
   *
   * [variantSetId] - The ID of the variant set to be deleted.
   *
   * Completes with a [Empty].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Empty> delete(core.String variantSetId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (variantSetId == null) {
      throw new core.ArgumentError("Parameter variantSetId is required.");
    }

    _url = 'v1/variantsets/' + commons.Escaper.ecapeVariable('$variantSetId');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Empty.fromJson(data));
  }

  /**
   * Exports variant set data to an external destination.
   *
   * For the definitions of variant sets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [variantSetId] - Required. The ID of the variant set that contains variant
   * data which
   * should be exported. The caller must have READ access to this variant set.
   *
   * Completes with a [Operation].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Operation> export(ExportVariantSetRequest request, core.String variantSetId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (variantSetId == null) {
      throw new core.ArgumentError("Parameter variantSetId is required.");
    }

    _url = 'v1/variantsets/' + commons.Escaper.ecapeVariable('$variantSetId') + ':export';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Operation.fromJson(data));
  }

  /**
   * Gets a variant set by ID.
   *
   * For the definitions of variant sets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * Request parameters:
   *
   * [variantSetId] - Required. The ID of the variant set.
   *
   * Completes with a [VariantSet].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<VariantSet> get(core.String variantSetId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (variantSetId == null) {
      throw new core.ArgumentError("Parameter variantSetId is required.");
    }

    _url = 'v1/variantsets/' + commons.Escaper.ecapeVariable('$variantSetId');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new VariantSet.fromJson(data));
  }

  /**
   * Updates a variant set using patch semantics.
   *
   * For the definitions of variant sets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [variantSetId] - The ID of the variant to be updated (must already exist).
   *
   * [updateMask] - An optional mask specifying which fields to update.
   * Supported fields:
   *
   * * metadata.
   * * name.
   * * description.
   *
   * Leaving `updateMask` unset is equivalent to specifying all mutable
   * fields.
   *
   * Completes with a [VariantSet].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<VariantSet> patch(VariantSet request, core.String variantSetId, {core.String updateMask}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (variantSetId == null) {
      throw new core.ArgumentError("Parameter variantSetId is required.");
    }
    if (updateMask != null) {
      _queryParams["updateMask"] = [updateMask];
    }

    _url = 'v1/variantsets/' + commons.Escaper.ecapeVariable('$variantSetId');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new VariantSet.fromJson(data));
  }

  /**
   * Returns a list of all variant sets matching search criteria.
   *
   * For the definitions of variant sets and other genomics resources, see
   * [Fundamentals of Google
   * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
   *
   * Implements
   * [GlobalAllianceApi.searchVariantSets](https://github.com/ga4gh/schemas/blob/v0.5.1/src/main/resources/avro/variantmethods.avdl#L49).
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [SearchVariantSetsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<SearchVariantSetsResponse> search(SearchVariantSetsRequest request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _url = 'v1/variantsets/search';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new SearchVariantSetsResponse.fromJson(data));
  }

}



/**
 * An annotation describes a region of reference genome. The value of an
 * annotation may be one of several canonical types, supplemented by arbitrary
 * info tags. An annotation is not inherently associated with a specific
 * sample or individual (though a client could choose to use annotations in
 * this way). Example canonical annotation types are `GENE` and
 * `VARIANT`.
 */
class Annotation {
  /** The annotation set to which this annotation belongs. */
  core.String annotationSetId;
  /** The end position of the range on the reference, 0-based exclusive. */
  core.String end;
  /** The server-generated annotation ID, unique across all annotations. */
  core.String id;
  /**
   * A map of additional read alignment information. This must be of the form
   * map<string, string[]> (string key mapping to a list of string values).
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Map<core.String, core.List<core.Object>> info;
  /** The display name of this annotation. */
  core.String name;
  /** The ID of the Google Genomics reference associated with this range. */
  core.String referenceId;
  /**
   * The display name corresponding to the reference specified by
   * `referenceId`, for example `chr1`, `1`, or `chrX`.
   */
  core.String referenceName;
  /**
   * Whether this range refers to the reverse strand, as opposed to the forward
   * strand. Note that regardless of this field, the start/end position of the
   * range always refer to the forward strand.
   */
  core.bool reverseStrand;
  /** The start position of the range on the reference, 0-based inclusive. */
  core.String start;
  /**
   * A transcript value represents the assertion that a particular region of
   * the reference genome may be transcribed as RNA. An alternative splicing
   * pattern would be represented as a separate transcript object. This field
   * is only set for annotations of type `TRANSCRIPT`.
   */
  Transcript transcript;
  /**
   * The data type for this annotation. Must match the containing annotation
   * set's type.
   * Possible string values are:
   * - "ANNOTATION_TYPE_UNSPECIFIED"
   * - "GENERIC" : A `GENERIC` annotation type should be used when no other
   * annotation
   * type will suffice. This represents an untyped annotation of the reference
   * genome.
   * - "VARIANT" : A `VARIANT` annotation type.
   * - "GENE" : A `GENE` annotation type represents the existence of a gene at
   * the
   * associated reference coordinates. The start coordinate is typically the
   * gene's transcription start site and the end is typically the end of the
   * gene's last exon.
   * - "TRANSCRIPT" : A `TRANSCRIPT` annotation type represents the assertion
   * that a
   * particular region of the reference genome may be transcribed as RNA.
   */
  core.String type;
  /**
   * A variant annotation, which describes the effect of a variant on the
   * genome, the coding sequence, and/or higher level consequences at the
   * organism level e.g. pathogenicity. This field is only set for annotations
   * of type `VARIANT`.
   */
  VariantAnnotation variant;

  Annotation();

  Annotation.fromJson(core.Map _json) {
    if (_json.containsKey("annotationSetId")) {
      annotationSetId = _json["annotationSetId"];
    }
    if (_json.containsKey("end")) {
      end = _json["end"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("info")) {
      info = _json["info"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("referenceId")) {
      referenceId = _json["referenceId"];
    }
    if (_json.containsKey("referenceName")) {
      referenceName = _json["referenceName"];
    }
    if (_json.containsKey("reverseStrand")) {
      reverseStrand = _json["reverseStrand"];
    }
    if (_json.containsKey("start")) {
      start = _json["start"];
    }
    if (_json.containsKey("transcript")) {
      transcript = new Transcript.fromJson(_json["transcript"]);
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
    if (_json.containsKey("variant")) {
      variant = new VariantAnnotation.fromJson(_json["variant"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (annotationSetId != null) {
      _json["annotationSetId"] = annotationSetId;
    }
    if (end != null) {
      _json["end"] = end;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (info != null) {
      _json["info"] = info;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (referenceId != null) {
      _json["referenceId"] = referenceId;
    }
    if (referenceName != null) {
      _json["referenceName"] = referenceName;
    }
    if (reverseStrand != null) {
      _json["reverseStrand"] = reverseStrand;
    }
    if (start != null) {
      _json["start"] = start;
    }
    if (transcript != null) {
      _json["transcript"] = (transcript).toJson();
    }
    if (type != null) {
      _json["type"] = type;
    }
    if (variant != null) {
      _json["variant"] = (variant).toJson();
    }
    return _json;
  }
}

/**
 * An annotation set is a logical grouping of annotations that share consistent
 * type information and provenance. Examples of annotation sets include 'all
 * genes from refseq', and 'all variant annotations from ClinVar'.
 */
class AnnotationSet {
  /** The dataset to which this annotation set belongs. */
  core.String datasetId;
  /**
   * The server-generated annotation set ID, unique across all annotation sets.
   */
  core.String id;
  /**
   * A map of additional read alignment information. This must be of the form
   * map<string, string[]> (string key mapping to a list of string values).
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Map<core.String, core.List<core.Object>> info;
  /** The display name for this annotation set. */
  core.String name;
  /**
   * The ID of the reference set that defines the coordinate space for this
   * set's annotations.
   */
  core.String referenceSetId;
  /**
   * The source URI describing the file from which this annotation set was
   * generated, if any.
   */
  core.String sourceUri;
  /**
   * The type of annotations contained within this set.
   * Possible string values are:
   * - "ANNOTATION_TYPE_UNSPECIFIED"
   * - "GENERIC" : A `GENERIC` annotation type should be used when no other
   * annotation
   * type will suffice. This represents an untyped annotation of the reference
   * genome.
   * - "VARIANT" : A `VARIANT` annotation type.
   * - "GENE" : A `GENE` annotation type represents the existence of a gene at
   * the
   * associated reference coordinates. The start coordinate is typically the
   * gene's transcription start site and the end is typically the end of the
   * gene's last exon.
   * - "TRANSCRIPT" : A `TRANSCRIPT` annotation type represents the assertion
   * that a
   * particular region of the reference genome may be transcribed as RNA.
   */
  core.String type;

  AnnotationSet();

  AnnotationSet.fromJson(core.Map _json) {
    if (_json.containsKey("datasetId")) {
      datasetId = _json["datasetId"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("info")) {
      info = _json["info"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("referenceSetId")) {
      referenceSetId = _json["referenceSetId"];
    }
    if (_json.containsKey("sourceUri")) {
      sourceUri = _json["sourceUri"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (datasetId != null) {
      _json["datasetId"] = datasetId;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (info != null) {
      _json["info"] = info;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (referenceSetId != null) {
      _json["referenceSetId"] = referenceSetId;
    }
    if (sourceUri != null) {
      _json["sourceUri"] = sourceUri;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

class BatchCreateAnnotationsRequest {
  /**
   * The annotations to be created. At most 4096 can be specified in a single
   * request.
   */
  core.List<Annotation> annotations;
  /**
   * A unique request ID which enables the server to detect duplicated requests.
   * If provided, duplicated requests will result in the same response; if not
   * provided, duplicated requests may result in duplicated data. For a given
   * annotation set, callers should not reuse `request_id`s when writing
   * different batches of annotations - behavior in this case is undefined.
   * A common approach is to use a UUID. For batch jobs where worker crashes are
   * a possibility, consider using some unique variant of a worker or run ID.
   */
  core.String requestId;

  BatchCreateAnnotationsRequest();

  BatchCreateAnnotationsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("annotations")) {
      annotations = _json["annotations"].map((value) => new Annotation.fromJson(value)).toList();
    }
    if (_json.containsKey("requestId")) {
      requestId = _json["requestId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (annotations != null) {
      _json["annotations"] = annotations.map((value) => (value).toJson()).toList();
    }
    if (requestId != null) {
      _json["requestId"] = requestId;
    }
    return _json;
  }
}

class BatchCreateAnnotationsResponse {
  /**
   * The resulting per-annotation entries, ordered consistently with the
   * original request.
   */
  core.List<Entry> entries;

  BatchCreateAnnotationsResponse();

  BatchCreateAnnotationsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("entries")) {
      entries = _json["entries"].map((value) => new Entry.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (entries != null) {
      _json["entries"] = entries.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Associates `members` with a `role`. */
class Binding {
  /**
   * Specifies the identities requesting access for a Cloud Platform resource.
   * `members` can have the following values:
   *
   * * `allUsers`: A special identifier that represents anyone who is
   *    on the internet; with or without a Google account.
   *
   * * `allAuthenticatedUsers`: A special identifier that represents anyone
   *    who is authenticated with a Google account or a service account.
   *
   * * `user:{emailid}`: An email address that represents a specific Google
   *    account. For example, `alice@gmail.com` or `joe@example.com`.
   *
   *
   * * `serviceAccount:{emailid}`: An email address that represents a service
   *    account. For example, `my-other-app@appspot.gserviceaccount.com`.
   *
   * * `group:{emailid}`: An email address that represents a Google group.
   *    For example, `admins@example.com`.
   *
   * * `domain:{domain}`: A Google Apps domain name that represents all the
   *    users of that domain. For example, `google.com` or `example.com`.
   */
  core.List<core.String> members;
  /**
   * Role that is assigned to `members`.
   * For example, `roles/viewer`, `roles/editor`, or `roles/owner`.
   * Required
   */
  core.String role;

  Binding();

  Binding.fromJson(core.Map _json) {
    if (_json.containsKey("members")) {
      members = _json["members"];
    }
    if (_json.containsKey("role")) {
      role = _json["role"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (members != null) {
      _json["members"] = members;
    }
    if (role != null) {
      _json["role"] = role;
    }
    return _json;
  }
}

/**
 * A call set is a collection of variant calls, typically for one sample. It
 * belongs to a variant set.
 *
 * For more genomics resource definitions, see [Fundamentals of Google
 * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
 */
class CallSet {
  /** The date this call set was created in milliseconds from the epoch. */
  core.String created;
  /** The server-generated call set ID, unique across all call sets. */
  core.String id;
  /**
   * A map of additional call set information. This must be of the form
   * map<string, string[]> (string key mapping to a list of string values).
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Map<core.String, core.List<core.Object>> info;
  /** The call set name. */
  core.String name;
  /** The sample ID this call set corresponds to. */
  core.String sampleId;
  /**
   * The IDs of the variant sets this call set belongs to. This field must
   * have exactly length one, as a call set belongs to a single variant set.
   * This field is repeated for compatibility with the
   * [GA4GH 0.5.1
   * API](https://github.com/ga4gh/schemas/blob/v0.5.1/src/main/resources/avro/variants.avdl#L76).
   */
  core.List<core.String> variantSetIds;

  CallSet();

  CallSet.fromJson(core.Map _json) {
    if (_json.containsKey("created")) {
      created = _json["created"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("info")) {
      info = _json["info"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("sampleId")) {
      sampleId = _json["sampleId"];
    }
    if (_json.containsKey("variantSetIds")) {
      variantSetIds = _json["variantSetIds"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (created != null) {
      _json["created"] = created;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (info != null) {
      _json["info"] = info;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (sampleId != null) {
      _json["sampleId"] = sampleId;
    }
    if (variantSetIds != null) {
      _json["variantSetIds"] = variantSetIds;
    }
    return _json;
  }
}

/** The request message for Operations.CancelOperation. */
class CancelOperationRequest {

  CancelOperationRequest();

  CancelOperationRequest.fromJson(core.Map _json) {
  }

  core.Map toJson() {
    var _json = new core.Map();
    return _json;
  }
}

/** A single CIGAR operation. */
class CigarUnit {
  /**
   *
   * Possible string values are:
   * - "OPERATION_UNSPECIFIED"
   * - "ALIGNMENT_MATCH" : An alignment match indicates that a sequence can be
   * aligned to the
   * reference without evidence of an INDEL. Unlike the
   * `SEQUENCE_MATCH` and `SEQUENCE_MISMATCH` operators,
   * the `ALIGNMENT_MATCH` operator does not indicate whether the
   * reference and read sequences are an exact match. This operator is
   * equivalent to SAM's `M`.
   * - "INSERT" : The insert operator indicates that the read contains evidence
   * of bases
   * being inserted into the reference. This operator is equivalent to SAM's
   * `I`.
   * - "DELETE" : The delete operator indicates that the read contains evidence
   * of bases
   * being deleted from the reference. This operator is equivalent to SAM's
   * `D`.
   * - "SKIP" : The skip operator indicates that this read skips a long segment
   * of the
   * reference, but the bases have not been deleted. This operator is commonly
   * used when working with RNA-seq data, where reads may skip long segments
   * of the reference between exons. This operator is equivalent to SAM's
   * `N`.
   * - "CLIP_SOFT" : The soft clip operator indicates that bases at the
   * start/end of a read
   * have not been considered during alignment. This may occur if the majority
   * of a read maps, except for low quality bases at the start/end of a read.
   * This operator is equivalent to SAM's `S`. Bases that are soft
   * clipped will still be stored in the read.
   * - "CLIP_HARD" : The hard clip operator indicates that bases at the
   * start/end of a read
   * have been omitted from this alignment. This may occur if this linear
   * alignment is part of a chimeric alignment, or if the read has been
   * trimmed (for example, during error correction or to trim poly-A tails for
   * RNA-seq). This operator is equivalent to SAM's `H`.
   * - "PAD" : The pad operator indicates that there is padding in an alignment.
   * This
   * operator is equivalent to SAM's `P`.
   * - "SEQUENCE_MATCH" : This operator indicates that this portion of the
   * aligned sequence exactly
   * matches the reference. This operator is equivalent to SAM's `=`.
   * - "SEQUENCE_MISMATCH" : This operator indicates that this portion of the
   * aligned sequence is an
   * alignment match to the reference, but a sequence mismatch. This can
   * indicate a SNP or a read error. This operator is equivalent to SAM's
   * `X`.
   */
  core.String operation;
  /** The number of genomic bases that the operation runs for. Required. */
  core.String operationLength;
  /**
   * `referenceSequence` is only used at mismatches
   * (`SEQUENCE_MISMATCH`) and deletions (`DELETE`).
   * Filling this field replaces SAM's MD tag. If the relevant information is
   * not available, this field is unset.
   */
  core.String referenceSequence;

  CigarUnit();

  CigarUnit.fromJson(core.Map _json) {
    if (_json.containsKey("operation")) {
      operation = _json["operation"];
    }
    if (_json.containsKey("operationLength")) {
      operationLength = _json["operationLength"];
    }
    if (_json.containsKey("referenceSequence")) {
      referenceSequence = _json["referenceSequence"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (operation != null) {
      _json["operation"] = operation;
    }
    if (operationLength != null) {
      _json["operationLength"] = operationLength;
    }
    if (referenceSequence != null) {
      _json["referenceSequence"] = referenceSequence;
    }
    return _json;
  }
}

class ClinicalCondition {
  /**
   * The MedGen concept id associated with this gene.
   * Search for these IDs at http://www.ncbi.nlm.nih.gov/medgen/
   */
  core.String conceptId;
  /** The set of external IDs for this condition. */
  core.List<ExternalId> externalIds;
  /** A set of names for the condition. */
  core.List<core.String> names;
  /**
   * The OMIM id for this condition.
   * Search for these IDs at http://omim.org/
   */
  core.String omimId;

  ClinicalCondition();

  ClinicalCondition.fromJson(core.Map _json) {
    if (_json.containsKey("conceptId")) {
      conceptId = _json["conceptId"];
    }
    if (_json.containsKey("externalIds")) {
      externalIds = _json["externalIds"].map((value) => new ExternalId.fromJson(value)).toList();
    }
    if (_json.containsKey("names")) {
      names = _json["names"];
    }
    if (_json.containsKey("omimId")) {
      omimId = _json["omimId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (conceptId != null) {
      _json["conceptId"] = conceptId;
    }
    if (externalIds != null) {
      _json["externalIds"] = externalIds.map((value) => (value).toJson()).toList();
    }
    if (names != null) {
      _json["names"] = names;
    }
    if (omimId != null) {
      _json["omimId"] = omimId;
    }
    return _json;
  }
}

class CodingSequence {
  /**
   * The end of the coding sequence on this annotation's reference sequence,
   * 0-based exclusive. Note that this position is relative to the reference
   * start, and *not* the containing annotation start.
   */
  core.String end;
  /**
   * The start of the coding sequence on this annotation's reference sequence,
   * 0-based inclusive. Note that this position is relative to the reference
   * start, and *not* the containing annotation start.
   */
  core.String start;

  CodingSequence();

  CodingSequence.fromJson(core.Map _json) {
    if (_json.containsKey("end")) {
      end = _json["end"];
    }
    if (_json.containsKey("start")) {
      start = _json["start"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (end != null) {
      _json["end"] = end;
    }
    if (start != null) {
      _json["start"] = start;
    }
    return _json;
  }
}

/**
 * Describes a Compute Engine resource that is being managed by a running
 * pipeline.
 */
class ComputeEngine {
  /** The names of the disks that were created for this pipeline. */
  core.List<core.String> diskNames;
  /** The instance on which the operation is running. */
  core.String instanceName;
  /** The machine type of the instance. */
  core.String machineType;
  /** The availability zone in which the instance resides. */
  core.String zone;

  ComputeEngine();

  ComputeEngine.fromJson(core.Map _json) {
    if (_json.containsKey("diskNames")) {
      diskNames = _json["diskNames"];
    }
    if (_json.containsKey("instanceName")) {
      instanceName = _json["instanceName"];
    }
    if (_json.containsKey("machineType")) {
      machineType = _json["machineType"];
    }
    if (_json.containsKey("zone")) {
      zone = _json["zone"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (diskNames != null) {
      _json["diskNames"] = diskNames;
    }
    if (instanceName != null) {
      _json["instanceName"] = instanceName;
    }
    if (machineType != null) {
      _json["machineType"] = machineType;
    }
    if (zone != null) {
      _json["zone"] = zone;
    }
    return _json;
  }
}

/**
 * A bucket over which read coverage has been precomputed. A bucket corresponds
 * to a specific range of the reference sequence.
 */
class CoverageBucket {
  /**
   * The average number of reads which are aligned to each individual
   * reference base in this bucket.
   */
  core.double meanCoverage;
  /** The genomic coordinate range spanned by this bucket. */
  Range range;

  CoverageBucket();

  CoverageBucket.fromJson(core.Map _json) {
    if (_json.containsKey("meanCoverage")) {
      meanCoverage = _json["meanCoverage"];
    }
    if (_json.containsKey("range")) {
      range = new Range.fromJson(_json["range"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (meanCoverage != null) {
      _json["meanCoverage"] = meanCoverage;
    }
    if (range != null) {
      _json["range"] = (range).toJson();
    }
    return _json;
  }
}

/**
 * A Dataset is a collection of genomic data.
 *
 * For more genomics resource definitions, see [Fundamentals of Google
 * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
 */
class Dataset {
  /** The time this dataset was created, in seconds from the epoch. */
  core.String createTime;
  /** The server-generated dataset ID, unique across all datasets. */
  core.String id;
  /** The dataset name. */
  core.String name;
  /** The Google Cloud project ID that this dataset belongs to. */
  core.String projectId;

  Dataset();

  Dataset.fromJson(core.Map _json) {
    if (_json.containsKey("createTime")) {
      createTime = _json["createTime"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (createTime != null) {
      _json["createTime"] = createTime;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    return _json;
  }
}

/**
 * A generic empty message that you can re-use to avoid defining duplicated
 * empty messages in your APIs. A typical example is to use it as the request
 * or the response type of an API method. For instance:
 *
 *     service Foo {
 *       rpc Bar(google.protobuf.Empty) returns (google.protobuf.Empty);
 *     }
 *
 * The JSON representation for `Empty` is empty JSON object `{}`.
 */
class Empty {

  Empty();

  Empty.fromJson(core.Map _json) {
  }

  core.Map toJson() {
    var _json = new core.Map();
    return _json;
  }
}

class Entry {
  /** The created annotation, if creation was successful. */
  Annotation annotation;
  /** The creation status. */
  Status status;

  Entry();

  Entry.fromJson(core.Map _json) {
    if (_json.containsKey("annotation")) {
      annotation = new Annotation.fromJson(_json["annotation"]);
    }
    if (_json.containsKey("status")) {
      status = new Status.fromJson(_json["status"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (annotation != null) {
      _json["annotation"] = (annotation).toJson();
    }
    if (status != null) {
      _json["status"] = (status).toJson();
    }
    return _json;
  }
}

class Exon {
  /**
   * The end position of the exon on this annotation's reference sequence,
   * 0-based exclusive. Note that this is relative to the reference start, and
   * *not* the containing annotation start.
   */
  core.String end;
  /**
   * The frame of this exon. Contains a value of 0, 1, or 2, which indicates
   * the offset of the first coding base of the exon within the reading frame
   * of the coding DNA sequence, if any. This field is dependent on the
   * strandedness of this annotation (see
   * Annotation.reverse_strand).
   * For forward stranded annotations, this offset is relative to the
   * exon.start. For reverse
   * strand annotations, this offset is relative to the
   * exon.end `- 1`.
   *
   * Unset if this exon does not intersect the coding sequence. Upon creation
   * of a transcript, the frame must be populated for all or none of the
   * coding exons.
   */
  core.int frame;
  /**
   * The start position of the exon on this annotation's reference sequence,
   * 0-based inclusive. Note that this is relative to the reference start, and
   * **not** the containing annotation start.
   */
  core.String start;

  Exon();

  Exon.fromJson(core.Map _json) {
    if (_json.containsKey("end")) {
      end = _json["end"];
    }
    if (_json.containsKey("frame")) {
      frame = _json["frame"];
    }
    if (_json.containsKey("start")) {
      start = _json["start"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (end != null) {
      _json["end"] = end;
    }
    if (frame != null) {
      _json["frame"] = frame;
    }
    if (start != null) {
      _json["start"] = start;
    }
    return _json;
  }
}

class Experiment {
  /**
   * The instrument model used as part of this experiment. This maps to
   * sequencing technology in the SAM spec.
   */
  core.String instrumentModel;
  /**
   * A client-supplied library identifier; a library is a collection of DNA
   * fragments which have been prepared for sequencing from a sample. This
   * field is important for quality control as error or bias can be introduced
   * during sample preparation.
   */
  core.String libraryId;
  /**
   * The platform unit used as part of this experiment, for example
   * flowcell-barcode.lane for Illumina or slide for SOLiD. Corresponds to the
   * @RG PU field in the SAM spec.
   */
  core.String platformUnit;
  /** The sequencing center used as part of this experiment. */
  core.String sequencingCenter;

  Experiment();

  Experiment.fromJson(core.Map _json) {
    if (_json.containsKey("instrumentModel")) {
      instrumentModel = _json["instrumentModel"];
    }
    if (_json.containsKey("libraryId")) {
      libraryId = _json["libraryId"];
    }
    if (_json.containsKey("platformUnit")) {
      platformUnit = _json["platformUnit"];
    }
    if (_json.containsKey("sequencingCenter")) {
      sequencingCenter = _json["sequencingCenter"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (instrumentModel != null) {
      _json["instrumentModel"] = instrumentModel;
    }
    if (libraryId != null) {
      _json["libraryId"] = libraryId;
    }
    if (platformUnit != null) {
      _json["platformUnit"] = platformUnit;
    }
    if (sequencingCenter != null) {
      _json["sequencingCenter"] = sequencingCenter;
    }
    return _json;
  }
}

/** The read group set export request. */
class ExportReadGroupSetRequest {
  /**
   * Required. A Google Cloud Storage URI for the exported BAM file.
   * The currently authenticated user must have write access to the new file.
   * An error will be returned if the URI already contains data.
   */
  core.String exportUri;
  /**
   * Required. The Google Cloud project ID that owns this
   * export. The caller must have WRITE access to this project.
   */
  core.String projectId;
  /**
   * The reference names to export. If this is not specified, all reference
   * sequences, including unmapped reads, are exported.
   * Use `*` to export only unmapped reads.
   */
  core.List<core.String> referenceNames;

  ExportReadGroupSetRequest();

  ExportReadGroupSetRequest.fromJson(core.Map _json) {
    if (_json.containsKey("exportUri")) {
      exportUri = _json["exportUri"];
    }
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
    if (_json.containsKey("referenceNames")) {
      referenceNames = _json["referenceNames"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (exportUri != null) {
      _json["exportUri"] = exportUri;
    }
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    if (referenceNames != null) {
      _json["referenceNames"] = referenceNames;
    }
    return _json;
  }
}

/** The variant data export request. */
class ExportVariantSetRequest {
  /**
   * Required. The BigQuery dataset to export data to. This dataset must already
   * exist. Note that this is distinct from the Genomics concept of "dataset".
   */
  core.String bigqueryDataset;
  /**
   * Required. The BigQuery table to export data to.
   * If the table doesn't exist, it will be created. If it already exists, it
   * will be overwritten.
   */
  core.String bigqueryTable;
  /**
   * If provided, only variant call information from the specified call sets
   * will be exported. By default all variant calls are exported.
   */
  core.List<core.String> callSetIds;
  /**
   * The format for the exported data.
   * Possible string values are:
   * - "FORMAT_UNSPECIFIED"
   * - "FORMAT_BIGQUERY" : Export the data to Google BigQuery.
   */
  core.String format;
  /**
   * Required. The Google Cloud project ID that owns the destination
   * BigQuery dataset. The caller must have WRITE access to this project.  This
   * project will also own the resulting export job.
   */
  core.String projectId;

  ExportVariantSetRequest();

  ExportVariantSetRequest.fromJson(core.Map _json) {
    if (_json.containsKey("bigqueryDataset")) {
      bigqueryDataset = _json["bigqueryDataset"];
    }
    if (_json.containsKey("bigqueryTable")) {
      bigqueryTable = _json["bigqueryTable"];
    }
    if (_json.containsKey("callSetIds")) {
      callSetIds = _json["callSetIds"];
    }
    if (_json.containsKey("format")) {
      format = _json["format"];
    }
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (bigqueryDataset != null) {
      _json["bigqueryDataset"] = bigqueryDataset;
    }
    if (bigqueryTable != null) {
      _json["bigqueryTable"] = bigqueryTable;
    }
    if (callSetIds != null) {
      _json["callSetIds"] = callSetIds;
    }
    if (format != null) {
      _json["format"] = format;
    }
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    return _json;
  }
}

class ExternalId {
  /** The id used by the source of this data. */
  core.String id;
  /** The name of the source of this data. */
  core.String sourceName;

  ExternalId();

  ExternalId.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("sourceName")) {
      sourceName = _json["sourceName"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (sourceName != null) {
      _json["sourceName"] = sourceName;
    }
    return _json;
  }
}

/** Request message for `GetIamPolicy` method. */
class GetIamPolicyRequest {

  GetIamPolicyRequest();

  GetIamPolicyRequest.fromJson(core.Map _json) {
  }

  core.Map toJson() {
    var _json = new core.Map();
    return _json;
  }
}

/** The read group set import request. */
class ImportReadGroupSetsRequest {
  /**
   * Required. The ID of the dataset these read group sets will belong to. The
   * caller must have WRITE permissions to this dataset.
   */
  core.String datasetId;
  /**
   * The partition strategy describes how read groups are partitioned into read
   * group sets.
   * Possible string values are:
   * - "PARTITION_STRATEGY_UNSPECIFIED"
   * - "PER_FILE_PER_SAMPLE" : In most cases, this strategy yields one read
   * group set per file. This is
   * the default behavior.
   *
   * Allocate one read group set per file per sample. For BAM files, read
   * groups are considered to share a sample if they have identical sample
   * names. Furthermore, all reads for each file which do not belong to a read
   * group, if any, will be grouped into a single read group set per-file.
   * - "MERGE_ALL" : Includes all read groups in all imported files into a
   * single read group
   * set. Requires that the headers for all imported files are equivalent. All
   * reads which do not belong to a read group, if any, will be grouped into a
   * separate read group set.
   */
  core.String partitionStrategy;
  /**
   * The reference set to which the imported read group sets are aligned to, if
   * any. The reference names of this reference set must be a superset of those
   * found in the imported file headers. If no reference set id is provided, a
   * best effort is made to associate with a matching reference set.
   */
  core.String referenceSetId;
  /**
   * A list of URIs pointing at [BAM
   * files](https://samtools.github.io/hts-specs/SAMv1.pdf)
   * in Google Cloud Storage.
   * Those URIs can include wildcards (*), but do not add or remove
   * matching files before import has completed.
   *
   * Note that Google Cloud Storage object listing is only eventually
   * consistent: files added may be not be immediately visible to
   * everyone. Thus, if using a wildcard it is preferable not to start
   * the import immediately after the files are created.
   */
  core.List<core.String> sourceUris;

  ImportReadGroupSetsRequest();

  ImportReadGroupSetsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("datasetId")) {
      datasetId = _json["datasetId"];
    }
    if (_json.containsKey("partitionStrategy")) {
      partitionStrategy = _json["partitionStrategy"];
    }
    if (_json.containsKey("referenceSetId")) {
      referenceSetId = _json["referenceSetId"];
    }
    if (_json.containsKey("sourceUris")) {
      sourceUris = _json["sourceUris"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (datasetId != null) {
      _json["datasetId"] = datasetId;
    }
    if (partitionStrategy != null) {
      _json["partitionStrategy"] = partitionStrategy;
    }
    if (referenceSetId != null) {
      _json["referenceSetId"] = referenceSetId;
    }
    if (sourceUris != null) {
      _json["sourceUris"] = sourceUris;
    }
    return _json;
  }
}

/** The read group set import response. */
class ImportReadGroupSetsResponse {
  /** IDs of the read group sets that were created. */
  core.List<core.String> readGroupSetIds;

  ImportReadGroupSetsResponse();

  ImportReadGroupSetsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("readGroupSetIds")) {
      readGroupSetIds = _json["readGroupSetIds"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (readGroupSetIds != null) {
      _json["readGroupSetIds"] = readGroupSetIds;
    }
    return _json;
  }
}

/** The variant data import request. */
class ImportVariantsRequest {
  /**
   * The format of the variant data being imported. If unspecified, defaults to
   * to `VCF`.
   * Possible string values are:
   * - "FORMAT_UNSPECIFIED"
   * - "FORMAT_VCF" : VCF (Variant Call Format). The VCF files may be gzip
   * compressed. gVCF is
   * also supported.
   * - "FORMAT_COMPLETE_GENOMICS" : Complete Genomics masterVarBeta format. The
   * masterVarBeta files may
   * be bzip2 compressed.
   */
  core.String format;
  /**
   * A mapping between info field keys and the InfoMergeOperations to
   * be performed on them. This is plumbed down to the MergeVariantRequests
   * generated by the resulting import job.
   */
  core.Map<core.String, core.String> infoMergeConfig;
  /**
   * Convert reference names to the canonical representation.
   * hg19 haploytypes (those reference names containing "_hap")
   * are not modified in any way.
   * All other reference names are modified according to the following rules:
   * The reference name is capitalized.
   * The "chr" prefix is dropped for all autosomes and sex chromsomes.
   * For example "chr17" becomes "17" and "chrX" becomes "X".
   * All mitochondrial chromosomes ("chrM", "chrMT", etc) become "MT".
   */
  core.bool normalizeReferenceNames;
  /**
   * A list of URIs referencing variant files in Google Cloud Storage. URIs can
   * include wildcards [as described
   * here](https://cloud.google.com/storage/docs/gsutil/addlhelp/WildcardNames).
   * Note that recursive wildcards ('**') are not supported.
   */
  core.List<core.String> sourceUris;
  /** Required. The variant set to which variant data should be imported. */
  core.String variantSetId;

  ImportVariantsRequest();

  ImportVariantsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("format")) {
      format = _json["format"];
    }
    if (_json.containsKey("infoMergeConfig")) {
      infoMergeConfig = _json["infoMergeConfig"];
    }
    if (_json.containsKey("normalizeReferenceNames")) {
      normalizeReferenceNames = _json["normalizeReferenceNames"];
    }
    if (_json.containsKey("sourceUris")) {
      sourceUris = _json["sourceUris"];
    }
    if (_json.containsKey("variantSetId")) {
      variantSetId = _json["variantSetId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (format != null) {
      _json["format"] = format;
    }
    if (infoMergeConfig != null) {
      _json["infoMergeConfig"] = infoMergeConfig;
    }
    if (normalizeReferenceNames != null) {
      _json["normalizeReferenceNames"] = normalizeReferenceNames;
    }
    if (sourceUris != null) {
      _json["sourceUris"] = sourceUris;
    }
    if (variantSetId != null) {
      _json["variantSetId"] = variantSetId;
    }
    return _json;
  }
}

/** The variant data import response. */
class ImportVariantsResponse {
  /** IDs of the call sets created during the import. */
  core.List<core.String> callSetIds;

  ImportVariantsResponse();

  ImportVariantsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("callSetIds")) {
      callSetIds = _json["callSetIds"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (callSetIds != null) {
      _json["callSetIds"] = callSetIds;
    }
    return _json;
  }
}

/**
 * A linear alignment can be represented by one CIGAR string. Describes the
 * mapped position and local alignment of the read to the reference.
 */
class LinearAlignment {
  /**
   * Represents the local alignment of this sequence (alignment matches, indels,
   * etc) against the reference.
   */
  core.List<CigarUnit> cigar;
  /**
   * The mapping quality of this alignment. Represents how likely
   * the read maps to this position as opposed to other locations.
   *
   * Specifically, this is -10 log10 Pr(mapping position is wrong), rounded to
   * the nearest integer.
   */
  core.int mappingQuality;
  /** The position of this alignment. */
  Position position;

  LinearAlignment();

  LinearAlignment.fromJson(core.Map _json) {
    if (_json.containsKey("cigar")) {
      cigar = _json["cigar"].map((value) => new CigarUnit.fromJson(value)).toList();
    }
    if (_json.containsKey("mappingQuality")) {
      mappingQuality = _json["mappingQuality"];
    }
    if (_json.containsKey("position")) {
      position = new Position.fromJson(_json["position"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cigar != null) {
      _json["cigar"] = cigar.map((value) => (value).toJson()).toList();
    }
    if (mappingQuality != null) {
      _json["mappingQuality"] = mappingQuality;
    }
    if (position != null) {
      _json["position"] = (position).toJson();
    }
    return _json;
  }
}

class ListBasesResponse {
  /**
   * The continuation token, which is used to page through large result sets.
   * Provide this value in a subsequent request to return the next page of
   * results. This field will be empty if there aren't any additional results.
   */
  core.String nextPageToken;
  /**
   * The offset position (0-based) of the given `sequence` from the
   * start of this `Reference`. This value will differ for each page
   * in a paginated request.
   */
  core.String offset;
  /** A substring of the bases that make up this reference. */
  core.String sequence;

  ListBasesResponse();

  ListBasesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("offset")) {
      offset = _json["offset"];
    }
    if (_json.containsKey("sequence")) {
      sequence = _json["sequence"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (offset != null) {
      _json["offset"] = offset;
    }
    if (sequence != null) {
      _json["sequence"] = sequence;
    }
    return _json;
  }
}

class ListCoverageBucketsResponse {
  /**
   * The length of each coverage bucket in base pairs. Note that buckets at the
   * end of a reference sequence may be shorter. This value is omitted if the
   * bucket width is infinity (the default behaviour, with no range or
   * `targetBucketWidth`).
   */
  core.String bucketWidth;
  /**
   * The coverage buckets. The list of buckets is sparse; a bucket with 0
   * overlapping reads is not returned. A bucket never crosses more than one
   * reference sequence. Each bucket has width `bucketWidth`, unless
   * its end is the end of the reference sequence.
   */
  core.List<CoverageBucket> coverageBuckets;
  /**
   * The continuation token, which is used to page through large result sets.
   * Provide this value in a subsequent request to return the next page of
   * results. This field will be empty if there aren't any additional results.
   */
  core.String nextPageToken;

  ListCoverageBucketsResponse();

  ListCoverageBucketsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("bucketWidth")) {
      bucketWidth = _json["bucketWidth"];
    }
    if (_json.containsKey("coverageBuckets")) {
      coverageBuckets = _json["coverageBuckets"].map((value) => new CoverageBucket.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (bucketWidth != null) {
      _json["bucketWidth"] = bucketWidth;
    }
    if (coverageBuckets != null) {
      _json["coverageBuckets"] = coverageBuckets.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** The dataset list response. */
class ListDatasetsResponse {
  /** The list of matching Datasets. */
  core.List<Dataset> datasets;
  /**
   * The continuation token, which is used to page through large result sets.
   * Provide this value in a subsequent request to return the next page of
   * results. This field will be empty if there aren't any additional results.
   */
  core.String nextPageToken;

  ListDatasetsResponse();

  ListDatasetsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("datasets")) {
      datasets = _json["datasets"].map((value) => new Dataset.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (datasets != null) {
      _json["datasets"] = datasets.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** The response message for Operations.ListOperations. */
class ListOperationsResponse {
  /** The standard List next-page token. */
  core.String nextPageToken;
  /** A list of operations that matches the specified filter in the request. */
  core.List<Operation> operations;

  ListOperationsResponse();

  ListOperationsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("operations")) {
      operations = _json["operations"].map((value) => new Operation.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (operations != null) {
      _json["operations"] = operations.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class MergeVariantsRequest {
  /**
   * A mapping between info field keys and the InfoMergeOperations to
   * be performed on them.
   */
  core.Map<core.String, core.String> infoMergeConfig;
  /** The destination variant set. */
  core.String variantSetId;
  /** The variants to be merged with existing variants. */
  core.List<Variant> variants;

  MergeVariantsRequest();

  MergeVariantsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("infoMergeConfig")) {
      infoMergeConfig = _json["infoMergeConfig"];
    }
    if (_json.containsKey("variantSetId")) {
      variantSetId = _json["variantSetId"];
    }
    if (_json.containsKey("variants")) {
      variants = _json["variants"].map((value) => new Variant.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (infoMergeConfig != null) {
      _json["infoMergeConfig"] = infoMergeConfig;
    }
    if (variantSetId != null) {
      _json["variantSetId"] = variantSetId;
    }
    if (variants != null) {
      _json["variants"] = variants.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * This resource represents a long-running operation that is the result of a
 * network API call.
 */
class Operation {
  /**
   * If the value is `false`, it means the operation is still in progress.
   * If true, the operation is completed, and either `error` or `response` is
   * available.
   */
  core.bool done;
  /** The error result of the operation in case of failure or cancellation. */
  Status error;
  /**
   * An OperationMetadata object. This will always be returned with the
   * Operation.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Map<core.String, core.Object> metadata;
  /**
   * The server-assigned name, which is only unique within the same service that
   * originally returns it. For example&#58;
   * `operations/CJHU7Oi_ChDrveSpBRjfuL-qzoWAgEw`
   */
  core.String name;
  /**
   * If importing ReadGroupSets, an ImportReadGroupSetsResponse is returned. If
   * importing Variants, an ImportVariantsResponse is returned. For pipelines
   * and exports, an empty response is returned.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
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

  core.Map toJson() {
    var _json = new core.Map();
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

/** An event that occurred during an Operation. */
class OperationEvent {
  /** Required description of event. */
  core.String description;
  /**
   * Optional time of when event finished. An event can have a start time and no
   * finish time. If an event has a finish time, there must be a start time.
   */
  core.String endTime;
  /** Optional time of when event started. */
  core.String startTime;

  OperationEvent();

  OperationEvent.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("endTime")) {
      endTime = _json["endTime"];
    }
    if (_json.containsKey("startTime")) {
      startTime = _json["startTime"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (description != null) {
      _json["description"] = description;
    }
    if (endTime != null) {
      _json["endTime"] = endTime;
    }
    if (startTime != null) {
      _json["startTime"] = startTime;
    }
    return _json;
  }
}

/** Metadata describing an Operation. */
class OperationMetadata {
  /**
   * This field is deprecated. Use `labels` instead. Optionally provided by the
   * caller when submitting the request that creates the operation.
   */
  core.String clientId;
  /** The time at which the job was submitted to the Genomics service. */
  core.String createTime;
  /** The time at which the job stopped running. */
  core.String endTime;
  /**
   * Optional event messages that were generated during the job's execution.
   * This also contains any warnings that were generated during import
   * or export.
   */
  core.List<OperationEvent> events;
  /**
   * Optionally provided by the caller when submitting the request that creates
   * the operation.
   */
  core.Map<core.String, core.String> labels;
  /** The Google Cloud Project in which the job is scoped. */
  core.String projectId;
  /**
   * The original request that started the operation. Note that this will be in
   * current version of the API. If the operation was started with v1beta2 API
   * and a GetOperation is performed on v1 API, a v1 request will be returned.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Map<core.String, core.Object> request;
  /**
   * Runtime metadata on this Operation.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Map<core.String, core.Object> runtimeMetadata;
  /** The time at which the job began to run. */
  core.String startTime;

  OperationMetadata();

  OperationMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("clientId")) {
      clientId = _json["clientId"];
    }
    if (_json.containsKey("createTime")) {
      createTime = _json["createTime"];
    }
    if (_json.containsKey("endTime")) {
      endTime = _json["endTime"];
    }
    if (_json.containsKey("events")) {
      events = _json["events"].map((value) => new OperationEvent.fromJson(value)).toList();
    }
    if (_json.containsKey("labels")) {
      labels = _json["labels"];
    }
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
    if (_json.containsKey("request")) {
      request = _json["request"];
    }
    if (_json.containsKey("runtimeMetadata")) {
      runtimeMetadata = _json["runtimeMetadata"];
    }
    if (_json.containsKey("startTime")) {
      startTime = _json["startTime"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (clientId != null) {
      _json["clientId"] = clientId;
    }
    if (createTime != null) {
      _json["createTime"] = createTime;
    }
    if (endTime != null) {
      _json["endTime"] = endTime;
    }
    if (events != null) {
      _json["events"] = events.map((value) => (value).toJson()).toList();
    }
    if (labels != null) {
      _json["labels"] = labels;
    }
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    if (request != null) {
      _json["request"] = request;
    }
    if (runtimeMetadata != null) {
      _json["runtimeMetadata"] = runtimeMetadata;
    }
    if (startTime != null) {
      _json["startTime"] = startTime;
    }
    return _json;
  }
}

/**
 * Defines an Identity and Access Management (IAM) policy. It is used to
 * specify access control policies for Cloud Platform resources.
 *
 *
 * A `Policy` consists of a list of `bindings`. A `Binding` binds a list of
 * `members` to a `role`, where the members can be user accounts, Google groups,
 * Google domains, and service accounts. A `role` is a named list of permissions
 * defined by IAM.
 *
 * **Example**
 *
 *     {
 *       "bindings": [
 *         {
 *           "role": "roles/owner",
 *           "members": [
 *             "user:mike@example.com",
 *             "group:admins@example.com",
 *             "domain:google.com",
 *             "serviceAccount:my-other-app@appspot.gserviceaccount.com",
 *           ]
 *         },
 *         {
 *           "role": "roles/viewer",
 *           "members": ["user:sean@example.com"]
 *         }
 *       ]
 *     }
 *
 * For a description of IAM and its features, see the
 * [IAM developer's guide](https://cloud.google.com/iam).
 */
class Policy {
  /**
   * Associates a list of `members` to a `role`.
   * Multiple `bindings` must not be specified for the same `role`.
   * `bindings` with no members will result in an error.
   */
  core.List<Binding> bindings;
  /**
   * `etag` is used for optimistic concurrency control as a way to help
   * prevent simultaneous updates of a policy from overwriting each other.
   * It is strongly suggested that systems make use of the `etag` in the
   * read-modify-write cycle to perform policy updates in order to avoid race
   * conditions: An `etag` is returned in the response to `getIamPolicy`, and
   * systems are expected to put that etag in the request to `setIamPolicy` to
   * ensure that their change will be applied to the same version of the policy.
   *
   * If no `etag` is provided in the call to `setIamPolicy`, then the existing
   * policy is overwritten blindly.
   */
  core.String etag;
  core.List<core.int> get etagAsBytes {
    return convert.BASE64.decode(etag);
  }

  void set etagAsBytes(core.List<core.int> _bytes) {
    etag = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /** Version of the `Policy`. The default version is 0. */
  core.int version;

  Policy();

  Policy.fromJson(core.Map _json) {
    if (_json.containsKey("bindings")) {
      bindings = _json["bindings"].map((value) => new Binding.fromJson(value)).toList();
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("version")) {
      version = _json["version"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (bindings != null) {
      _json["bindings"] = bindings.map((value) => (value).toJson()).toList();
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (version != null) {
      _json["version"] = version;
    }
    return _json;
  }
}

/**
 * An abstraction for referring to a genomic position, in relation to some
 * already known reference. For now, represents a genomic position as a
 * reference name, a base number on that reference (0-based), and a
 * determination of forward or reverse strand.
 */
class Position {
  /**
   * The 0-based offset from the start of the forward strand for that reference.
   */
  core.String position;
  /** The name of the reference in whatever reference set is being used. */
  core.String referenceName;
  /**
   * Whether this position is on the reverse strand, as opposed to the forward
   * strand.
   */
  core.bool reverseStrand;

  Position();

  Position.fromJson(core.Map _json) {
    if (_json.containsKey("position")) {
      position = _json["position"];
    }
    if (_json.containsKey("referenceName")) {
      referenceName = _json["referenceName"];
    }
    if (_json.containsKey("reverseStrand")) {
      reverseStrand = _json["reverseStrand"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (position != null) {
      _json["position"] = position;
    }
    if (referenceName != null) {
      _json["referenceName"] = referenceName;
    }
    if (reverseStrand != null) {
      _json["reverseStrand"] = reverseStrand;
    }
    return _json;
  }
}

class Program {
  /** The command line used to run this program. */
  core.String commandLine;
  /**
   * The user specified locally unique ID of the program. Used along with
   * `prevProgramId` to define an ordering between programs.
   */
  core.String id;
  /**
   * The display name of the program. This is typically the colloquial name of
   * the tool used, for example 'bwa' or 'picard'.
   */
  core.String name;
  /** The ID of the program run before this one. */
  core.String prevProgramId;
  /** The version of the program run. */
  core.String version;

  Program();

  Program.fromJson(core.Map _json) {
    if (_json.containsKey("commandLine")) {
      commandLine = _json["commandLine"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("prevProgramId")) {
      prevProgramId = _json["prevProgramId"];
    }
    if (_json.containsKey("version")) {
      version = _json["version"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (commandLine != null) {
      _json["commandLine"] = commandLine;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (prevProgramId != null) {
      _json["prevProgramId"] = prevProgramId;
    }
    if (version != null) {
      _json["version"] = version;
    }
    return _json;
  }
}

/** A 0-based half-open genomic coordinate range for search requests. */
class Range {
  /** The end position of the range on the reference, 0-based exclusive. */
  core.String end;
  /**
   * The reference sequence name, for example `chr1`,
   * `1`, or `chrX`.
   */
  core.String referenceName;
  /** The start position of the range on the reference, 0-based inclusive. */
  core.String start;

  Range();

  Range.fromJson(core.Map _json) {
    if (_json.containsKey("end")) {
      end = _json["end"];
    }
    if (_json.containsKey("referenceName")) {
      referenceName = _json["referenceName"];
    }
    if (_json.containsKey("start")) {
      start = _json["start"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (end != null) {
      _json["end"] = end;
    }
    if (referenceName != null) {
      _json["referenceName"] = referenceName;
    }
    if (start != null) {
      _json["start"] = start;
    }
    return _json;
  }
}

/**
 * A read alignment describes a linear alignment of a string of DNA to a
 * reference sequence, in addition to metadata
 * about the fragment (the molecule of DNA sequenced) and the read (the bases
 * which were read by the sequencer). A read is equivalent to a line in a SAM
 * file. A read belongs to exactly one read group and exactly one
 * read group set.
 *
 * For more genomics resource definitions, see [Fundamentals of Google
 * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
 *
 * ### Reverse-stranded reads
 *
 * Mapped reads (reads having a non-null `alignment`) can be aligned to either
 * the forward or the reverse strand of their associated reference. Strandedness
 * of a mapped read is encoded by `alignment.position.reverseStrand`.
 *
 * If we consider the reference to be a forward-stranded coordinate space of
 * `[0, reference.length)` with `0` as the left-most position and
 * `reference.length` as the right-most position, reads are always aligned left
 * to right. That is, `alignment.position.position` always refers to the
 * left-most reference coordinate and `alignment.cigar` describes the alignment
 * of this read to the reference from left to right. All per-base fields such as
 * `alignedSequence` and `alignedQuality` share this same left-to-right
 * orientation; this is true of reads which are aligned to either strand. For
 * reverse-stranded reads, this means that `alignedSequence` is the reverse
 * complement of the bases that were originally reported by the sequencing
 * machine.
 *
 * ### Generating a reference-aligned sequence string
 *
 * When interacting with mapped reads, it's often useful to produce a string
 * representing the local alignment of the read to reference. The following
 * pseudocode demonstrates one way of doing this:
 *
 *     out = ""
 *     offset = 0
 *     for c in read.alignment.cigar {
 *       switch c.operation {
 *       case "ALIGNMENT_MATCH", "SEQUENCE_MATCH", "SEQUENCE_MISMATCH":
 *         out += read.alignedSequence[offset:offset+c.operationLength]
 *         offset += c.operationLength
 *         break
 *       case "CLIP_SOFT", "INSERT":
 *         offset += c.operationLength
 *         break
 *       case "PAD":
 *         out += repeat("*", c.operationLength)
 *         break
 *       case "DELETE":
 *         out += repeat("-", c.operationLength)
 *         break
 *       case "SKIP":
 *         out += repeat(" ", c.operationLength)
 *         break
 *       case "CLIP_HARD":
 *         break
 *       }
 *     }
 *     return out
 *
 * ### Converting to SAM's CIGAR string
 *
 * The following pseudocode generates a SAM CIGAR string from the
 * `cigar` field. Note that this is a lossy conversion
 * (`cigar.referenceSequence` is lost).
 *
 *     cigarMap = {
 *       "ALIGNMENT_MATCH": "M",
 *       "INSERT": "I",
 *       "DELETE": "D",
 *       "SKIP": "N",
 *       "CLIP_SOFT": "S",
 *       "CLIP_HARD": "H",
 *       "PAD": "P",
 *       "SEQUENCE_MATCH": "=",
 *       "SEQUENCE_MISMATCH": "X",
 *     }
 *     cigarStr = ""
 *     for c in read.alignment.cigar {
 *       cigarStr += c.operationLength + cigarMap[c.operation]
 *     }
 *     return cigarStr
 */
class Read {
  /**
   * The quality of the read sequence contained in this alignment record
   * (equivalent to QUAL in SAM).
   * `alignedSequence` and `alignedQuality` may be shorter than the full read
   * sequence and quality. This will occur if the alignment is part of a
   * chimeric alignment, or if the read was trimmed. When this occurs, the CIGAR
   * for this read will begin/end with a hard clip operator that will indicate
   * the length of the excised sequence.
   */
  core.List<core.int> alignedQuality;
  /**
   * The bases of the read sequence contained in this alignment record,
   * **without CIGAR operations applied** (equivalent to SEQ in SAM).
   * `alignedSequence` and `alignedQuality` may be
   * shorter than the full read sequence and quality. This will occur if the
   * alignment is part of a chimeric alignment, or if the read was trimmed. When
   * this occurs, the CIGAR for this read will begin/end with a hard clip
   * operator that will indicate the length of the excised sequence.
   */
  core.String alignedSequence;
  /**
   * The linear alignment for this alignment record. This field is null for
   * unmapped reads.
   */
  LinearAlignment alignment;
  /** The fragment is a PCR or optical duplicate (SAM flag 0x400). */
  core.bool duplicateFragment;
  /**
   * Whether this read did not pass filters, such as platform or vendor quality
   * controls (SAM flag 0x200).
   */
  core.bool failedVendorQualityChecks;
  /** The observed length of the fragment, equivalent to TLEN in SAM. */
  core.int fragmentLength;
  /** The fragment name. Equivalent to QNAME (query template name) in SAM. */
  core.String fragmentName;
  /**
   * The server-generated read ID, unique across all reads. This is different
   * from the `fragmentName`.
   */
  core.String id;
  /**
   * A map of additional read alignment information. This must be of the form
   * map<string, string[]> (string key mapping to a list of string values).
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Map<core.String, core.List<core.Object>> info;
  /**
   * The mapping of the primary alignment of the
   * `(readNumber+1)%numberReads` read in the fragment. It replaces
   * mate position and mate strand in SAM.
   */
  Position nextMatePosition;
  /** The number of reads in the fragment (extension to SAM flag 0x1). */
  core.int numberReads;
  /**
   * The orientation and the distance between reads from the fragment are
   * consistent with the sequencing protocol (SAM flag 0x2).
   */
  core.bool properPlacement;
  /**
   * The ID of the read group this read belongs to. A read belongs to exactly
   * one read group. This is a server-generated ID which is distinct from SAM's
   * RG tag (for that value, see
   * ReadGroup.name).
   */
  core.String readGroupId;
  /**
   * The ID of the read group set this read belongs to. A read belongs to
   * exactly one read group set.
   */
  core.String readGroupSetId;
  /**
   * The read number in sequencing. 0-based and less than numberReads. This
   * field replaces SAM flag 0x40 and 0x80.
   */
  core.int readNumber;
  /**
   * Whether this alignment is secondary. Equivalent to SAM flag 0x100.
   * A secondary alignment represents an alternative to the primary alignment
   * for this read. Aligners may return secondary alignments if a read can map
   * ambiguously to multiple coordinates in the genome. By convention, each read
   * has one and only one alignment where both `secondaryAlignment`
   * and `supplementaryAlignment` are false.
   */
  core.bool secondaryAlignment;
  /**
   * Whether this alignment is supplementary. Equivalent to SAM flag 0x800.
   * Supplementary alignments are used in the representation of a chimeric
   * alignment. In a chimeric alignment, a read is split into multiple
   * linear alignments that map to different reference contigs. The first
   * linear alignment in the read will be designated as the representative
   * alignment; the remaining linear alignments will be designated as
   * supplementary alignments. These alignments may have different mapping
   * quality scores. In each linear alignment in a chimeric alignment, the read
   * will be hard clipped. The `alignedSequence` and
   * `alignedQuality` fields in the alignment record will only
   * represent the bases for its respective linear alignment.
   */
  core.bool supplementaryAlignment;

  Read();

  Read.fromJson(core.Map _json) {
    if (_json.containsKey("alignedQuality")) {
      alignedQuality = _json["alignedQuality"];
    }
    if (_json.containsKey("alignedSequence")) {
      alignedSequence = _json["alignedSequence"];
    }
    if (_json.containsKey("alignment")) {
      alignment = new LinearAlignment.fromJson(_json["alignment"]);
    }
    if (_json.containsKey("duplicateFragment")) {
      duplicateFragment = _json["duplicateFragment"];
    }
    if (_json.containsKey("failedVendorQualityChecks")) {
      failedVendorQualityChecks = _json["failedVendorQualityChecks"];
    }
    if (_json.containsKey("fragmentLength")) {
      fragmentLength = _json["fragmentLength"];
    }
    if (_json.containsKey("fragmentName")) {
      fragmentName = _json["fragmentName"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("info")) {
      info = _json["info"];
    }
    if (_json.containsKey("nextMatePosition")) {
      nextMatePosition = new Position.fromJson(_json["nextMatePosition"]);
    }
    if (_json.containsKey("numberReads")) {
      numberReads = _json["numberReads"];
    }
    if (_json.containsKey("properPlacement")) {
      properPlacement = _json["properPlacement"];
    }
    if (_json.containsKey("readGroupId")) {
      readGroupId = _json["readGroupId"];
    }
    if (_json.containsKey("readGroupSetId")) {
      readGroupSetId = _json["readGroupSetId"];
    }
    if (_json.containsKey("readNumber")) {
      readNumber = _json["readNumber"];
    }
    if (_json.containsKey("secondaryAlignment")) {
      secondaryAlignment = _json["secondaryAlignment"];
    }
    if (_json.containsKey("supplementaryAlignment")) {
      supplementaryAlignment = _json["supplementaryAlignment"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (alignedQuality != null) {
      _json["alignedQuality"] = alignedQuality;
    }
    if (alignedSequence != null) {
      _json["alignedSequence"] = alignedSequence;
    }
    if (alignment != null) {
      _json["alignment"] = (alignment).toJson();
    }
    if (duplicateFragment != null) {
      _json["duplicateFragment"] = duplicateFragment;
    }
    if (failedVendorQualityChecks != null) {
      _json["failedVendorQualityChecks"] = failedVendorQualityChecks;
    }
    if (fragmentLength != null) {
      _json["fragmentLength"] = fragmentLength;
    }
    if (fragmentName != null) {
      _json["fragmentName"] = fragmentName;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (info != null) {
      _json["info"] = info;
    }
    if (nextMatePosition != null) {
      _json["nextMatePosition"] = (nextMatePosition).toJson();
    }
    if (numberReads != null) {
      _json["numberReads"] = numberReads;
    }
    if (properPlacement != null) {
      _json["properPlacement"] = properPlacement;
    }
    if (readGroupId != null) {
      _json["readGroupId"] = readGroupId;
    }
    if (readGroupSetId != null) {
      _json["readGroupSetId"] = readGroupSetId;
    }
    if (readNumber != null) {
      _json["readNumber"] = readNumber;
    }
    if (secondaryAlignment != null) {
      _json["secondaryAlignment"] = secondaryAlignment;
    }
    if (supplementaryAlignment != null) {
      _json["supplementaryAlignment"] = supplementaryAlignment;
    }
    return _json;
  }
}

/**
 * A read group is all the data that's processed the same way by the sequencer.
 */
class ReadGroup {
  /** The dataset to which this read group belongs. */
  core.String datasetId;
  /** A free-form text description of this read group. */
  core.String description;
  /** The experiment used to generate this read group. */
  Experiment experiment;
  /**
   * The server-generated read group ID, unique for all read groups.
   * Note: This is different than the @RG ID field in the SAM spec. For that
   * value, see name.
   */
  core.String id;
  /**
   * A map of additional read group information. This must be of the form
   * map<string, string[]> (string key mapping to a list of string values).
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Map<core.String, core.List<core.Object>> info;
  /**
   * The read group name. This corresponds to the @RG ID field in the SAM spec.
   */
  core.String name;
  /**
   * The predicted insert size of this read group. The insert size is the length
   * the sequenced DNA fragment from end-to-end, not including the adapters.
   */
  core.int predictedInsertSize;
  /**
   * The programs used to generate this read group. Programs are always
   * identical for all read groups within a read group set. For this reason,
   * only the first read group in a returned set will have this field
   * populated.
   */
  core.List<Program> programs;
  /** The reference set the reads in this read group are aligned to. */
  core.String referenceSetId;
  /** A client-supplied sample identifier for the reads in this read group. */
  core.String sampleId;

  ReadGroup();

  ReadGroup.fromJson(core.Map _json) {
    if (_json.containsKey("datasetId")) {
      datasetId = _json["datasetId"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("experiment")) {
      experiment = new Experiment.fromJson(_json["experiment"]);
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("info")) {
      info = _json["info"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("predictedInsertSize")) {
      predictedInsertSize = _json["predictedInsertSize"];
    }
    if (_json.containsKey("programs")) {
      programs = _json["programs"].map((value) => new Program.fromJson(value)).toList();
    }
    if (_json.containsKey("referenceSetId")) {
      referenceSetId = _json["referenceSetId"];
    }
    if (_json.containsKey("sampleId")) {
      sampleId = _json["sampleId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (datasetId != null) {
      _json["datasetId"] = datasetId;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (experiment != null) {
      _json["experiment"] = (experiment).toJson();
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (info != null) {
      _json["info"] = info;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (predictedInsertSize != null) {
      _json["predictedInsertSize"] = predictedInsertSize;
    }
    if (programs != null) {
      _json["programs"] = programs.map((value) => (value).toJson()).toList();
    }
    if (referenceSetId != null) {
      _json["referenceSetId"] = referenceSetId;
    }
    if (sampleId != null) {
      _json["sampleId"] = sampleId;
    }
    return _json;
  }
}

/**
 * A read group set is a logical collection of read groups, which are
 * collections of reads produced by a sequencer. A read group set typically
 * models reads corresponding to one sample, sequenced one way, and aligned one
 * way.
 *
 * * A read group set belongs to one dataset.
 * * A read group belongs to one read group set.
 * * A read belongs to one read group.
 *
 * For more genomics resource definitions, see [Fundamentals of Google
 * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
 */
class ReadGroupSet {
  /** The dataset to which this read group set belongs. */
  core.String datasetId;
  /**
   * The filename of the original source file for this read group set, if any.
   */
  core.String filename;
  /**
   * The server-generated read group set ID, unique for all read group sets.
   */
  core.String id;
  /**
   * A map of additional read group set information.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Map<core.String, core.List<core.Object>> info;
  /**
   * The read group set name. By default this will be initialized to the sample
   * name of the sequenced data contained in this set.
   */
  core.String name;
  /**
   * The read groups in this set. There are typically 1-10 read groups in a read
   * group set.
   */
  core.List<ReadGroup> readGroups;
  /**
   * The reference set to which the reads in this read group set are aligned.
   */
  core.String referenceSetId;

  ReadGroupSet();

  ReadGroupSet.fromJson(core.Map _json) {
    if (_json.containsKey("datasetId")) {
      datasetId = _json["datasetId"];
    }
    if (_json.containsKey("filename")) {
      filename = _json["filename"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("info")) {
      info = _json["info"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("readGroups")) {
      readGroups = _json["readGroups"].map((value) => new ReadGroup.fromJson(value)).toList();
    }
    if (_json.containsKey("referenceSetId")) {
      referenceSetId = _json["referenceSetId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (datasetId != null) {
      _json["datasetId"] = datasetId;
    }
    if (filename != null) {
      _json["filename"] = filename;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (info != null) {
      _json["info"] = info;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (readGroups != null) {
      _json["readGroups"] = readGroups.map((value) => (value).toJson()).toList();
    }
    if (referenceSetId != null) {
      _json["referenceSetId"] = referenceSetId;
    }
    return _json;
  }
}

/**
 * A reference is a canonical assembled DNA sequence, intended to act as a
 * reference coordinate space for other genomic annotations. A single reference
 * might represent the human chromosome 1 or mitochandrial DNA, for instance. A
 * reference belongs to one or more reference sets.
 *
 * For more genomics resource definitions, see [Fundamentals of Google
 * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
 */
class Reference {
  /** The server-generated reference ID, unique across all references. */
  core.String id;
  /** The length of this reference's sequence. */
  core.String length;
  /**
   * MD5 of the upper-case sequence excluding all whitespace characters (this
   * is equivalent to SQ:M5 in SAM). This value is represented in lower case
   * hexadecimal format.
   */
  core.String md5checksum;
  /** The name of this reference, for example `22`. */
  core.String name;
  /**
   * ID from http://www.ncbi.nlm.nih.gov/taxonomy. For example, 9606 for human.
   */
  core.int ncbiTaxonId;
  /**
   * All known corresponding accession IDs in INSDC (GenBank/ENA/DDBJ) ideally
   * with a version number, for example `GCF_000001405.26`.
   */
  core.List<core.String> sourceAccessions;
  /**
   * The URI from which the sequence was obtained. Typically specifies a FASTA
   * format file.
   */
  core.String sourceUri;

  Reference();

  Reference.fromJson(core.Map _json) {
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("length")) {
      length = _json["length"];
    }
    if (_json.containsKey("md5checksum")) {
      md5checksum = _json["md5checksum"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("ncbiTaxonId")) {
      ncbiTaxonId = _json["ncbiTaxonId"];
    }
    if (_json.containsKey("sourceAccessions")) {
      sourceAccessions = _json["sourceAccessions"];
    }
    if (_json.containsKey("sourceUri")) {
      sourceUri = _json["sourceUri"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (id != null) {
      _json["id"] = id;
    }
    if (length != null) {
      _json["length"] = length;
    }
    if (md5checksum != null) {
      _json["md5checksum"] = md5checksum;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (ncbiTaxonId != null) {
      _json["ncbiTaxonId"] = ncbiTaxonId;
    }
    if (sourceAccessions != null) {
      _json["sourceAccessions"] = sourceAccessions;
    }
    if (sourceUri != null) {
      _json["sourceUri"] = sourceUri;
    }
    return _json;
  }
}

/**
 * ReferenceBound records an upper bound for the starting coordinate of
 * variants in a particular reference.
 */
class ReferenceBound {
  /** The name of the reference associated with this reference bound. */
  core.String referenceName;
  /**
   * An upper bound (inclusive) on the starting coordinate of any
   * variant in the reference sequence.
   */
  core.String upperBound;

  ReferenceBound();

  ReferenceBound.fromJson(core.Map _json) {
    if (_json.containsKey("referenceName")) {
      referenceName = _json["referenceName"];
    }
    if (_json.containsKey("upperBound")) {
      upperBound = _json["upperBound"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (referenceName != null) {
      _json["referenceName"] = referenceName;
    }
    if (upperBound != null) {
      _json["upperBound"] = upperBound;
    }
    return _json;
  }
}

/**
 * A reference set is a set of references which typically comprise a reference
 * assembly for a species, such as `GRCh38` which is representative
 * of the human genome. A reference set defines a common coordinate space for
 * comparing reference-aligned experimental data. A reference set contains 1 or
 * more references.
 *
 * For more genomics resource definitions, see [Fundamentals of Google
 * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
 */
class ReferenceSet {
  /** Public id of this reference set, such as `GRCh37`. */
  core.String assemblyId;
  /** Free text description of this reference set. */
  core.String description;
  /**
   * The server-generated reference set ID, unique across all reference sets.
   */
  core.String id;
  /**
   * Order-independent MD5 checksum which identifies this reference set. The
   * checksum is computed by sorting all lower case hexidecimal string
   * `reference.md5checksum` (for all reference in this set) in
   * ascending lexicographic order, concatenating, and taking the MD5 of that
   * value. The resulting value is represented in lower case hexadecimal format.
   */
  core.String md5checksum;
  /**
   * ID from http://www.ncbi.nlm.nih.gov/taxonomy (for example, 9606 for human)
   * indicating the species which this reference set is intended to model. Note
   * that contained references may specify a different `ncbiTaxonId`, as
   * assemblies may contain reference sequences which do not belong to the
   * modeled species, for example EBV in a human reference genome.
   */
  core.int ncbiTaxonId;
  /**
   * The IDs of the reference objects that are part of this set.
   * `Reference.md5checksum` must be unique within this set.
   */
  core.List<core.String> referenceIds;
  /**
   * All known corresponding accession IDs in INSDC (GenBank/ENA/DDBJ) ideally
   * with a version number, for example `NC_000001.11`.
   */
  core.List<core.String> sourceAccessions;
  /** The URI from which the references were obtained. */
  core.String sourceUri;

  ReferenceSet();

  ReferenceSet.fromJson(core.Map _json) {
    if (_json.containsKey("assemblyId")) {
      assemblyId = _json["assemblyId"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("md5checksum")) {
      md5checksum = _json["md5checksum"];
    }
    if (_json.containsKey("ncbiTaxonId")) {
      ncbiTaxonId = _json["ncbiTaxonId"];
    }
    if (_json.containsKey("referenceIds")) {
      referenceIds = _json["referenceIds"];
    }
    if (_json.containsKey("sourceAccessions")) {
      sourceAccessions = _json["sourceAccessions"];
    }
    if (_json.containsKey("sourceUri")) {
      sourceUri = _json["sourceUri"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (assemblyId != null) {
      _json["assemblyId"] = assemblyId;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (md5checksum != null) {
      _json["md5checksum"] = md5checksum;
    }
    if (ncbiTaxonId != null) {
      _json["ncbiTaxonId"] = ncbiTaxonId;
    }
    if (referenceIds != null) {
      _json["referenceIds"] = referenceIds;
    }
    if (sourceAccessions != null) {
      _json["sourceAccessions"] = sourceAccessions;
    }
    if (sourceUri != null) {
      _json["sourceUri"] = sourceUri;
    }
    return _json;
  }
}

/**
 * Runtime metadata that will be populated in the
 * runtimeMetadata
 * field of the Operation associated with a RunPipeline execution.
 */
class RuntimeMetadata {
  /** Execution information specific to Google Compute Engine. */
  ComputeEngine computeEngine;

  RuntimeMetadata();

  RuntimeMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("computeEngine")) {
      computeEngine = new ComputeEngine.fromJson(_json["computeEngine"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (computeEngine != null) {
      _json["computeEngine"] = (computeEngine).toJson();
    }
    return _json;
  }
}

class SearchAnnotationSetsRequest {
  /**
   * Required. The dataset IDs to search within. Caller must have `READ` access
   * to these datasets.
   */
  core.List<core.String> datasetIds;
  /**
   * Only return annotations sets for which a substring of the name matches this
   * string (case insensitive).
   */
  core.String name;
  /**
   * The maximum number of results to return in a single page. If unspecified,
   * defaults to 128. The maximum value is 1024.
   */
  core.int pageSize;
  /**
   * The continuation token, which is used to page through large result sets.
   * To get the next page of results, set this parameter to the value of
   * `nextPageToken` from the previous response.
   */
  core.String pageToken;
  /**
   * If specified, only annotation sets associated with the given reference set
   * are returned.
   */
  core.String referenceSetId;
  /**
   * If specified, only annotation sets that have any of these types are
   * returned.
   */
  core.List<core.String> types;

  SearchAnnotationSetsRequest();

  SearchAnnotationSetsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("datasetIds")) {
      datasetIds = _json["datasetIds"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("pageSize")) {
      pageSize = _json["pageSize"];
    }
    if (_json.containsKey("pageToken")) {
      pageToken = _json["pageToken"];
    }
    if (_json.containsKey("referenceSetId")) {
      referenceSetId = _json["referenceSetId"];
    }
    if (_json.containsKey("types")) {
      types = _json["types"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (datasetIds != null) {
      _json["datasetIds"] = datasetIds;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (pageSize != null) {
      _json["pageSize"] = pageSize;
    }
    if (pageToken != null) {
      _json["pageToken"] = pageToken;
    }
    if (referenceSetId != null) {
      _json["referenceSetId"] = referenceSetId;
    }
    if (types != null) {
      _json["types"] = types;
    }
    return _json;
  }
}

class SearchAnnotationSetsResponse {
  /** The matching annotation sets. */
  core.List<AnnotationSet> annotationSets;
  /**
   * The continuation token, which is used to page through large result sets.
   * Provide this value in a subsequent request to return the next page of
   * results. This field will be empty if there aren't any additional results.
   */
  core.String nextPageToken;

  SearchAnnotationSetsResponse();

  SearchAnnotationSetsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("annotationSets")) {
      annotationSets = _json["annotationSets"].map((value) => new AnnotationSet.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (annotationSets != null) {
      _json["annotationSets"] = annotationSets.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

class SearchAnnotationsRequest {
  /**
   * Required. The annotation sets to search within. The caller must have
   * `READ` access to these annotation sets.
   * All queried annotation sets must have the same type.
   */
  core.List<core.String> annotationSetIds;
  /**
   * The end position of the range on the reference, 0-based exclusive. If
   * referenceId or
   * referenceName
   * must be specified, Defaults to the length of the reference.
   */
  core.String end;
  /**
   * The maximum number of results to return in a single page. If unspecified,
   * defaults to 256. The maximum value is 2048.
   */
  core.int pageSize;
  /**
   * The continuation token, which is used to page through large result sets.
   * To get the next page of results, set this parameter to the value of
   * `nextPageToken` from the previous response.
   */
  core.String pageToken;
  /** The ID of the reference to query. */
  core.String referenceId;
  /**
   * The name of the reference to query, within the reference set associated
   * with this query.
   */
  core.String referenceName;
  /**
   * The start position of the range on the reference, 0-based inclusive. If
   * specified,
   * referenceId or
   * referenceName
   * must be specified. Defaults to 0.
   */
  core.String start;

  SearchAnnotationsRequest();

  SearchAnnotationsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("annotationSetIds")) {
      annotationSetIds = _json["annotationSetIds"];
    }
    if (_json.containsKey("end")) {
      end = _json["end"];
    }
    if (_json.containsKey("pageSize")) {
      pageSize = _json["pageSize"];
    }
    if (_json.containsKey("pageToken")) {
      pageToken = _json["pageToken"];
    }
    if (_json.containsKey("referenceId")) {
      referenceId = _json["referenceId"];
    }
    if (_json.containsKey("referenceName")) {
      referenceName = _json["referenceName"];
    }
    if (_json.containsKey("start")) {
      start = _json["start"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (annotationSetIds != null) {
      _json["annotationSetIds"] = annotationSetIds;
    }
    if (end != null) {
      _json["end"] = end;
    }
    if (pageSize != null) {
      _json["pageSize"] = pageSize;
    }
    if (pageToken != null) {
      _json["pageToken"] = pageToken;
    }
    if (referenceId != null) {
      _json["referenceId"] = referenceId;
    }
    if (referenceName != null) {
      _json["referenceName"] = referenceName;
    }
    if (start != null) {
      _json["start"] = start;
    }
    return _json;
  }
}

class SearchAnnotationsResponse {
  /** The matching annotations. */
  core.List<Annotation> annotations;
  /**
   * The continuation token, which is used to page through large result sets.
   * Provide this value in a subsequent request to return the next page of
   * results. This field will be empty if there aren't any additional results.
   */
  core.String nextPageToken;

  SearchAnnotationsResponse();

  SearchAnnotationsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("annotations")) {
      annotations = _json["annotations"].map((value) => new Annotation.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (annotations != null) {
      _json["annotations"] = annotations.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** The call set search request. */
class SearchCallSetsRequest {
  /**
   * Only return call sets for which a substring of the name matches this
   * string.
   */
  core.String name;
  /**
   * The maximum number of results to return in a single page. If unspecified,
   * defaults to 1024.
   */
  core.int pageSize;
  /**
   * The continuation token, which is used to page through large result sets.
   * To get the next page of results, set this parameter to the value of
   * `nextPageToken` from the previous response.
   */
  core.String pageToken;
  /**
   * Restrict the query to call sets within the given variant sets. At least one
   * ID must be provided.
   */
  core.List<core.String> variantSetIds;

  SearchCallSetsRequest();

  SearchCallSetsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("pageSize")) {
      pageSize = _json["pageSize"];
    }
    if (_json.containsKey("pageToken")) {
      pageToken = _json["pageToken"];
    }
    if (_json.containsKey("variantSetIds")) {
      variantSetIds = _json["variantSetIds"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (name != null) {
      _json["name"] = name;
    }
    if (pageSize != null) {
      _json["pageSize"] = pageSize;
    }
    if (pageToken != null) {
      _json["pageToken"] = pageToken;
    }
    if (variantSetIds != null) {
      _json["variantSetIds"] = variantSetIds;
    }
    return _json;
  }
}

/** The call set search response. */
class SearchCallSetsResponse {
  /** The list of matching call sets. */
  core.List<CallSet> callSets;
  /**
   * The continuation token, which is used to page through large result sets.
   * Provide this value in a subsequent request to return the next page of
   * results. This field will be empty if there aren't any additional results.
   */
  core.String nextPageToken;

  SearchCallSetsResponse();

  SearchCallSetsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("callSets")) {
      callSets = _json["callSets"].map((value) => new CallSet.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (callSets != null) {
      _json["callSets"] = callSets.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

/** The read group set search request. */
class SearchReadGroupSetsRequest {
  /**
   * Restricts this query to read group sets within the given datasets. At least
   * one ID must be provided.
   */
  core.List<core.String> datasetIds;
  /**
   * Only return read group sets for which a substring of the name matches this
   * string.
   */
  core.String name;
  /**
   * The maximum number of results to return in a single page. If unspecified,
   * defaults to 256. The maximum value is 1024.
   */
  core.int pageSize;
  /**
   * The continuation token, which is used to page through large result sets.
   * To get the next page of results, set this parameter to the value of
   * `nextPageToken` from the previous response.
   */
  core.String pageToken;

  SearchReadGroupSetsRequest();

  SearchReadGroupSetsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("datasetIds")) {
      datasetIds = _json["datasetIds"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("pageSize")) {
      pageSize = _json["pageSize"];
    }
    if (_json.containsKey("pageToken")) {
      pageToken = _json["pageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (datasetIds != null) {
      _json["datasetIds"] = datasetIds;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (pageSize != null) {
      _json["pageSize"] = pageSize;
    }
    if (pageToken != null) {
      _json["pageToken"] = pageToken;
    }
    return _json;
  }
}

/** The read group set search response. */
class SearchReadGroupSetsResponse {
  /**
   * The continuation token, which is used to page through large result sets.
   * Provide this value in a subsequent request to return the next page of
   * results. This field will be empty if there aren't any additional results.
   */
  core.String nextPageToken;
  /** The list of matching read group sets. */
  core.List<ReadGroupSet> readGroupSets;

  SearchReadGroupSetsResponse();

  SearchReadGroupSetsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("readGroupSets")) {
      readGroupSets = _json["readGroupSets"].map((value) => new ReadGroupSet.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (readGroupSets != null) {
      _json["readGroupSets"] = readGroupSets.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** The read search request. */
class SearchReadsRequest {
  /**
   * The end position of the range on the reference, 0-based exclusive. If
   * specified, `referenceName` must also be specified.
   */
  core.String end;
  /**
   * The maximum number of results to return in a single page. If unspecified,
   * defaults to 256. The maximum value is 2048.
   */
  core.int pageSize;
  /**
   * The continuation token, which is used to page through large result sets.
   * To get the next page of results, set this parameter to the value of
   * `nextPageToken` from the previous response.
   */
  core.String pageToken;
  /**
   * The IDs of the read groups within which to search for reads. All specified
   * read groups must belong to the same read group sets. Must specify one of
   * `readGroupSetIds` or `readGroupIds`.
   */
  core.List<core.String> readGroupIds;
  /**
   * The IDs of the read groups sets within which to search for reads. All
   * specified read group sets must be aligned against a common set of reference
   * sequences; this defines the genomic coordinates for the query. Must specify
   * one of `readGroupSetIds` or `readGroupIds`.
   */
  core.List<core.String> readGroupSetIds;
  /**
   * The reference sequence name, for example `chr1`, `1`, or `chrX`. If set to
   * `*`, only unmapped reads are returned. If unspecified, all reads (mapped
   * and unmapped) are returned.
   */
  core.String referenceName;
  /**
   * The start position of the range on the reference, 0-based inclusive. If
   * specified, `referenceName` must also be specified.
   */
  core.String start;

  SearchReadsRequest();

  SearchReadsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("end")) {
      end = _json["end"];
    }
    if (_json.containsKey("pageSize")) {
      pageSize = _json["pageSize"];
    }
    if (_json.containsKey("pageToken")) {
      pageToken = _json["pageToken"];
    }
    if (_json.containsKey("readGroupIds")) {
      readGroupIds = _json["readGroupIds"];
    }
    if (_json.containsKey("readGroupSetIds")) {
      readGroupSetIds = _json["readGroupSetIds"];
    }
    if (_json.containsKey("referenceName")) {
      referenceName = _json["referenceName"];
    }
    if (_json.containsKey("start")) {
      start = _json["start"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (end != null) {
      _json["end"] = end;
    }
    if (pageSize != null) {
      _json["pageSize"] = pageSize;
    }
    if (pageToken != null) {
      _json["pageToken"] = pageToken;
    }
    if (readGroupIds != null) {
      _json["readGroupIds"] = readGroupIds;
    }
    if (readGroupSetIds != null) {
      _json["readGroupSetIds"] = readGroupSetIds;
    }
    if (referenceName != null) {
      _json["referenceName"] = referenceName;
    }
    if (start != null) {
      _json["start"] = start;
    }
    return _json;
  }
}

/** The read search response. */
class SearchReadsResponse {
  /**
   * The list of matching alignments sorted by mapped genomic coordinate,
   * if any, ascending in position within the same reference. Unmapped reads,
   * which have no position, are returned contiguously and are sorted in
   * ascending lexicographic order by fragment name.
   */
  core.List<Read> alignments;
  /**
   * The continuation token, which is used to page through large result sets.
   * Provide this value in a subsequent request to return the next page of
   * results. This field will be empty if there aren't any additional results.
   */
  core.String nextPageToken;

  SearchReadsResponse();

  SearchReadsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("alignments")) {
      alignments = _json["alignments"].map((value) => new Read.fromJson(value)).toList();
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (alignments != null) {
      _json["alignments"] = alignments.map((value) => (value).toJson()).toList();
    }
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    return _json;
  }
}

class SearchReferenceSetsRequest {
  /**
   * If present, return reference sets for which a prefix of any of
   * sourceAccessions
   * match any of these strings. Accession numbers typically have a main number
   * and a version, for example `NC_000001.11`.
   */
  core.List<core.String> accessions;
  /**
   * If present, return reference sets for which a substring of their
   * `assemblyId` matches this string (case insensitive).
   */
  core.String assemblyId;
  /**
   * If present, return reference sets for which the
   * md5checksum matches exactly.
   */
  core.List<core.String> md5checksums;
  /**
   * The maximum number of results to return in a single page. If unspecified,
   * defaults to 1024. The maximum value is 4096.
   */
  core.int pageSize;
  /**
   * The continuation token, which is used to page through large result sets.
   * To get the next page of results, set this parameter to the value of
   * `nextPageToken` from the previous response.
   */
  core.String pageToken;

  SearchReferenceSetsRequest();

  SearchReferenceSetsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("accessions")) {
      accessions = _json["accessions"];
    }
    if (_json.containsKey("assemblyId")) {
      assemblyId = _json["assemblyId"];
    }
    if (_json.containsKey("md5checksums")) {
      md5checksums = _json["md5checksums"];
    }
    if (_json.containsKey("pageSize")) {
      pageSize = _json["pageSize"];
    }
    if (_json.containsKey("pageToken")) {
      pageToken = _json["pageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accessions != null) {
      _json["accessions"] = accessions;
    }
    if (assemblyId != null) {
      _json["assemblyId"] = assemblyId;
    }
    if (md5checksums != null) {
      _json["md5checksums"] = md5checksums;
    }
    if (pageSize != null) {
      _json["pageSize"] = pageSize;
    }
    if (pageToken != null) {
      _json["pageToken"] = pageToken;
    }
    return _json;
  }
}

class SearchReferenceSetsResponse {
  /**
   * The continuation token, which is used to page through large result sets.
   * Provide this value in a subsequent request to return the next page of
   * results. This field will be empty if there aren't any additional results.
   */
  core.String nextPageToken;
  /** The matching references sets. */
  core.List<ReferenceSet> referenceSets;

  SearchReferenceSetsResponse();

  SearchReferenceSetsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("referenceSets")) {
      referenceSets = _json["referenceSets"].map((value) => new ReferenceSet.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (referenceSets != null) {
      _json["referenceSets"] = referenceSets.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

class SearchReferencesRequest {
  /**
   * If present, return references for which a prefix of any of
   * sourceAccessions match
   * any of these strings. Accession numbers typically have a main number and a
   * version, for example `GCF_000001405.26`.
   */
  core.List<core.String> accessions;
  /**
   * If present, return references for which the
   * md5checksum matches exactly.
   */
  core.List<core.String> md5checksums;
  /**
   * The maximum number of results to return in a single page. If unspecified,
   * defaults to 1024. The maximum value is 4096.
   */
  core.int pageSize;
  /**
   * The continuation token, which is used to page through large result sets.
   * To get the next page of results, set this parameter to the value of
   * `nextPageToken` from the previous response.
   */
  core.String pageToken;
  /** If present, return only references which belong to this reference set. */
  core.String referenceSetId;

  SearchReferencesRequest();

  SearchReferencesRequest.fromJson(core.Map _json) {
    if (_json.containsKey("accessions")) {
      accessions = _json["accessions"];
    }
    if (_json.containsKey("md5checksums")) {
      md5checksums = _json["md5checksums"];
    }
    if (_json.containsKey("pageSize")) {
      pageSize = _json["pageSize"];
    }
    if (_json.containsKey("pageToken")) {
      pageToken = _json["pageToken"];
    }
    if (_json.containsKey("referenceSetId")) {
      referenceSetId = _json["referenceSetId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (accessions != null) {
      _json["accessions"] = accessions;
    }
    if (md5checksums != null) {
      _json["md5checksums"] = md5checksums;
    }
    if (pageSize != null) {
      _json["pageSize"] = pageSize;
    }
    if (pageToken != null) {
      _json["pageToken"] = pageToken;
    }
    if (referenceSetId != null) {
      _json["referenceSetId"] = referenceSetId;
    }
    return _json;
  }
}

class SearchReferencesResponse {
  /**
   * The continuation token, which is used to page through large result sets.
   * Provide this value in a subsequent request to return the next page of
   * results. This field will be empty if there aren't any additional results.
   */
  core.String nextPageToken;
  /** The matching references. */
  core.List<Reference> references;

  SearchReferencesResponse();

  SearchReferencesResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("references")) {
      references = _json["references"].map((value) => new Reference.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (references != null) {
      _json["references"] = references.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** The search variant sets request. */
class SearchVariantSetsRequest {
  /**
   * Exactly one dataset ID must be provided here. Only variant sets which
   * belong to this dataset will be returned.
   */
  core.List<core.String> datasetIds;
  /**
   * The maximum number of results to return in a single page. If unspecified,
   * defaults to 1024.
   */
  core.int pageSize;
  /**
   * The continuation token, which is used to page through large result sets.
   * To get the next page of results, set this parameter to the value of
   * `nextPageToken` from the previous response.
   */
  core.String pageToken;

  SearchVariantSetsRequest();

  SearchVariantSetsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("datasetIds")) {
      datasetIds = _json["datasetIds"];
    }
    if (_json.containsKey("pageSize")) {
      pageSize = _json["pageSize"];
    }
    if (_json.containsKey("pageToken")) {
      pageToken = _json["pageToken"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (datasetIds != null) {
      _json["datasetIds"] = datasetIds;
    }
    if (pageSize != null) {
      _json["pageSize"] = pageSize;
    }
    if (pageToken != null) {
      _json["pageToken"] = pageToken;
    }
    return _json;
  }
}

/** The search variant sets response. */
class SearchVariantSetsResponse {
  /**
   * The continuation token, which is used to page through large result sets.
   * Provide this value in a subsequent request to return the next page of
   * results. This field will be empty if there aren't any additional results.
   */
  core.String nextPageToken;
  /** The variant sets belonging to the requested dataset. */
  core.List<VariantSet> variantSets;

  SearchVariantSetsResponse();

  SearchVariantSetsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("variantSets")) {
      variantSets = _json["variantSets"].map((value) => new VariantSet.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (variantSets != null) {
      _json["variantSets"] = variantSets.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** The variant search request. */
class SearchVariantsRequest {
  /**
   * Only return variant calls which belong to call sets with these ids.
   * Leaving this blank returns all variant calls. If a variant has no
   * calls belonging to any of these call sets, it won't be returned at all.
   */
  core.List<core.String> callSetIds;
  /**
   * The end of the window, 0-based exclusive. If unspecified or 0, defaults to
   * the length of the reference.
   */
  core.String end;
  /**
   * The maximum number of calls to return in a single page. Note that this
   * limit may be exceeded in the event that a matching variant contains more
   * calls than the requested maximum. If unspecified, defaults to 5000. The
   * maximum value is 10000.
   */
  core.int maxCalls;
  /**
   * The maximum number of variants to return in a single page. If unspecified,
   * defaults to 5000. The maximum value is 10000.
   */
  core.int pageSize;
  /**
   * The continuation token, which is used to page through large result sets.
   * To get the next page of results, set this parameter to the value of
   * `nextPageToken` from the previous response.
   */
  core.String pageToken;
  /** Required. Only return variants in this reference sequence. */
  core.String referenceName;
  /**
   * The beginning of the window (0-based, inclusive) for which
   * overlapping variants should be returned. If unspecified, defaults to 0.
   */
  core.String start;
  /** Only return variants which have exactly this name. */
  core.String variantName;
  /**
   * At most one variant set ID must be provided. Only variants from this
   * variant set will be returned. If omitted, a call set id must be included in
   * the request.
   */
  core.List<core.String> variantSetIds;

  SearchVariantsRequest();

  SearchVariantsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("callSetIds")) {
      callSetIds = _json["callSetIds"];
    }
    if (_json.containsKey("end")) {
      end = _json["end"];
    }
    if (_json.containsKey("maxCalls")) {
      maxCalls = _json["maxCalls"];
    }
    if (_json.containsKey("pageSize")) {
      pageSize = _json["pageSize"];
    }
    if (_json.containsKey("pageToken")) {
      pageToken = _json["pageToken"];
    }
    if (_json.containsKey("referenceName")) {
      referenceName = _json["referenceName"];
    }
    if (_json.containsKey("start")) {
      start = _json["start"];
    }
    if (_json.containsKey("variantName")) {
      variantName = _json["variantName"];
    }
    if (_json.containsKey("variantSetIds")) {
      variantSetIds = _json["variantSetIds"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (callSetIds != null) {
      _json["callSetIds"] = callSetIds;
    }
    if (end != null) {
      _json["end"] = end;
    }
    if (maxCalls != null) {
      _json["maxCalls"] = maxCalls;
    }
    if (pageSize != null) {
      _json["pageSize"] = pageSize;
    }
    if (pageToken != null) {
      _json["pageToken"] = pageToken;
    }
    if (referenceName != null) {
      _json["referenceName"] = referenceName;
    }
    if (start != null) {
      _json["start"] = start;
    }
    if (variantName != null) {
      _json["variantName"] = variantName;
    }
    if (variantSetIds != null) {
      _json["variantSetIds"] = variantSetIds;
    }
    return _json;
  }
}

/** The variant search response. */
class SearchVariantsResponse {
  /**
   * The continuation token, which is used to page through large result sets.
   * Provide this value in a subsequent request to return the next page of
   * results. This field will be empty if there aren't any additional results.
   */
  core.String nextPageToken;
  /** The list of matching Variants. */
  core.List<Variant> variants;

  SearchVariantsResponse();

  SearchVariantsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("variants")) {
      variants = _json["variants"].map((value) => new Variant.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (nextPageToken != null) {
      _json["nextPageToken"] = nextPageToken;
    }
    if (variants != null) {
      _json["variants"] = variants.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** Request message for `SetIamPolicy` method. */
class SetIamPolicyRequest {
  /**
   * REQUIRED: The complete policy to be applied to the `resource`. The size of
   * the policy is limited to a few 10s of KB. An empty policy is a
   * valid policy but certain Cloud Platform services (such as Projects)
   * might reject them.
   */
  Policy policy;

  SetIamPolicyRequest();

  SetIamPolicyRequest.fromJson(core.Map _json) {
    if (_json.containsKey("policy")) {
      policy = new Policy.fromJson(_json["policy"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (policy != null) {
      _json["policy"] = (policy).toJson();
    }
    return _json;
  }
}

/**
 * The `Status` type defines a logical error model that is suitable for
 * different
 * programming environments, including REST APIs and RPC APIs. It is used by
 * [gRPC](https://github.com/grpc). The error model is designed to be:
 *
 * - Simple to use and understand for most users
 * - Flexible enough to meet unexpected needs
 *
 * # Overview
 *
 * The `Status` message contains three pieces of data: error code, error
 * message,
 * and error details. The error code should be an enum value of
 * google.rpc.Code, but it may accept additional error codes if needed.  The
 * error message should be a developer-facing English message that helps
 * developers *understand* and *resolve* the error. If a localized user-facing
 * error message is needed, put the localized message in the error details or
 * localize it in the client. The optional error details may contain arbitrary
 * information about the error. There is a predefined set of error detail types
 * in the package `google.rpc` which can be used for common error conditions.
 *
 * # Language mapping
 *
 * The `Status` message is the logical representation of the error model, but it
 * is not necessarily the actual wire format. When the `Status` message is
 * exposed in different client libraries and different wire protocols, it can be
 * mapped differently. For example, it will likely be mapped to some exceptions
 * in Java, but more likely mapped to some error codes in C.
 *
 * # Other uses
 *
 * The error model and the `Status` message can be used in a variety of
 * environments, either with or without APIs, to provide a
 * consistent developer experience across different environments.
 *
 * Example uses of this error model include:
 *
 * - Partial errors. If a service needs to return partial errors to the client,
 *     it may embed the `Status` in the normal response to indicate the partial
 *     errors.
 *
 * - Workflow errors. A typical workflow has multiple steps. Each step may
 *     have a `Status` message for error reporting purpose.
 *
 * - Batch operations. If a client uses batch request and batch response, the
 *     `Status` message should be used directly inside batch response, one for
 *     each error sub-response.
 *
 * - Asynchronous operations. If an API call embeds asynchronous operation
 *     results in its response, the status of those operations should be
 *     represented directly using the `Status` message.
 *
 * - Logging. If some API errors are stored in logs, the message `Status` could
 * be used directly after any stripping needed for security/privacy reasons.
 */
class Status {
  /** The status code, which should be an enum value of google.rpc.Code. */
  core.int code;
  /**
   * A list of messages that carry the error details.  There will be a
   * common set of message types for APIs to use.
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.List<core.Map<core.String, core.Object>> details;
  /**
   * A developer-facing error message, which should be in English. Any
   * user-facing error message should be localized and sent in the
   * google.rpc.Status.details field, or localized by the client.
   */
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

  core.Map toJson() {
    var _json = new core.Map();
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

/** Request message for `TestIamPermissions` method. */
class TestIamPermissionsRequest {
  /**
   * REQUIRED: The set of permissions to check for the 'resource'.
   * Permissions with wildcards (such as '*' or 'storage.*') are not allowed.
   * Allowed permissions are&#58;
   *
   * * `genomics.datasets.create`
   * * `genomics.datasets.delete`
   * * `genomics.datasets.get`
   * * `genomics.datasets.list`
   * * `genomics.datasets.update`
   * * `genomics.datasets.getIamPolicy`
   * * `genomics.datasets.setIamPolicy`
   */
  core.List<core.String> permissions;

  TestIamPermissionsRequest();

  TestIamPermissionsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("permissions")) {
      permissions = _json["permissions"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (permissions != null) {
      _json["permissions"] = permissions;
    }
    return _json;
  }
}

/** Response message for `TestIamPermissions` method. */
class TestIamPermissionsResponse {
  /**
   * A subset of `TestPermissionsRequest.permissions` that the caller is
   * allowed.
   */
  core.List<core.String> permissions;

  TestIamPermissionsResponse();

  TestIamPermissionsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("permissions")) {
      permissions = _json["permissions"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (permissions != null) {
      _json["permissions"] = permissions;
    }
    return _json;
  }
}

/**
 * A transcript represents the assertion that a particular region of the
 * reference genome may be transcribed as RNA.
 */
class Transcript {
  /**
   * The range of the coding sequence for this transcript, if any. To determine
   * the exact ranges of coding sequence, intersect this range with those of the
   * exons, if any. If there are any
   * exons, the
   * codingSequence must start
   * and end within them.
   *
   * Note that in some cases, the reference genome will not exactly match the
   * observed mRNA transcript e.g. due to variance in the source genome from
   * reference. In these cases,
   * exon.frame will not necessarily
   * match the expected reference reading frame and coding exon reference bases
   * cannot necessarily be concatenated to produce the original transcript mRNA.
   */
  CodingSequence codingSequence;
  /**
   * The <a href="http://en.wikipedia.org/wiki/Exon">exons</a> that compose
   * this transcript. This field should be unset for genomes where transcript
   * splicing does not occur, for example prokaryotes.
   *
   * Introns are regions of the transcript that are not included in the
   * spliced RNA product. Though not explicitly modeled here, intron ranges can
   * be deduced; all regions of this transcript that are not exons are introns.
   *
   * Exonic sequences do not necessarily code for a translational product
   * (amino acids). Only the regions of exons bounded by the
   * codingSequence correspond
   * to coding DNA sequence.
   *
   * Exons are ordered by start position and may not overlap.
   */
  core.List<Exon> exons;
  /**
   * The annotation ID of the gene from which this transcript is transcribed.
   */
  core.String geneId;

  Transcript();

  Transcript.fromJson(core.Map _json) {
    if (_json.containsKey("codingSequence")) {
      codingSequence = new CodingSequence.fromJson(_json["codingSequence"]);
    }
    if (_json.containsKey("exons")) {
      exons = _json["exons"].map((value) => new Exon.fromJson(value)).toList();
    }
    if (_json.containsKey("geneId")) {
      geneId = _json["geneId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (codingSequence != null) {
      _json["codingSequence"] = (codingSequence).toJson();
    }
    if (exons != null) {
      _json["exons"] = exons.map((value) => (value).toJson()).toList();
    }
    if (geneId != null) {
      _json["geneId"] = geneId;
    }
    return _json;
  }
}

class UndeleteDatasetRequest {

  UndeleteDatasetRequest();

  UndeleteDatasetRequest.fromJson(core.Map _json) {
  }

  core.Map toJson() {
    var _json = new core.Map();
    return _json;
  }
}

/**
 * A variant represents a change in DNA sequence relative to a reference
 * sequence. For example, a variant could represent a SNP or an insertion.
 * Variants belong to a variant set.
 *
 * For more genomics resource definitions, see [Fundamentals of Google
 * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
 *
 * Each of the calls on a variant represent a determination of genotype with
 * respect to that variant. For example, a call might assign probability of 0.32
 * to the occurrence of a SNP named rs1234 in a sample named NA12345. A call
 * belongs to a call set, which contains related calls typically from one
 * sample.
 */
class Variant {
  /** The bases that appear instead of the reference bases. */
  core.List<core.String> alternateBases;
  /**
   * The variant calls for this particular variant. Each one represents the
   * determination of genotype with respect to this variant.
   */
  core.List<VariantCall> calls;
  /** The date this variant was created, in milliseconds from the epoch. */
  core.String created;
  /**
   * The end position (0-based) of this variant. This corresponds to the first
   * base after the last base in the reference allele. So, the length of
   * the reference allele is (end - start). This is useful for variants
   * that don't explicitly give alternate bases, for example large deletions.
   */
  core.String end;
  /**
   * A list of filters (normally quality filters) this variant has failed.
   * `PASS` indicates this variant has passed all filters.
   */
  core.List<core.String> filter;
  /** The server-generated variant ID, unique across all variants. */
  core.String id;
  /**
   * A map of additional variant information. This must be of the form
   * map<string, string[]> (string key mapping to a list of string values).
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Map<core.String, core.List<core.Object>> info;
  /** Names for the variant, for example a RefSNP ID. */
  core.List<core.String> names;
  /**
   * A measure of how likely this variant is to be real.
   * A higher value is better.
   */
  core.double quality;
  /**
   * The reference bases for this variant. They start at the given
   * position.
   */
  core.String referenceBases;
  /**
   * The reference on which this variant occurs.
   * (such as `chr20` or `X`)
   */
  core.String referenceName;
  /**
   * The position at which this variant occurs (0-based).
   * This corresponds to the first base of the string of reference bases.
   */
  core.String start;
  /** The ID of the variant set this variant belongs to. */
  core.String variantSetId;

  Variant();

  Variant.fromJson(core.Map _json) {
    if (_json.containsKey("alternateBases")) {
      alternateBases = _json["alternateBases"];
    }
    if (_json.containsKey("calls")) {
      calls = _json["calls"].map((value) => new VariantCall.fromJson(value)).toList();
    }
    if (_json.containsKey("created")) {
      created = _json["created"];
    }
    if (_json.containsKey("end")) {
      end = _json["end"];
    }
    if (_json.containsKey("filter")) {
      filter = _json["filter"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("info")) {
      info = _json["info"];
    }
    if (_json.containsKey("names")) {
      names = _json["names"];
    }
    if (_json.containsKey("quality")) {
      quality = _json["quality"];
    }
    if (_json.containsKey("referenceBases")) {
      referenceBases = _json["referenceBases"];
    }
    if (_json.containsKey("referenceName")) {
      referenceName = _json["referenceName"];
    }
    if (_json.containsKey("start")) {
      start = _json["start"];
    }
    if (_json.containsKey("variantSetId")) {
      variantSetId = _json["variantSetId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (alternateBases != null) {
      _json["alternateBases"] = alternateBases;
    }
    if (calls != null) {
      _json["calls"] = calls.map((value) => (value).toJson()).toList();
    }
    if (created != null) {
      _json["created"] = created;
    }
    if (end != null) {
      _json["end"] = end;
    }
    if (filter != null) {
      _json["filter"] = filter;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (info != null) {
      _json["info"] = info;
    }
    if (names != null) {
      _json["names"] = names;
    }
    if (quality != null) {
      _json["quality"] = quality;
    }
    if (referenceBases != null) {
      _json["referenceBases"] = referenceBases;
    }
    if (referenceName != null) {
      _json["referenceName"] = referenceName;
    }
    if (start != null) {
      _json["start"] = start;
    }
    if (variantSetId != null) {
      _json["variantSetId"] = variantSetId;
    }
    return _json;
  }
}

class VariantAnnotation {
  /**
   * The alternate allele for this variant. If multiple alternate alleles
   * exist at this location, create a separate variant for each one, as they
   * may represent distinct conditions.
   */
  core.String alternateBases;
  /**
   * Describes the clinical significance of a variant.
   * It is adapted from the ClinVar controlled vocabulary for clinical
   * significance described at:
   * http://www.ncbi.nlm.nih.gov/clinvar/docs/clinsig/
   * Possible string values are:
   * - "CLINICAL_SIGNIFICANCE_UNSPECIFIED"
   * - "CLINICAL_SIGNIFICANCE_OTHER" : `OTHER` should be used when no other
   * clinical significance
   * value will suffice.
   * - "UNCERTAIN"
   * - "BENIGN"
   * - "LIKELY_BENIGN"
   * - "LIKELY_PATHOGENIC"
   * - "PATHOGENIC"
   * - "DRUG_RESPONSE"
   * - "HISTOCOMPATIBILITY"
   * - "CONFERS_SENSITIVITY"
   * - "RISK_FACTOR"
   * - "ASSOCIATION"
   * - "PROTECTIVE"
   * - "MULTIPLE_REPORTED" : `MULTIPLE_REPORTED` should be used when multiple
   * clinical
   * signficances are reported for a variant. The original clinical
   * significance values may be provided in the `info` field.
   */
  core.String clinicalSignificance;
  /**
   * The set of conditions associated with this variant.
   * A condition describes the way a variant influences human health.
   */
  core.List<ClinicalCondition> conditions;
  /**
   * Effect of the variant on the coding sequence.
   * Possible string values are:
   * - "EFFECT_UNSPECIFIED"
   * - "EFFECT_OTHER" : `EFFECT_OTHER` should be used when no other Effect
   * will suffice.
   * - "FRAMESHIFT" : `FRAMESHIFT` indicates a mutation in which the insertion
   * or
   * deletion of nucleotides resulted in a frameshift change.
   * - "FRAME_PRESERVING_INDEL" : `FRAME_PRESERVING_INDEL` indicates a mutation
   * in which a
   * multiple of three nucleotides has been inserted or deleted, resulting
   * in no change to the reading frame of the coding sequence.
   * - "SYNONYMOUS_SNP" : `SYNONYMOUS_SNP` indicates a single nucleotide
   * polymorphism
   * mutation that results in no amino acid change.
   * - "NONSYNONYMOUS_SNP" : `NONSYNONYMOUS_SNP` indicates a single nucleotide
   * polymorphism mutation that results in an amino acid change.
   * - "STOP_GAIN" : `STOP_GAIN` indicates a mutation that leads to the creation
   * of a stop codon at the variant site. Frameshift mutations creating
   * downstream stop codons do not count as `STOP_GAIN`.
   * - "STOP_LOSS" : `STOP_LOSS` indicates a mutation that eliminates a
   * stop codon at the variant site.
   * - "SPLICE_SITE_DISRUPTION" : `SPLICE_SITE_DISRUPTION` indicates that this
   * variant is
   * found in a splice site for the associated transcript, and alters the
   * normal splicing pattern.
   */
  core.String effect;
  /**
   * Google annotation ID of the gene affected by this variant. This should
   * be provided when the variant is created.
   */
  core.String geneId;
  /**
   * Google annotation IDs of the transcripts affected by this variant. These
   * should be provided when the variant is created.
   */
  core.List<core.String> transcriptIds;
  /**
   * Type has been adapted from ClinVar's list of variant types.
   * Possible string values are:
   * - "TYPE_UNSPECIFIED"
   * - "TYPE_OTHER" : `TYPE_OTHER` should be used when no other Type will
   * suffice.
   * Further explanation of the variant type may be included in the
   * info field.
   * - "INSERTION" : `INSERTION` indicates an insertion.
   * - "DELETION" : `DELETION` indicates a deletion.
   * - "SUBSTITUTION" : `SUBSTITUTION` indicates a block substitution of
   * two or more nucleotides.
   * - "SNP" : `SNP` indicates a single nucleotide polymorphism.
   * - "STRUCTURAL" : `STRUCTURAL` indicates a large structural variant,
   * including chromosomal fusions, inversions, etc.
   * - "CNV" : `CNV` indicates a variation in copy number.
   */
  core.String type;

  VariantAnnotation();

  VariantAnnotation.fromJson(core.Map _json) {
    if (_json.containsKey("alternateBases")) {
      alternateBases = _json["alternateBases"];
    }
    if (_json.containsKey("clinicalSignificance")) {
      clinicalSignificance = _json["clinicalSignificance"];
    }
    if (_json.containsKey("conditions")) {
      conditions = _json["conditions"].map((value) => new ClinicalCondition.fromJson(value)).toList();
    }
    if (_json.containsKey("effect")) {
      effect = _json["effect"];
    }
    if (_json.containsKey("geneId")) {
      geneId = _json["geneId"];
    }
    if (_json.containsKey("transcriptIds")) {
      transcriptIds = _json["transcriptIds"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (alternateBases != null) {
      _json["alternateBases"] = alternateBases;
    }
    if (clinicalSignificance != null) {
      _json["clinicalSignificance"] = clinicalSignificance;
    }
    if (conditions != null) {
      _json["conditions"] = conditions.map((value) => (value).toJson()).toList();
    }
    if (effect != null) {
      _json["effect"] = effect;
    }
    if (geneId != null) {
      _json["geneId"] = geneId;
    }
    if (transcriptIds != null) {
      _json["transcriptIds"] = transcriptIds;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/**
 * A call represents the determination of genotype with respect to a particular
 * variant. It may include associated information such as quality and phasing.
 * For example, a call might assign a probability of 0.32 to the occurrence of
 * a SNP named rs1234 in a call set with the name NA12345.
 */
class VariantCall {
  /** The ID of the call set this variant call belongs to. */
  core.String callSetId;
  /** The name of the call set this variant call belongs to. */
  core.String callSetName;
  /**
   * The genotype of this variant call. Each value represents either the value
   * of the `referenceBases` field or a 1-based index into
   * `alternateBases`. If a variant had a `referenceBases`
   * value of `T` and an `alternateBases`
   * value of `["A", "C"]`, and the `genotype` was
   * `[2, 1]`, that would mean the call
   * represented the heterozygous value `CA` for this variant.
   * If the `genotype` was instead `[0, 1]`, the
   * represented value would be `TA`. Ordering of the
   * genotype values is important if the `phaseset` is present.
   * If a genotype is not called (that is, a `.` is present in the
   * GT string) -1 is returned.
   */
  core.List<core.int> genotype;
  /**
   * The genotype likelihoods for this variant call. Each array entry
   * represents how likely a specific genotype is for this call. The value
   * ordering is defined by the GL tag in the VCF spec.
   * If Phred-scaled genotype likelihood scores (PL) are available and
   * log10(P) genotype likelihood scores (GL) are not, PL scores are converted
   * to GL scores.  If both are available, PL scores are stored in `info`.
   */
  core.List<core.double> genotypeLikelihood;
  /**
   * A map of additional variant call information. This must be of the form
   * map<string, string[]> (string key mapping to a list of string values).
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Map<core.String, core.List<core.Object>> info;
  /**
   * If this field is present, this variant call's genotype ordering implies
   * the phase of the bases and is consistent with any other variant calls in
   * the same reference sequence which have the same phaseset value.
   * When importing data from VCF, if the genotype data was phased but no
   * phase set was specified this field will be set to `*`.
   */
  core.String phaseset;

  VariantCall();

  VariantCall.fromJson(core.Map _json) {
    if (_json.containsKey("callSetId")) {
      callSetId = _json["callSetId"];
    }
    if (_json.containsKey("callSetName")) {
      callSetName = _json["callSetName"];
    }
    if (_json.containsKey("genotype")) {
      genotype = _json["genotype"];
    }
    if (_json.containsKey("genotypeLikelihood")) {
      genotypeLikelihood = _json["genotypeLikelihood"];
    }
    if (_json.containsKey("info")) {
      info = _json["info"];
    }
    if (_json.containsKey("phaseset")) {
      phaseset = _json["phaseset"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (callSetId != null) {
      _json["callSetId"] = callSetId;
    }
    if (callSetName != null) {
      _json["callSetName"] = callSetName;
    }
    if (genotype != null) {
      _json["genotype"] = genotype;
    }
    if (genotypeLikelihood != null) {
      _json["genotypeLikelihood"] = genotypeLikelihood;
    }
    if (info != null) {
      _json["info"] = info;
    }
    if (phaseset != null) {
      _json["phaseset"] = phaseset;
    }
    return _json;
  }
}

/**
 * A variant set is a collection of call sets and variants. It contains summary
 * statistics of those contents. A variant set belongs to a dataset.
 *
 * For more genomics resource definitions, see [Fundamentals of Google
 * Genomics](https://cloud.google.com/genomics/fundamentals-of-google-genomics)
 */
class VariantSet {
  /** The dataset to which this variant set belongs. */
  core.String datasetId;
  /** A textual description of this variant set. */
  core.String description;
  /** The server-generated variant set ID, unique across all variant sets. */
  core.String id;
  /** The metadata associated with this variant set. */
  core.List<VariantSetMetadata> metadata;
  /** User-specified, mutable name. */
  core.String name;
  /**
   * A list of all references used by the variants in a variant set
   * with associated coordinate upper bounds for each one.
   */
  core.List<ReferenceBound> referenceBounds;
  /**
   * The reference set to which the variant set is mapped. The reference set
   * describes the alignment provenance of the variant set, while the
   * `referenceBounds` describe the shape of the actual variant data. The
   * reference set's reference names are a superset of those found in the
   * `referenceBounds`.
   *
   * For example, given a variant set that is mapped to the GRCh38 reference set
   * and contains a single variant on reference 'X', `referenceBounds` would
   * contain only an entry for 'X', while the associated reference set
   * enumerates all possible references: '1', '2', 'X', 'Y', 'MT', etc.
   */
  core.String referenceSetId;

  VariantSet();

  VariantSet.fromJson(core.Map _json) {
    if (_json.containsKey("datasetId")) {
      datasetId = _json["datasetId"];
    }
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("metadata")) {
      metadata = _json["metadata"].map((value) => new VariantSetMetadata.fromJson(value)).toList();
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("referenceBounds")) {
      referenceBounds = _json["referenceBounds"].map((value) => new ReferenceBound.fromJson(value)).toList();
    }
    if (_json.containsKey("referenceSetId")) {
      referenceSetId = _json["referenceSetId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (datasetId != null) {
      _json["datasetId"] = datasetId;
    }
    if (description != null) {
      _json["description"] = description;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (metadata != null) {
      _json["metadata"] = metadata.map((value) => (value).toJson()).toList();
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (referenceBounds != null) {
      _json["referenceBounds"] = referenceBounds.map((value) => (value).toJson()).toList();
    }
    if (referenceSetId != null) {
      _json["referenceSetId"] = referenceSetId;
    }
    return _json;
  }
}

/**
 * Metadata describes a single piece of variant call metadata.
 * These data include a top level key and either a single value string (value)
 * or a list of key-value pairs (info.)
 * Value and info are mutually exclusive.
 */
class VariantSetMetadata {
  /** A textual description of this metadata. */
  core.String description;
  /**
   * User-provided ID field, not enforced by this API.
   * Two or more pieces of structured metadata with identical
   * id and key fields are considered equivalent.
   */
  core.String id;
  /**
   * Remaining structured metadata key-value pairs. This must be of the form
   * map<string, string[]> (string key mapping to a list of string values).
   *
   * The values for Object must be JSON objects. It can consist of `num`,
   * `String`, `bool` and `null` as well as `Map` and `List` values.
   */
  core.Map<core.String, core.List<core.Object>> info;
  /** The top-level key. */
  core.String key;
  /**
   * The number of values that can be included in a field described by this
   * metadata.
   */
  core.String number;
  /**
   * The type of data. Possible types include: Integer, Float,
   * Flag, Character, and String.
   * Possible string values are:
   * - "TYPE_UNSPECIFIED"
   * - "INTEGER"
   * - "FLOAT"
   * - "FLAG"
   * - "CHARACTER"
   * - "STRING"
   */
  core.String type;
  /** The value field for simple metadata */
  core.String value;

  VariantSetMetadata();

  VariantSetMetadata.fromJson(core.Map _json) {
    if (_json.containsKey("description")) {
      description = _json["description"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("info")) {
      info = _json["info"];
    }
    if (_json.containsKey("key")) {
      key = _json["key"];
    }
    if (_json.containsKey("number")) {
      number = _json["number"];
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
    if (description != null) {
      _json["description"] = description;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (info != null) {
      _json["info"] = info;
    }
    if (key != null) {
      _json["key"] = key;
    }
    if (number != null) {
      _json["number"] = number;
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
