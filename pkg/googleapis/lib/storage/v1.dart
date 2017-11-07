// This is a generated file (see the discoveryapis_generator project).

library googleapis.storage.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError, Media, UploadOptions,
    ResumableUploadOptions, DownloadOptions, PartialDownloadOptions,
    ByteRange;

const core.String USER_AGENT = 'dart-api-client storage/v1';

/** Stores and retrieves potentially large, immutable data objects. */
class StorageApi {
  /** View and manage your data across Google Cloud Platform services */
  static const CloudPlatformScope = "https://www.googleapis.com/auth/cloud-platform";

  /** View your data across Google Cloud Platform services */
  static const CloudPlatformReadOnlyScope = "https://www.googleapis.com/auth/cloud-platform.read-only";

  /** Manage your data and permissions in Google Cloud Storage */
  static const DevstorageFullControlScope = "https://www.googleapis.com/auth/devstorage.full_control";

  /** View your data in Google Cloud Storage */
  static const DevstorageReadOnlyScope = "https://www.googleapis.com/auth/devstorage.read_only";

  /** Manage your data in Google Cloud Storage */
  static const DevstorageReadWriteScope = "https://www.googleapis.com/auth/devstorage.read_write";


  final commons.ApiRequester _requester;

  BucketAccessControlsResourceApi get bucketAccessControls => new BucketAccessControlsResourceApi(_requester);
  BucketsResourceApi get buckets => new BucketsResourceApi(_requester);
  ChannelsResourceApi get channels => new ChannelsResourceApi(_requester);
  DefaultObjectAccessControlsResourceApi get defaultObjectAccessControls => new DefaultObjectAccessControlsResourceApi(_requester);
  ObjectAccessControlsResourceApi get objectAccessControls => new ObjectAccessControlsResourceApi(_requester);
  ObjectsResourceApi get objects => new ObjectsResourceApi(_requester);

  StorageApi(http.Client client, {core.String rootUrl: "https://www.googleapis.com/", core.String servicePath: "storage/v1/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class BucketAccessControlsResourceApi {
  final commons.ApiRequester _requester;

  BucketAccessControlsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Permanently deletes the ACL entry for the specified entity on the specified
   * bucket.
   *
   * Request parameters:
   *
   * [bucket] - Name of a bucket.
   *
   * [entity] - The entity holding the permission. Can be user-userId,
   * user-emailAddress, group-groupId, group-emailAddress, allUsers, or
   * allAuthenticatedUsers.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String bucket, core.String entity) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (entity == null) {
      throw new core.ArgumentError("Parameter entity is required.");
    }

    _downloadOptions = null;

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket') + '/acl/' + commons.Escaper.ecapeVariable('$entity');

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
   * Returns the ACL entry for the specified entity on the specified bucket.
   *
   * Request parameters:
   *
   * [bucket] - Name of a bucket.
   *
   * [entity] - The entity holding the permission. Can be user-userId,
   * user-emailAddress, group-groupId, group-emailAddress, allUsers, or
   * allAuthenticatedUsers.
   *
   * Completes with a [BucketAccessControl].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<BucketAccessControl> get(core.String bucket, core.String entity) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (entity == null) {
      throw new core.ArgumentError("Parameter entity is required.");
    }

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket') + '/acl/' + commons.Escaper.ecapeVariable('$entity');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new BucketAccessControl.fromJson(data));
  }

  /**
   * Creates a new ACL entry on the specified bucket.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [bucket] - Name of a bucket.
   *
   * Completes with a [BucketAccessControl].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<BucketAccessControl> insert(BucketAccessControl request, core.String bucket) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket') + '/acl';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new BucketAccessControl.fromJson(data));
  }

  /**
   * Retrieves ACL entries on the specified bucket.
   *
   * Request parameters:
   *
   * [bucket] - Name of a bucket.
   *
   * Completes with a [BucketAccessControls].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<BucketAccessControls> list(core.String bucket) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket') + '/acl';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new BucketAccessControls.fromJson(data));
  }

  /**
   * Updates an ACL entry on the specified bucket. This method supports patch
   * semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [bucket] - Name of a bucket.
   *
   * [entity] - The entity holding the permission. Can be user-userId,
   * user-emailAddress, group-groupId, group-emailAddress, allUsers, or
   * allAuthenticatedUsers.
   *
   * Completes with a [BucketAccessControl].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<BucketAccessControl> patch(BucketAccessControl request, core.String bucket, core.String entity) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (entity == null) {
      throw new core.ArgumentError("Parameter entity is required.");
    }

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket') + '/acl/' + commons.Escaper.ecapeVariable('$entity');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new BucketAccessControl.fromJson(data));
  }

  /**
   * Updates an ACL entry on the specified bucket.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [bucket] - Name of a bucket.
   *
   * [entity] - The entity holding the permission. Can be user-userId,
   * user-emailAddress, group-groupId, group-emailAddress, allUsers, or
   * allAuthenticatedUsers.
   *
   * Completes with a [BucketAccessControl].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<BucketAccessControl> update(BucketAccessControl request, core.String bucket, core.String entity) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (entity == null) {
      throw new core.ArgumentError("Parameter entity is required.");
    }

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket') + '/acl/' + commons.Escaper.ecapeVariable('$entity');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new BucketAccessControl.fromJson(data));
  }

}


class BucketsResourceApi {
  final commons.ApiRequester _requester;

  BucketsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Permanently deletes an empty bucket.
   *
   * Request parameters:
   *
   * [bucket] - Name of a bucket.
   *
   * [ifMetagenerationMatch] - If set, only deletes the bucket if its
   * metageneration matches this value.
   *
   * [ifMetagenerationNotMatch] - If set, only deletes the bucket if its
   * metageneration does not match this value.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String bucket, {core.String ifMetagenerationMatch, core.String ifMetagenerationNotMatch}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (ifMetagenerationMatch != null) {
      _queryParams["ifMetagenerationMatch"] = [ifMetagenerationMatch];
    }
    if (ifMetagenerationNotMatch != null) {
      _queryParams["ifMetagenerationNotMatch"] = [ifMetagenerationNotMatch];
    }

    _downloadOptions = null;

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket');

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
   * Returns metadata for the specified bucket.
   *
   * Request parameters:
   *
   * [bucket] - Name of a bucket.
   *
   * [ifMetagenerationMatch] - Makes the return of the bucket metadata
   * conditional on whether the bucket's current metageneration matches the
   * given value.
   *
   * [ifMetagenerationNotMatch] - Makes the return of the bucket metadata
   * conditional on whether the bucket's current metageneration does not match
   * the given value.
   *
   * [projection] - Set of properties to return. Defaults to noAcl.
   * Possible string values are:
   * - "full" : Include all properties.
   * - "noAcl" : Omit owner, acl and defaultObjectAcl properties.
   *
   * Completes with a [Bucket].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Bucket> get(core.String bucket, {core.String ifMetagenerationMatch, core.String ifMetagenerationNotMatch, core.String projection}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (ifMetagenerationMatch != null) {
      _queryParams["ifMetagenerationMatch"] = [ifMetagenerationMatch];
    }
    if (ifMetagenerationNotMatch != null) {
      _queryParams["ifMetagenerationNotMatch"] = [ifMetagenerationNotMatch];
    }
    if (projection != null) {
      _queryParams["projection"] = [projection];
    }

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Bucket.fromJson(data));
  }

  /**
   * Creates a new bucket.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [project] - A valid API project identifier.
   *
   * [predefinedAcl] - Apply a predefined set of access controls to this bucket.
   * Possible string values are:
   * - "authenticatedRead" : Project team owners get OWNER access, and
   * allAuthenticatedUsers get READER access.
   * - "private" : Project team owners get OWNER access.
   * - "projectPrivate" : Project team members get access according to their
   * roles.
   * - "publicRead" : Project team owners get OWNER access, and allUsers get
   * READER access.
   * - "publicReadWrite" : Project team owners get OWNER access, and allUsers
   * get WRITER access.
   *
   * [predefinedDefaultObjectAcl] - Apply a predefined set of default object
   * access controls to this bucket.
   * Possible string values are:
   * - "authenticatedRead" : Object owner gets OWNER access, and
   * allAuthenticatedUsers get READER access.
   * - "bucketOwnerFullControl" : Object owner gets OWNER access, and project
   * team owners get OWNER access.
   * - "bucketOwnerRead" : Object owner gets OWNER access, and project team
   * owners get READER access.
   * - "private" : Object owner gets OWNER access.
   * - "projectPrivate" : Object owner gets OWNER access, and project team
   * members get access according to their roles.
   * - "publicRead" : Object owner gets OWNER access, and allUsers get READER
   * access.
   *
   * [projection] - Set of properties to return. Defaults to noAcl, unless the
   * bucket resource specifies acl or defaultObjectAcl properties, when it
   * defaults to full.
   * Possible string values are:
   * - "full" : Include all properties.
   * - "noAcl" : Omit owner, acl and defaultObjectAcl properties.
   *
   * Completes with a [Bucket].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Bucket> insert(Bucket request, core.String project, {core.String predefinedAcl, core.String predefinedDefaultObjectAcl, core.String projection}) {
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
    _queryParams["project"] = [project];
    if (predefinedAcl != null) {
      _queryParams["predefinedAcl"] = [predefinedAcl];
    }
    if (predefinedDefaultObjectAcl != null) {
      _queryParams["predefinedDefaultObjectAcl"] = [predefinedDefaultObjectAcl];
    }
    if (projection != null) {
      _queryParams["projection"] = [projection];
    }

    _url = 'b';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Bucket.fromJson(data));
  }

  /**
   * Retrieves a list of buckets for a given project.
   *
   * Request parameters:
   *
   * [project] - A valid API project identifier.
   *
   * [maxResults] - Maximum number of buckets to return in a single response.
   * The service will use this parameter or 1,000 items, whichever is smaller.
   *
   * [pageToken] - A previously-returned page token representing part of the
   * larger set of results to view.
   *
   * [prefix] - Filter results to buckets whose names begin with this prefix.
   *
   * [projection] - Set of properties to return. Defaults to noAcl.
   * Possible string values are:
   * - "full" : Include all properties.
   * - "noAcl" : Omit owner, acl and defaultObjectAcl properties.
   *
   * Completes with a [Buckets].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Buckets> list(core.String project, {core.int maxResults, core.String pageToken, core.String prefix, core.String projection}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (project == null) {
      throw new core.ArgumentError("Parameter project is required.");
    }
    _queryParams["project"] = [project];
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (prefix != null) {
      _queryParams["prefix"] = [prefix];
    }
    if (projection != null) {
      _queryParams["projection"] = [projection];
    }

    _url = 'b';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Buckets.fromJson(data));
  }

  /**
   * Updates a bucket. Changes to the bucket will be readable immediately after
   * writing, but configuration changes may take time to propagate. This method
   * supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [bucket] - Name of a bucket.
   *
   * [ifMetagenerationMatch] - Makes the return of the bucket metadata
   * conditional on whether the bucket's current metageneration matches the
   * given value.
   *
   * [ifMetagenerationNotMatch] - Makes the return of the bucket metadata
   * conditional on whether the bucket's current metageneration does not match
   * the given value.
   *
   * [predefinedAcl] - Apply a predefined set of access controls to this bucket.
   * Possible string values are:
   * - "authenticatedRead" : Project team owners get OWNER access, and
   * allAuthenticatedUsers get READER access.
   * - "private" : Project team owners get OWNER access.
   * - "projectPrivate" : Project team members get access according to their
   * roles.
   * - "publicRead" : Project team owners get OWNER access, and allUsers get
   * READER access.
   * - "publicReadWrite" : Project team owners get OWNER access, and allUsers
   * get WRITER access.
   *
   * [predefinedDefaultObjectAcl] - Apply a predefined set of default object
   * access controls to this bucket.
   * Possible string values are:
   * - "authenticatedRead" : Object owner gets OWNER access, and
   * allAuthenticatedUsers get READER access.
   * - "bucketOwnerFullControl" : Object owner gets OWNER access, and project
   * team owners get OWNER access.
   * - "bucketOwnerRead" : Object owner gets OWNER access, and project team
   * owners get READER access.
   * - "private" : Object owner gets OWNER access.
   * - "projectPrivate" : Object owner gets OWNER access, and project team
   * members get access according to their roles.
   * - "publicRead" : Object owner gets OWNER access, and allUsers get READER
   * access.
   *
   * [projection] - Set of properties to return. Defaults to full.
   * Possible string values are:
   * - "full" : Include all properties.
   * - "noAcl" : Omit owner, acl and defaultObjectAcl properties.
   *
   * Completes with a [Bucket].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Bucket> patch(Bucket request, core.String bucket, {core.String ifMetagenerationMatch, core.String ifMetagenerationNotMatch, core.String predefinedAcl, core.String predefinedDefaultObjectAcl, core.String projection}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (ifMetagenerationMatch != null) {
      _queryParams["ifMetagenerationMatch"] = [ifMetagenerationMatch];
    }
    if (ifMetagenerationNotMatch != null) {
      _queryParams["ifMetagenerationNotMatch"] = [ifMetagenerationNotMatch];
    }
    if (predefinedAcl != null) {
      _queryParams["predefinedAcl"] = [predefinedAcl];
    }
    if (predefinedDefaultObjectAcl != null) {
      _queryParams["predefinedDefaultObjectAcl"] = [predefinedDefaultObjectAcl];
    }
    if (projection != null) {
      _queryParams["projection"] = [projection];
    }

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Bucket.fromJson(data));
  }

  /**
   * Updates a bucket. Changes to the bucket will be readable immediately after
   * writing, but configuration changes may take time to propagate.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [bucket] - Name of a bucket.
   *
   * [ifMetagenerationMatch] - Makes the return of the bucket metadata
   * conditional on whether the bucket's current metageneration matches the
   * given value.
   *
   * [ifMetagenerationNotMatch] - Makes the return of the bucket metadata
   * conditional on whether the bucket's current metageneration does not match
   * the given value.
   *
   * [predefinedAcl] - Apply a predefined set of access controls to this bucket.
   * Possible string values are:
   * - "authenticatedRead" : Project team owners get OWNER access, and
   * allAuthenticatedUsers get READER access.
   * - "private" : Project team owners get OWNER access.
   * - "projectPrivate" : Project team members get access according to their
   * roles.
   * - "publicRead" : Project team owners get OWNER access, and allUsers get
   * READER access.
   * - "publicReadWrite" : Project team owners get OWNER access, and allUsers
   * get WRITER access.
   *
   * [predefinedDefaultObjectAcl] - Apply a predefined set of default object
   * access controls to this bucket.
   * Possible string values are:
   * - "authenticatedRead" : Object owner gets OWNER access, and
   * allAuthenticatedUsers get READER access.
   * - "bucketOwnerFullControl" : Object owner gets OWNER access, and project
   * team owners get OWNER access.
   * - "bucketOwnerRead" : Object owner gets OWNER access, and project team
   * owners get READER access.
   * - "private" : Object owner gets OWNER access.
   * - "projectPrivate" : Object owner gets OWNER access, and project team
   * members get access according to their roles.
   * - "publicRead" : Object owner gets OWNER access, and allUsers get READER
   * access.
   *
   * [projection] - Set of properties to return. Defaults to full.
   * Possible string values are:
   * - "full" : Include all properties.
   * - "noAcl" : Omit owner, acl and defaultObjectAcl properties.
   *
   * Completes with a [Bucket].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Bucket> update(Bucket request, core.String bucket, {core.String ifMetagenerationMatch, core.String ifMetagenerationNotMatch, core.String predefinedAcl, core.String predefinedDefaultObjectAcl, core.String projection}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (ifMetagenerationMatch != null) {
      _queryParams["ifMetagenerationMatch"] = [ifMetagenerationMatch];
    }
    if (ifMetagenerationNotMatch != null) {
      _queryParams["ifMetagenerationNotMatch"] = [ifMetagenerationNotMatch];
    }
    if (predefinedAcl != null) {
      _queryParams["predefinedAcl"] = [predefinedAcl];
    }
    if (predefinedDefaultObjectAcl != null) {
      _queryParams["predefinedDefaultObjectAcl"] = [predefinedDefaultObjectAcl];
    }
    if (projection != null) {
      _queryParams["projection"] = [projection];
    }

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Bucket.fromJson(data));
  }

}


class ChannelsResourceApi {
  final commons.ApiRequester _requester;

  ChannelsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Stop watching resources through this channel
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future stop(Channel request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }

    _downloadOptions = null;

    _url = 'channels/stop';

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


class DefaultObjectAccessControlsResourceApi {
  final commons.ApiRequester _requester;

  DefaultObjectAccessControlsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Permanently deletes the default object ACL entry for the specified entity
   * on the specified bucket.
   *
   * Request parameters:
   *
   * [bucket] - Name of a bucket.
   *
   * [entity] - The entity holding the permission. Can be user-userId,
   * user-emailAddress, group-groupId, group-emailAddress, allUsers, or
   * allAuthenticatedUsers.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String bucket, core.String entity) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (entity == null) {
      throw new core.ArgumentError("Parameter entity is required.");
    }

    _downloadOptions = null;

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket') + '/defaultObjectAcl/' + commons.Escaper.ecapeVariable('$entity');

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
   * Returns the default object ACL entry for the specified entity on the
   * specified bucket.
   *
   * Request parameters:
   *
   * [bucket] - Name of a bucket.
   *
   * [entity] - The entity holding the permission. Can be user-userId,
   * user-emailAddress, group-groupId, group-emailAddress, allUsers, or
   * allAuthenticatedUsers.
   *
   * Completes with a [ObjectAccessControl].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ObjectAccessControl> get(core.String bucket, core.String entity) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (entity == null) {
      throw new core.ArgumentError("Parameter entity is required.");
    }

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket') + '/defaultObjectAcl/' + commons.Escaper.ecapeVariable('$entity');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ObjectAccessControl.fromJson(data));
  }

  /**
   * Creates a new default object ACL entry on the specified bucket.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [bucket] - Name of a bucket.
   *
   * Completes with a [ObjectAccessControl].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ObjectAccessControl> insert(ObjectAccessControl request, core.String bucket) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket') + '/defaultObjectAcl';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ObjectAccessControl.fromJson(data));
  }

  /**
   * Retrieves default object ACL entries on the specified bucket.
   *
   * Request parameters:
   *
   * [bucket] - Name of a bucket.
   *
   * [ifMetagenerationMatch] - If present, only return default ACL listing if
   * the bucket's current metageneration matches this value.
   *
   * [ifMetagenerationNotMatch] - If present, only return default ACL listing if
   * the bucket's current metageneration does not match the given value.
   *
   * Completes with a [ObjectAccessControls].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ObjectAccessControls> list(core.String bucket, {core.String ifMetagenerationMatch, core.String ifMetagenerationNotMatch}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (ifMetagenerationMatch != null) {
      _queryParams["ifMetagenerationMatch"] = [ifMetagenerationMatch];
    }
    if (ifMetagenerationNotMatch != null) {
      _queryParams["ifMetagenerationNotMatch"] = [ifMetagenerationNotMatch];
    }

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket') + '/defaultObjectAcl';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ObjectAccessControls.fromJson(data));
  }

  /**
   * Updates a default object ACL entry on the specified bucket. This method
   * supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [bucket] - Name of a bucket.
   *
   * [entity] - The entity holding the permission. Can be user-userId,
   * user-emailAddress, group-groupId, group-emailAddress, allUsers, or
   * allAuthenticatedUsers.
   *
   * Completes with a [ObjectAccessControl].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ObjectAccessControl> patch(ObjectAccessControl request, core.String bucket, core.String entity) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (entity == null) {
      throw new core.ArgumentError("Parameter entity is required.");
    }

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket') + '/defaultObjectAcl/' + commons.Escaper.ecapeVariable('$entity');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ObjectAccessControl.fromJson(data));
  }

  /**
   * Updates a default object ACL entry on the specified bucket.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [bucket] - Name of a bucket.
   *
   * [entity] - The entity holding the permission. Can be user-userId,
   * user-emailAddress, group-groupId, group-emailAddress, allUsers, or
   * allAuthenticatedUsers.
   *
   * Completes with a [ObjectAccessControl].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ObjectAccessControl> update(ObjectAccessControl request, core.String bucket, core.String entity) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (entity == null) {
      throw new core.ArgumentError("Parameter entity is required.");
    }

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket') + '/defaultObjectAcl/' + commons.Escaper.ecapeVariable('$entity');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ObjectAccessControl.fromJson(data));
  }

}


class ObjectAccessControlsResourceApi {
  final commons.ApiRequester _requester;

  ObjectAccessControlsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Permanently deletes the ACL entry for the specified entity on the specified
   * object.
   *
   * Request parameters:
   *
   * [bucket] - Name of a bucket.
   *
   * [object] - Name of the object. For information about how to URL encode
   * object names to be path safe, see Encoding URI Path Parts.
   *
   * [entity] - The entity holding the permission. Can be user-userId,
   * user-emailAddress, group-groupId, group-emailAddress, allUsers, or
   * allAuthenticatedUsers.
   *
   * [generation] - If present, selects a specific revision of this object (as
   * opposed to the latest version, the default).
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String bucket, core.String object, core.String entity, {core.String generation}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (object == null) {
      throw new core.ArgumentError("Parameter object is required.");
    }
    if (entity == null) {
      throw new core.ArgumentError("Parameter entity is required.");
    }
    if (generation != null) {
      _queryParams["generation"] = [generation];
    }

    _downloadOptions = null;

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket') + '/o/' + commons.Escaper.ecapeVariable('$object') + '/acl/' + commons.Escaper.ecapeVariable('$entity');

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
   * Returns the ACL entry for the specified entity on the specified object.
   *
   * Request parameters:
   *
   * [bucket] - Name of a bucket.
   *
   * [object] - Name of the object. For information about how to URL encode
   * object names to be path safe, see Encoding URI Path Parts.
   *
   * [entity] - The entity holding the permission. Can be user-userId,
   * user-emailAddress, group-groupId, group-emailAddress, allUsers, or
   * allAuthenticatedUsers.
   *
   * [generation] - If present, selects a specific revision of this object (as
   * opposed to the latest version, the default).
   *
   * Completes with a [ObjectAccessControl].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ObjectAccessControl> get(core.String bucket, core.String object, core.String entity, {core.String generation}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (object == null) {
      throw new core.ArgumentError("Parameter object is required.");
    }
    if (entity == null) {
      throw new core.ArgumentError("Parameter entity is required.");
    }
    if (generation != null) {
      _queryParams["generation"] = [generation];
    }

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket') + '/o/' + commons.Escaper.ecapeVariable('$object') + '/acl/' + commons.Escaper.ecapeVariable('$entity');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ObjectAccessControl.fromJson(data));
  }

  /**
   * Creates a new ACL entry on the specified object.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [bucket] - Name of a bucket.
   *
   * [object] - Name of the object. For information about how to URL encode
   * object names to be path safe, see Encoding URI Path Parts.
   *
   * [generation] - If present, selects a specific revision of this object (as
   * opposed to the latest version, the default).
   *
   * Completes with a [ObjectAccessControl].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ObjectAccessControl> insert(ObjectAccessControl request, core.String bucket, core.String object, {core.String generation}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (object == null) {
      throw new core.ArgumentError("Parameter object is required.");
    }
    if (generation != null) {
      _queryParams["generation"] = [generation];
    }

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket') + '/o/' + commons.Escaper.ecapeVariable('$object') + '/acl';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ObjectAccessControl.fromJson(data));
  }

  /**
   * Retrieves ACL entries on the specified object.
   *
   * Request parameters:
   *
   * [bucket] - Name of a bucket.
   *
   * [object] - Name of the object. For information about how to URL encode
   * object names to be path safe, see Encoding URI Path Parts.
   *
   * [generation] - If present, selects a specific revision of this object (as
   * opposed to the latest version, the default).
   *
   * Completes with a [ObjectAccessControls].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ObjectAccessControls> list(core.String bucket, core.String object, {core.String generation}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (object == null) {
      throw new core.ArgumentError("Parameter object is required.");
    }
    if (generation != null) {
      _queryParams["generation"] = [generation];
    }

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket') + '/o/' + commons.Escaper.ecapeVariable('$object') + '/acl';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ObjectAccessControls.fromJson(data));
  }

  /**
   * Updates an ACL entry on the specified object. This method supports patch
   * semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [bucket] - Name of a bucket.
   *
   * [object] - Name of the object. For information about how to URL encode
   * object names to be path safe, see Encoding URI Path Parts.
   *
   * [entity] - The entity holding the permission. Can be user-userId,
   * user-emailAddress, group-groupId, group-emailAddress, allUsers, or
   * allAuthenticatedUsers.
   *
   * [generation] - If present, selects a specific revision of this object (as
   * opposed to the latest version, the default).
   *
   * Completes with a [ObjectAccessControl].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ObjectAccessControl> patch(ObjectAccessControl request, core.String bucket, core.String object, core.String entity, {core.String generation}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (object == null) {
      throw new core.ArgumentError("Parameter object is required.");
    }
    if (entity == null) {
      throw new core.ArgumentError("Parameter entity is required.");
    }
    if (generation != null) {
      _queryParams["generation"] = [generation];
    }

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket') + '/o/' + commons.Escaper.ecapeVariable('$object') + '/acl/' + commons.Escaper.ecapeVariable('$entity');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ObjectAccessControl.fromJson(data));
  }

  /**
   * Updates an ACL entry on the specified object.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [bucket] - Name of a bucket.
   *
   * [object] - Name of the object. For information about how to URL encode
   * object names to be path safe, see Encoding URI Path Parts.
   *
   * [entity] - The entity holding the permission. Can be user-userId,
   * user-emailAddress, group-groupId, group-emailAddress, allUsers, or
   * allAuthenticatedUsers.
   *
   * [generation] - If present, selects a specific revision of this object (as
   * opposed to the latest version, the default).
   *
   * Completes with a [ObjectAccessControl].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<ObjectAccessControl> update(ObjectAccessControl request, core.String bucket, core.String object, core.String entity, {core.String generation}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (object == null) {
      throw new core.ArgumentError("Parameter object is required.");
    }
    if (entity == null) {
      throw new core.ArgumentError("Parameter entity is required.");
    }
    if (generation != null) {
      _queryParams["generation"] = [generation];
    }

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket') + '/o/' + commons.Escaper.ecapeVariable('$object') + '/acl/' + commons.Escaper.ecapeVariable('$entity');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new ObjectAccessControl.fromJson(data));
  }

}


class ObjectsResourceApi {
  final commons.ApiRequester _requester;

  ObjectsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Concatenates a list of existing objects into a new object in the same
   * bucket.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [destinationBucket] - Name of the bucket in which to store the new object.
   *
   * [destinationObject] - Name of the new object. For information about how to
   * URL encode object names to be path safe, see Encoding URI Path Parts.
   *
   * [destinationPredefinedAcl] - Apply a predefined set of access controls to
   * the destination object.
   * Possible string values are:
   * - "authenticatedRead" : Object owner gets OWNER access, and
   * allAuthenticatedUsers get READER access.
   * - "bucketOwnerFullControl" : Object owner gets OWNER access, and project
   * team owners get OWNER access.
   * - "bucketOwnerRead" : Object owner gets OWNER access, and project team
   * owners get READER access.
   * - "private" : Object owner gets OWNER access.
   * - "projectPrivate" : Object owner gets OWNER access, and project team
   * members get access according to their roles.
   * - "publicRead" : Object owner gets OWNER access, and allUsers get READER
   * access.
   *
   * [ifGenerationMatch] - Makes the operation conditional on whether the
   * object's current generation matches the given value.
   *
   * [ifMetagenerationMatch] - Makes the operation conditional on whether the
   * object's current metageneration matches the given value.
   *
   * [downloadOptions] - Options for downloading. A download can be either a
   * Metadata (default) or Media download. Partial Media downloads are possible
   * as well.
   *
   * Completes with a
   *
   * - [Object] for Metadata downloads (see [downloadOptions]).
   *
   * - [commons.Media] for Media downloads (see [downloadOptions]).
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future compose(ComposeRequest request, core.String destinationBucket, core.String destinationObject, {core.String destinationPredefinedAcl, core.String ifGenerationMatch, core.String ifMetagenerationMatch, commons.DownloadOptions downloadOptions: commons.DownloadOptions.Metadata}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (destinationBucket == null) {
      throw new core.ArgumentError("Parameter destinationBucket is required.");
    }
    if (destinationObject == null) {
      throw new core.ArgumentError("Parameter destinationObject is required.");
    }
    if (destinationPredefinedAcl != null) {
      _queryParams["destinationPredefinedAcl"] = [destinationPredefinedAcl];
    }
    if (ifGenerationMatch != null) {
      _queryParams["ifGenerationMatch"] = [ifGenerationMatch];
    }
    if (ifMetagenerationMatch != null) {
      _queryParams["ifMetagenerationMatch"] = [ifMetagenerationMatch];
    }

    _downloadOptions = downloadOptions;

    _url = 'b/' + commons.Escaper.ecapeVariable('$destinationBucket') + '/o/' + commons.Escaper.ecapeVariable('$destinationObject') + '/compose';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    if (_downloadOptions == null ||
        _downloadOptions == commons.DownloadOptions.Metadata) {
      return _response.then((data) => new Object.fromJson(data));
    } else {
      return _response;
    }
  }

  /**
   * Copies a source object to a destination object. Optionally overrides
   * metadata.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [sourceBucket] - Name of the bucket in which to find the source object.
   *
   * [sourceObject] - Name of the source object. For information about how to
   * URL encode object names to be path safe, see Encoding URI Path Parts.
   *
   * [destinationBucket] - Name of the bucket in which to store the new object.
   * Overrides the provided object metadata's bucket value, if any.For
   * information about how to URL encode object names to be path safe, see
   * Encoding URI Path Parts.
   *
   * [destinationObject] - Name of the new object. Required when the object
   * metadata is not otherwise provided. Overrides the object metadata's name
   * value, if any.
   *
   * [destinationPredefinedAcl] - Apply a predefined set of access controls to
   * the destination object.
   * Possible string values are:
   * - "authenticatedRead" : Object owner gets OWNER access, and
   * allAuthenticatedUsers get READER access.
   * - "bucketOwnerFullControl" : Object owner gets OWNER access, and project
   * team owners get OWNER access.
   * - "bucketOwnerRead" : Object owner gets OWNER access, and project team
   * owners get READER access.
   * - "private" : Object owner gets OWNER access.
   * - "projectPrivate" : Object owner gets OWNER access, and project team
   * members get access according to their roles.
   * - "publicRead" : Object owner gets OWNER access, and allUsers get READER
   * access.
   *
   * [ifGenerationMatch] - Makes the operation conditional on whether the
   * destination object's current generation matches the given value.
   *
   * [ifGenerationNotMatch] - Makes the operation conditional on whether the
   * destination object's current generation does not match the given value.
   *
   * [ifMetagenerationMatch] - Makes the operation conditional on whether the
   * destination object's current metageneration matches the given value.
   *
   * [ifMetagenerationNotMatch] - Makes the operation conditional on whether the
   * destination object's current metageneration does not match the given value.
   *
   * [ifSourceGenerationMatch] - Makes the operation conditional on whether the
   * source object's generation matches the given value.
   *
   * [ifSourceGenerationNotMatch] - Makes the operation conditional on whether
   * the source object's generation does not match the given value.
   *
   * [ifSourceMetagenerationMatch] - Makes the operation conditional on whether
   * the source object's current metageneration matches the given value.
   *
   * [ifSourceMetagenerationNotMatch] - Makes the operation conditional on
   * whether the source object's current metageneration does not match the given
   * value.
   *
   * [projection] - Set of properties to return. Defaults to noAcl, unless the
   * object resource specifies the acl property, when it defaults to full.
   * Possible string values are:
   * - "full" : Include all properties.
   * - "noAcl" : Omit the owner, acl property.
   *
   * [sourceGeneration] - If present, selects a specific revision of the source
   * object (as opposed to the latest version, the default).
   *
   * [downloadOptions] - Options for downloading. A download can be either a
   * Metadata (default) or Media download. Partial Media downloads are possible
   * as well.
   *
   * Completes with a
   *
   * - [Object] for Metadata downloads (see [downloadOptions]).
   *
   * - [commons.Media] for Media downloads (see [downloadOptions]).
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future copy(Object request, core.String sourceBucket, core.String sourceObject, core.String destinationBucket, core.String destinationObject, {core.String destinationPredefinedAcl, core.String ifGenerationMatch, core.String ifGenerationNotMatch, core.String ifMetagenerationMatch, core.String ifMetagenerationNotMatch, core.String ifSourceGenerationMatch, core.String ifSourceGenerationNotMatch, core.String ifSourceMetagenerationMatch, core.String ifSourceMetagenerationNotMatch, core.String projection, core.String sourceGeneration, commons.DownloadOptions downloadOptions: commons.DownloadOptions.Metadata}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (sourceBucket == null) {
      throw new core.ArgumentError("Parameter sourceBucket is required.");
    }
    if (sourceObject == null) {
      throw new core.ArgumentError("Parameter sourceObject is required.");
    }
    if (destinationBucket == null) {
      throw new core.ArgumentError("Parameter destinationBucket is required.");
    }
    if (destinationObject == null) {
      throw new core.ArgumentError("Parameter destinationObject is required.");
    }
    if (destinationPredefinedAcl != null) {
      _queryParams["destinationPredefinedAcl"] = [destinationPredefinedAcl];
    }
    if (ifGenerationMatch != null) {
      _queryParams["ifGenerationMatch"] = [ifGenerationMatch];
    }
    if (ifGenerationNotMatch != null) {
      _queryParams["ifGenerationNotMatch"] = [ifGenerationNotMatch];
    }
    if (ifMetagenerationMatch != null) {
      _queryParams["ifMetagenerationMatch"] = [ifMetagenerationMatch];
    }
    if (ifMetagenerationNotMatch != null) {
      _queryParams["ifMetagenerationNotMatch"] = [ifMetagenerationNotMatch];
    }
    if (ifSourceGenerationMatch != null) {
      _queryParams["ifSourceGenerationMatch"] = [ifSourceGenerationMatch];
    }
    if (ifSourceGenerationNotMatch != null) {
      _queryParams["ifSourceGenerationNotMatch"] = [ifSourceGenerationNotMatch];
    }
    if (ifSourceMetagenerationMatch != null) {
      _queryParams["ifSourceMetagenerationMatch"] = [ifSourceMetagenerationMatch];
    }
    if (ifSourceMetagenerationNotMatch != null) {
      _queryParams["ifSourceMetagenerationNotMatch"] = [ifSourceMetagenerationNotMatch];
    }
    if (projection != null) {
      _queryParams["projection"] = [projection];
    }
    if (sourceGeneration != null) {
      _queryParams["sourceGeneration"] = [sourceGeneration];
    }

    _downloadOptions = downloadOptions;

    _url = 'b/' + commons.Escaper.ecapeVariable('$sourceBucket') + '/o/' + commons.Escaper.ecapeVariable('$sourceObject') + '/copyTo/b/' + commons.Escaper.ecapeVariable('$destinationBucket') + '/o/' + commons.Escaper.ecapeVariable('$destinationObject');

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    if (_downloadOptions == null ||
        _downloadOptions == commons.DownloadOptions.Metadata) {
      return _response.then((data) => new Object.fromJson(data));
    } else {
      return _response;
    }
  }

  /**
   * Deletes an object and its metadata. Deletions are permanent if versioning
   * is not enabled for the bucket, or if the generation parameter is used.
   *
   * Request parameters:
   *
   * [bucket] - Name of the bucket in which the object resides.
   *
   * [object] - Name of the object. For information about how to URL encode
   * object names to be path safe, see Encoding URI Path Parts.
   *
   * [generation] - If present, permanently deletes a specific revision of this
   * object (as opposed to the latest version, the default).
   *
   * [ifGenerationMatch] - Makes the operation conditional on whether the
   * object's current generation matches the given value.
   *
   * [ifGenerationNotMatch] - Makes the operation conditional on whether the
   * object's current generation does not match the given value.
   *
   * [ifMetagenerationMatch] - Makes the operation conditional on whether the
   * object's current metageneration matches the given value.
   *
   * [ifMetagenerationNotMatch] - Makes the operation conditional on whether the
   * object's current metageneration does not match the given value.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future delete(core.String bucket, core.String object, {core.String generation, core.String ifGenerationMatch, core.String ifGenerationNotMatch, core.String ifMetagenerationMatch, core.String ifMetagenerationNotMatch}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (object == null) {
      throw new core.ArgumentError("Parameter object is required.");
    }
    if (generation != null) {
      _queryParams["generation"] = [generation];
    }
    if (ifGenerationMatch != null) {
      _queryParams["ifGenerationMatch"] = [ifGenerationMatch];
    }
    if (ifGenerationNotMatch != null) {
      _queryParams["ifGenerationNotMatch"] = [ifGenerationNotMatch];
    }
    if (ifMetagenerationMatch != null) {
      _queryParams["ifMetagenerationMatch"] = [ifMetagenerationMatch];
    }
    if (ifMetagenerationNotMatch != null) {
      _queryParams["ifMetagenerationNotMatch"] = [ifMetagenerationNotMatch];
    }

    _downloadOptions = null;

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket') + '/o/' + commons.Escaper.ecapeVariable('$object');

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
   * Retrieves an object or its metadata.
   *
   * Request parameters:
   *
   * [bucket] - Name of the bucket in which the object resides.
   *
   * [object] - Name of the object. For information about how to URL encode
   * object names to be path safe, see Encoding URI Path Parts.
   *
   * [generation] - If present, selects a specific revision of this object (as
   * opposed to the latest version, the default).
   *
   * [ifGenerationMatch] - Makes the operation conditional on whether the
   * object's generation matches the given value.
   *
   * [ifGenerationNotMatch] - Makes the operation conditional on whether the
   * object's generation does not match the given value.
   *
   * [ifMetagenerationMatch] - Makes the operation conditional on whether the
   * object's current metageneration matches the given value.
   *
   * [ifMetagenerationNotMatch] - Makes the operation conditional on whether the
   * object's current metageneration does not match the given value.
   *
   * [projection] - Set of properties to return. Defaults to noAcl.
   * Possible string values are:
   * - "full" : Include all properties.
   * - "noAcl" : Omit the owner, acl property.
   *
   * [downloadOptions] - Options for downloading. A download can be either a
   * Metadata (default) or Media download. Partial Media downloads are possible
   * as well.
   *
   * Completes with a
   *
   * - [Object] for Metadata downloads (see [downloadOptions]).
   *
   * - [commons.Media] for Media downloads (see [downloadOptions]).
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future get(core.String bucket, core.String object, {core.String generation, core.String ifGenerationMatch, core.String ifGenerationNotMatch, core.String ifMetagenerationMatch, core.String ifMetagenerationNotMatch, core.String projection, commons.DownloadOptions downloadOptions: commons.DownloadOptions.Metadata}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (object == null) {
      throw new core.ArgumentError("Parameter object is required.");
    }
    if (generation != null) {
      _queryParams["generation"] = [generation];
    }
    if (ifGenerationMatch != null) {
      _queryParams["ifGenerationMatch"] = [ifGenerationMatch];
    }
    if (ifGenerationNotMatch != null) {
      _queryParams["ifGenerationNotMatch"] = [ifGenerationNotMatch];
    }
    if (ifMetagenerationMatch != null) {
      _queryParams["ifMetagenerationMatch"] = [ifMetagenerationMatch];
    }
    if (ifMetagenerationNotMatch != null) {
      _queryParams["ifMetagenerationNotMatch"] = [ifMetagenerationNotMatch];
    }
    if (projection != null) {
      _queryParams["projection"] = [projection];
    }

    _downloadOptions = downloadOptions;

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket') + '/o/' + commons.Escaper.ecapeVariable('$object');

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    if (_downloadOptions == null ||
        _downloadOptions == commons.DownloadOptions.Metadata) {
      return _response.then((data) => new Object.fromJson(data));
    } else {
      return _response;
    }
  }

  /**
   * Stores a new object and metadata.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [bucket] - Name of the bucket in which to store the new object. Overrides
   * the provided object metadata's bucket value, if any.
   *
   * [contentEncoding] - If set, sets the contentEncoding property of the final
   * object to this value. Setting this parameter is equivalent to setting the
   * contentEncoding metadata property. This can be useful when uploading an
   * object with uploadType=media to indicate the encoding of the content being
   * uploaded.
   *
   * [ifGenerationMatch] - Makes the operation conditional on whether the
   * object's current generation matches the given value.
   *
   * [ifGenerationNotMatch] - Makes the operation conditional on whether the
   * object's current generation does not match the given value.
   *
   * [ifMetagenerationMatch] - Makes the operation conditional on whether the
   * object's current metageneration matches the given value.
   *
   * [ifMetagenerationNotMatch] - Makes the operation conditional on whether the
   * object's current metageneration does not match the given value.
   *
   * [name] - Name of the object. Required when the object metadata is not
   * otherwise provided. Overrides the object metadata's name value, if any. For
   * information about how to URL encode object names to be path safe, see
   * Encoding URI Path Parts.
   *
   * [predefinedAcl] - Apply a predefined set of access controls to this object.
   * Possible string values are:
   * - "authenticatedRead" : Object owner gets OWNER access, and
   * allAuthenticatedUsers get READER access.
   * - "bucketOwnerFullControl" : Object owner gets OWNER access, and project
   * team owners get OWNER access.
   * - "bucketOwnerRead" : Object owner gets OWNER access, and project team
   * owners get READER access.
   * - "private" : Object owner gets OWNER access.
   * - "projectPrivate" : Object owner gets OWNER access, and project team
   * members get access according to their roles.
   * - "publicRead" : Object owner gets OWNER access, and allUsers get READER
   * access.
   *
   * [projection] - Set of properties to return. Defaults to noAcl, unless the
   * object resource specifies the acl property, when it defaults to full.
   * Possible string values are:
   * - "full" : Include all properties.
   * - "noAcl" : Omit the owner, acl property.
   *
   * [uploadMedia] - The media to upload.
   *
   * [uploadOptions] - Options for the media upload. Streaming Media without the
   * length being known ahead of time is only supported via resumable uploads.
   *
   * [downloadOptions] - Options for downloading. A download can be either a
   * Metadata (default) or Media download. Partial Media downloads are possible
   * as well.
   *
   * Completes with a
   *
   * - [Object] for Metadata downloads (see [downloadOptions]).
   *
   * - [commons.Media] for Media downloads (see [downloadOptions]).
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future insert(Object request, core.String bucket, {core.String contentEncoding, core.String ifGenerationMatch, core.String ifGenerationNotMatch, core.String ifMetagenerationMatch, core.String ifMetagenerationNotMatch, core.String name, core.String predefinedAcl, core.String projection, commons.UploadOptions uploadOptions : commons.UploadOptions.Default, commons.Media uploadMedia, commons.DownloadOptions downloadOptions: commons.DownloadOptions.Metadata}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (contentEncoding != null) {
      _queryParams["contentEncoding"] = [contentEncoding];
    }
    if (ifGenerationMatch != null) {
      _queryParams["ifGenerationMatch"] = [ifGenerationMatch];
    }
    if (ifGenerationNotMatch != null) {
      _queryParams["ifGenerationNotMatch"] = [ifGenerationNotMatch];
    }
    if (ifMetagenerationMatch != null) {
      _queryParams["ifMetagenerationMatch"] = [ifMetagenerationMatch];
    }
    if (ifMetagenerationNotMatch != null) {
      _queryParams["ifMetagenerationNotMatch"] = [ifMetagenerationNotMatch];
    }
    if (name != null) {
      _queryParams["name"] = [name];
    }
    if (predefinedAcl != null) {
      _queryParams["predefinedAcl"] = [predefinedAcl];
    }
    if (projection != null) {
      _queryParams["projection"] = [projection];
    }


    _uploadMedia =  uploadMedia;
    _uploadOptions =  uploadOptions;
    _downloadOptions = downloadOptions;

    if (_uploadMedia == null) {
      _url = 'b/' + commons.Escaper.ecapeVariable('$bucket') + '/o';
    } else if (_uploadOptions is commons.ResumableUploadOptions) {
      _url = '/resumable/upload/storage/v1/b/' + commons.Escaper.ecapeVariable('$bucket') + '/o';
    } else {
      _url = '/upload/storage/v1/b/' + commons.Escaper.ecapeVariable('$bucket') + '/o';
    }


    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    if (_downloadOptions == null ||
        _downloadOptions == commons.DownloadOptions.Metadata) {
      return _response.then((data) => new Object.fromJson(data));
    } else {
      return _response;
    }
  }

  /**
   * Retrieves a list of objects matching the criteria.
   *
   * Request parameters:
   *
   * [bucket] - Name of the bucket in which to look for objects.
   *
   * [delimiter] - Returns results in a directory-like mode. items will contain
   * only objects whose names, aside from the prefix, do not contain delimiter.
   * Objects whose names, aside from the prefix, contain delimiter will have
   * their name, truncated after the delimiter, returned in prefixes. Duplicate
   * prefixes are omitted.
   *
   * [maxResults] - Maximum number of items plus prefixes to return in a single
   * page of responses. As duplicate prefixes are omitted, fewer total results
   * may be returned than requested. The service will use this parameter or
   * 1,000 items, whichever is smaller.
   *
   * [pageToken] - A previously-returned page token representing part of the
   * larger set of results to view.
   *
   * [prefix] - Filter results to objects whose names begin with this prefix.
   *
   * [projection] - Set of properties to return. Defaults to noAcl.
   * Possible string values are:
   * - "full" : Include all properties.
   * - "noAcl" : Omit the owner, acl property.
   *
   * [versions] - If true, lists all versions of an object as distinct results.
   * The default is false. For more information, see Object Versioning.
   *
   * Completes with a [Objects].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Objects> list(core.String bucket, {core.String delimiter, core.int maxResults, core.String pageToken, core.String prefix, core.String projection, core.bool versions}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (delimiter != null) {
      _queryParams["delimiter"] = [delimiter];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (prefix != null) {
      _queryParams["prefix"] = [prefix];
    }
    if (projection != null) {
      _queryParams["projection"] = [projection];
    }
    if (versions != null) {
      _queryParams["versions"] = ["${versions}"];
    }

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket') + '/o';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Objects.fromJson(data));
  }

  /**
   * Updates an object's metadata. This method supports patch semantics.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [bucket] - Name of the bucket in which the object resides.
   *
   * [object] - Name of the object. For information about how to URL encode
   * object names to be path safe, see Encoding URI Path Parts.
   *
   * [generation] - If present, selects a specific revision of this object (as
   * opposed to the latest version, the default).
   *
   * [ifGenerationMatch] - Makes the operation conditional on whether the
   * object's current generation matches the given value.
   *
   * [ifGenerationNotMatch] - Makes the operation conditional on whether the
   * object's current generation does not match the given value.
   *
   * [ifMetagenerationMatch] - Makes the operation conditional on whether the
   * object's current metageneration matches the given value.
   *
   * [ifMetagenerationNotMatch] - Makes the operation conditional on whether the
   * object's current metageneration does not match the given value.
   *
   * [predefinedAcl] - Apply a predefined set of access controls to this object.
   * Possible string values are:
   * - "authenticatedRead" : Object owner gets OWNER access, and
   * allAuthenticatedUsers get READER access.
   * - "bucketOwnerFullControl" : Object owner gets OWNER access, and project
   * team owners get OWNER access.
   * - "bucketOwnerRead" : Object owner gets OWNER access, and project team
   * owners get READER access.
   * - "private" : Object owner gets OWNER access.
   * - "projectPrivate" : Object owner gets OWNER access, and project team
   * members get access according to their roles.
   * - "publicRead" : Object owner gets OWNER access, and allUsers get READER
   * access.
   *
   * [projection] - Set of properties to return. Defaults to full.
   * Possible string values are:
   * - "full" : Include all properties.
   * - "noAcl" : Omit the owner, acl property.
   *
   * Completes with a [Object].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Object> patch(Object request, core.String bucket, core.String object, {core.String generation, core.String ifGenerationMatch, core.String ifGenerationNotMatch, core.String ifMetagenerationMatch, core.String ifMetagenerationNotMatch, core.String predefinedAcl, core.String projection}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (object == null) {
      throw new core.ArgumentError("Parameter object is required.");
    }
    if (generation != null) {
      _queryParams["generation"] = [generation];
    }
    if (ifGenerationMatch != null) {
      _queryParams["ifGenerationMatch"] = [ifGenerationMatch];
    }
    if (ifGenerationNotMatch != null) {
      _queryParams["ifGenerationNotMatch"] = [ifGenerationNotMatch];
    }
    if (ifMetagenerationMatch != null) {
      _queryParams["ifMetagenerationMatch"] = [ifMetagenerationMatch];
    }
    if (ifMetagenerationNotMatch != null) {
      _queryParams["ifMetagenerationNotMatch"] = [ifMetagenerationNotMatch];
    }
    if (predefinedAcl != null) {
      _queryParams["predefinedAcl"] = [predefinedAcl];
    }
    if (projection != null) {
      _queryParams["projection"] = [projection];
    }

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket') + '/o/' + commons.Escaper.ecapeVariable('$object');

    var _response = _requester.request(_url,
                                       "PATCH",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Object.fromJson(data));
  }

  /**
   * Rewrites a source object to a destination object. Optionally overrides
   * metadata.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [sourceBucket] - Name of the bucket in which to find the source object.
   *
   * [sourceObject] - Name of the source object. For information about how to
   * URL encode object names to be path safe, see Encoding URI Path Parts.
   *
   * [destinationBucket] - Name of the bucket in which to store the new object.
   * Overrides the provided object metadata's bucket value, if any.
   *
   * [destinationObject] - Name of the new object. Required when the object
   * metadata is not otherwise provided. Overrides the object metadata's name
   * value, if any. For information about how to URL encode object names to be
   * path safe, see Encoding URI Path Parts.
   *
   * [destinationPredefinedAcl] - Apply a predefined set of access controls to
   * the destination object.
   * Possible string values are:
   * - "authenticatedRead" : Object owner gets OWNER access, and
   * allAuthenticatedUsers get READER access.
   * - "bucketOwnerFullControl" : Object owner gets OWNER access, and project
   * team owners get OWNER access.
   * - "bucketOwnerRead" : Object owner gets OWNER access, and project team
   * owners get READER access.
   * - "private" : Object owner gets OWNER access.
   * - "projectPrivate" : Object owner gets OWNER access, and project team
   * members get access according to their roles.
   * - "publicRead" : Object owner gets OWNER access, and allUsers get READER
   * access.
   *
   * [ifGenerationMatch] - Makes the operation conditional on whether the
   * destination object's current generation matches the given value.
   *
   * [ifGenerationNotMatch] - Makes the operation conditional on whether the
   * destination object's current generation does not match the given value.
   *
   * [ifMetagenerationMatch] - Makes the operation conditional on whether the
   * destination object's current metageneration matches the given value.
   *
   * [ifMetagenerationNotMatch] - Makes the operation conditional on whether the
   * destination object's current metageneration does not match the given value.
   *
   * [ifSourceGenerationMatch] - Makes the operation conditional on whether the
   * source object's generation matches the given value.
   *
   * [ifSourceGenerationNotMatch] - Makes the operation conditional on whether
   * the source object's generation does not match the given value.
   *
   * [ifSourceMetagenerationMatch] - Makes the operation conditional on whether
   * the source object's current metageneration matches the given value.
   *
   * [ifSourceMetagenerationNotMatch] - Makes the operation conditional on
   * whether the source object's current metageneration does not match the given
   * value.
   *
   * [maxBytesRewrittenPerCall] - The maximum number of bytes that will be
   * rewritten per rewrite request. Most callers shouldn't need to specify this
   * parameter - it is primarily in place to support testing. If specified the
   * value must be an integral multiple of 1 MiB (1048576). Also, this only
   * applies to requests where the source and destination span locations and/or
   * storage classes. Finally, this value must not change across rewrite calls
   * else you'll get an error that the rewriteToken is invalid.
   *
   * [projection] - Set of properties to return. Defaults to noAcl, unless the
   * object resource specifies the acl property, when it defaults to full.
   * Possible string values are:
   * - "full" : Include all properties.
   * - "noAcl" : Omit the owner, acl property.
   *
   * [rewriteToken] - Include this field (from the previous rewrite response) on
   * each rewrite request after the first one, until the rewrite response 'done'
   * flag is true. Calls that provide a rewriteToken can omit all other request
   * fields, but if included those fields must match the values provided in the
   * first rewrite request.
   *
   * [sourceGeneration] - If present, selects a specific revision of the source
   * object (as opposed to the latest version, the default).
   *
   * Completes with a [RewriteResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RewriteResponse> rewrite(Object request, core.String sourceBucket, core.String sourceObject, core.String destinationBucket, core.String destinationObject, {core.String destinationPredefinedAcl, core.String ifGenerationMatch, core.String ifGenerationNotMatch, core.String ifMetagenerationMatch, core.String ifMetagenerationNotMatch, core.String ifSourceGenerationMatch, core.String ifSourceGenerationNotMatch, core.String ifSourceMetagenerationMatch, core.String ifSourceMetagenerationNotMatch, core.String maxBytesRewrittenPerCall, core.String projection, core.String rewriteToken, core.String sourceGeneration}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (sourceBucket == null) {
      throw new core.ArgumentError("Parameter sourceBucket is required.");
    }
    if (sourceObject == null) {
      throw new core.ArgumentError("Parameter sourceObject is required.");
    }
    if (destinationBucket == null) {
      throw new core.ArgumentError("Parameter destinationBucket is required.");
    }
    if (destinationObject == null) {
      throw new core.ArgumentError("Parameter destinationObject is required.");
    }
    if (destinationPredefinedAcl != null) {
      _queryParams["destinationPredefinedAcl"] = [destinationPredefinedAcl];
    }
    if (ifGenerationMatch != null) {
      _queryParams["ifGenerationMatch"] = [ifGenerationMatch];
    }
    if (ifGenerationNotMatch != null) {
      _queryParams["ifGenerationNotMatch"] = [ifGenerationNotMatch];
    }
    if (ifMetagenerationMatch != null) {
      _queryParams["ifMetagenerationMatch"] = [ifMetagenerationMatch];
    }
    if (ifMetagenerationNotMatch != null) {
      _queryParams["ifMetagenerationNotMatch"] = [ifMetagenerationNotMatch];
    }
    if (ifSourceGenerationMatch != null) {
      _queryParams["ifSourceGenerationMatch"] = [ifSourceGenerationMatch];
    }
    if (ifSourceGenerationNotMatch != null) {
      _queryParams["ifSourceGenerationNotMatch"] = [ifSourceGenerationNotMatch];
    }
    if (ifSourceMetagenerationMatch != null) {
      _queryParams["ifSourceMetagenerationMatch"] = [ifSourceMetagenerationMatch];
    }
    if (ifSourceMetagenerationNotMatch != null) {
      _queryParams["ifSourceMetagenerationNotMatch"] = [ifSourceMetagenerationNotMatch];
    }
    if (maxBytesRewrittenPerCall != null) {
      _queryParams["maxBytesRewrittenPerCall"] = [maxBytesRewrittenPerCall];
    }
    if (projection != null) {
      _queryParams["projection"] = [projection];
    }
    if (rewriteToken != null) {
      _queryParams["rewriteToken"] = [rewriteToken];
    }
    if (sourceGeneration != null) {
      _queryParams["sourceGeneration"] = [sourceGeneration];
    }

    _url = 'b/' + commons.Escaper.ecapeVariable('$sourceBucket') + '/o/' + commons.Escaper.ecapeVariable('$sourceObject') + '/rewriteTo/b/' + commons.Escaper.ecapeVariable('$destinationBucket') + '/o/' + commons.Escaper.ecapeVariable('$destinationObject');

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RewriteResponse.fromJson(data));
  }

  /**
   * Updates an object's metadata.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [bucket] - Name of the bucket in which the object resides.
   *
   * [object] - Name of the object. For information about how to URL encode
   * object names to be path safe, see Encoding URI Path Parts.
   *
   * [generation] - If present, selects a specific revision of this object (as
   * opposed to the latest version, the default).
   *
   * [ifGenerationMatch] - Makes the operation conditional on whether the
   * object's current generation matches the given value.
   *
   * [ifGenerationNotMatch] - Makes the operation conditional on whether the
   * object's current generation does not match the given value.
   *
   * [ifMetagenerationMatch] - Makes the operation conditional on whether the
   * object's current metageneration matches the given value.
   *
   * [ifMetagenerationNotMatch] - Makes the operation conditional on whether the
   * object's current metageneration does not match the given value.
   *
   * [predefinedAcl] - Apply a predefined set of access controls to this object.
   * Possible string values are:
   * - "authenticatedRead" : Object owner gets OWNER access, and
   * allAuthenticatedUsers get READER access.
   * - "bucketOwnerFullControl" : Object owner gets OWNER access, and project
   * team owners get OWNER access.
   * - "bucketOwnerRead" : Object owner gets OWNER access, and project team
   * owners get READER access.
   * - "private" : Object owner gets OWNER access.
   * - "projectPrivate" : Object owner gets OWNER access, and project team
   * members get access according to their roles.
   * - "publicRead" : Object owner gets OWNER access, and allUsers get READER
   * access.
   *
   * [projection] - Set of properties to return. Defaults to full.
   * Possible string values are:
   * - "full" : Include all properties.
   * - "noAcl" : Omit the owner, acl property.
   *
   * [downloadOptions] - Options for downloading. A download can be either a
   * Metadata (default) or Media download. Partial Media downloads are possible
   * as well.
   *
   * Completes with a
   *
   * - [Object] for Metadata downloads (see [downloadOptions]).
   *
   * - [commons.Media] for Media downloads (see [downloadOptions]).
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future update(Object request, core.String bucket, core.String object, {core.String generation, core.String ifGenerationMatch, core.String ifGenerationNotMatch, core.String ifMetagenerationMatch, core.String ifMetagenerationNotMatch, core.String predefinedAcl, core.String projection, commons.DownloadOptions downloadOptions: commons.DownloadOptions.Metadata}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (object == null) {
      throw new core.ArgumentError("Parameter object is required.");
    }
    if (generation != null) {
      _queryParams["generation"] = [generation];
    }
    if (ifGenerationMatch != null) {
      _queryParams["ifGenerationMatch"] = [ifGenerationMatch];
    }
    if (ifGenerationNotMatch != null) {
      _queryParams["ifGenerationNotMatch"] = [ifGenerationNotMatch];
    }
    if (ifMetagenerationMatch != null) {
      _queryParams["ifMetagenerationMatch"] = [ifMetagenerationMatch];
    }
    if (ifMetagenerationNotMatch != null) {
      _queryParams["ifMetagenerationNotMatch"] = [ifMetagenerationNotMatch];
    }
    if (predefinedAcl != null) {
      _queryParams["predefinedAcl"] = [predefinedAcl];
    }
    if (projection != null) {
      _queryParams["projection"] = [projection];
    }

    _downloadOptions = downloadOptions;

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket') + '/o/' + commons.Escaper.ecapeVariable('$object');

    var _response = _requester.request(_url,
                                       "PUT",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    if (_downloadOptions == null ||
        _downloadOptions == commons.DownloadOptions.Metadata) {
      return _response.then((data) => new Object.fromJson(data));
    } else {
      return _response;
    }
  }

  /**
   * Watch for changes on all objects in a bucket.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [bucket] - Name of the bucket in which to look for objects.
   *
   * [delimiter] - Returns results in a directory-like mode. items will contain
   * only objects whose names, aside from the prefix, do not contain delimiter.
   * Objects whose names, aside from the prefix, contain delimiter will have
   * their name, truncated after the delimiter, returned in prefixes. Duplicate
   * prefixes are omitted.
   *
   * [maxResults] - Maximum number of items plus prefixes to return in a single
   * page of responses. As duplicate prefixes are omitted, fewer total results
   * may be returned than requested. The service will use this parameter or
   * 1,000 items, whichever is smaller.
   *
   * [pageToken] - A previously-returned page token representing part of the
   * larger set of results to view.
   *
   * [prefix] - Filter results to objects whose names begin with this prefix.
   *
   * [projection] - Set of properties to return. Defaults to noAcl.
   * Possible string values are:
   * - "full" : Include all properties.
   * - "noAcl" : Omit the owner, acl property.
   *
   * [versions] - If true, lists all versions of an object as distinct results.
   * The default is false. For more information, see Object Versioning.
   *
   * Completes with a [Channel].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Channel> watchAll(Channel request, core.String bucket, {core.String delimiter, core.int maxResults, core.String pageToken, core.String prefix, core.String projection, core.bool versions}) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (bucket == null) {
      throw new core.ArgumentError("Parameter bucket is required.");
    }
    if (delimiter != null) {
      _queryParams["delimiter"] = [delimiter];
    }
    if (maxResults != null) {
      _queryParams["maxResults"] = ["${maxResults}"];
    }
    if (pageToken != null) {
      _queryParams["pageToken"] = [pageToken];
    }
    if (prefix != null) {
      _queryParams["prefix"] = [prefix];
    }
    if (projection != null) {
      _queryParams["projection"] = [projection];
    }
    if (versions != null) {
      _queryParams["versions"] = ["${versions}"];
    }

    _url = 'b/' + commons.Escaper.ecapeVariable('$bucket') + '/o/watch';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new Channel.fromJson(data));
  }

}



class BucketCors {
  /**
   * The value, in seconds, to return in the  Access-Control-Max-Age header used
   * in preflight responses.
   */
  core.int maxAgeSeconds;
  /**
   * The list of HTTP methods on which to include CORS response headers, (GET,
   * OPTIONS, POST, etc) Note: "*" is permitted in the list of methods, and
   * means "any method".
   */
  core.List<core.String> method;
  /**
   * The list of Origins eligible to receive CORS response headers. Note: "*" is
   * permitted in the list of origins, and means "any Origin".
   */
  core.List<core.String> origin;
  /**
   * The list of HTTP headers other than the simple response headers to give
   * permission for the user-agent to share across domains.
   */
  core.List<core.String> responseHeader;

  BucketCors();

  BucketCors.fromJson(core.Map _json) {
    if (_json.containsKey("maxAgeSeconds")) {
      maxAgeSeconds = _json["maxAgeSeconds"];
    }
    if (_json.containsKey("method")) {
      method = _json["method"];
    }
    if (_json.containsKey("origin")) {
      origin = _json["origin"];
    }
    if (_json.containsKey("responseHeader")) {
      responseHeader = _json["responseHeader"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (maxAgeSeconds != null) {
      _json["maxAgeSeconds"] = maxAgeSeconds;
    }
    if (method != null) {
      _json["method"] = method;
    }
    if (origin != null) {
      _json["origin"] = origin;
    }
    if (responseHeader != null) {
      _json["responseHeader"] = responseHeader;
    }
    return _json;
  }
}

/** The action to take. */
class BucketLifecycleRuleAction {
  /**
   * Target storage class. Required iff the type of the action is
   * SetStorageClass.
   */
  core.String storageClass;
  /**
   * Type of the action. Currently, only Delete and SetStorageClass are
   * supported.
   */
  core.String type;

  BucketLifecycleRuleAction();

  BucketLifecycleRuleAction.fromJson(core.Map _json) {
    if (_json.containsKey("storageClass")) {
      storageClass = _json["storageClass"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (storageClass != null) {
      _json["storageClass"] = storageClass;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** The condition(s) under which the action will be taken. */
class BucketLifecycleRuleCondition {
  /**
   * Age of an object (in days). This condition is satisfied when an object
   * reaches the specified age.
   */
  core.int age;
  /**
   * A date in RFC 3339 format with only the date part (for instance,
   * "2013-01-15"). This condition is satisfied when an object is created before
   * midnight of the specified date in UTC.
   */
  core.DateTime createdBefore;
  /**
   * Relevant only for versioned objects. If the value is true, this condition
   * matches live objects; if the value is false, it matches archived objects.
   */
  core.bool isLive;
  /**
   * Objects having any of the storage classes specified by this condition will
   * be matched. Values include MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE,
   * STANDARD, and DURABLE_REDUCED_AVAILABILITY.
   */
  core.List<core.String> matchesStorageClass;
  /**
   * Relevant only for versioned objects. If the value is N, this condition is
   * satisfied when there are at least N versions (including the live version)
   * newer than this version of the object.
   */
  core.int numNewerVersions;

  BucketLifecycleRuleCondition();

  BucketLifecycleRuleCondition.fromJson(core.Map _json) {
    if (_json.containsKey("age")) {
      age = _json["age"];
    }
    if (_json.containsKey("createdBefore")) {
      createdBefore = core.DateTime.parse(_json["createdBefore"]);
    }
    if (_json.containsKey("isLive")) {
      isLive = _json["isLive"];
    }
    if (_json.containsKey("matchesStorageClass")) {
      matchesStorageClass = _json["matchesStorageClass"];
    }
    if (_json.containsKey("numNewerVersions")) {
      numNewerVersions = _json["numNewerVersions"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (age != null) {
      _json["age"] = age;
    }
    if (createdBefore != null) {
      _json["createdBefore"] = "${(createdBefore).year.toString().padLeft(4, '0')}-${(createdBefore).month.toString().padLeft(2, '0')}-${(createdBefore).day.toString().padLeft(2, '0')}";
    }
    if (isLive != null) {
      _json["isLive"] = isLive;
    }
    if (matchesStorageClass != null) {
      _json["matchesStorageClass"] = matchesStorageClass;
    }
    if (numNewerVersions != null) {
      _json["numNewerVersions"] = numNewerVersions;
    }
    return _json;
  }
}

class BucketLifecycleRule {
  /** The action to take. */
  BucketLifecycleRuleAction action;
  /** The condition(s) under which the action will be taken. */
  BucketLifecycleRuleCondition condition;

  BucketLifecycleRule();

  BucketLifecycleRule.fromJson(core.Map _json) {
    if (_json.containsKey("action")) {
      action = new BucketLifecycleRuleAction.fromJson(_json["action"]);
    }
    if (_json.containsKey("condition")) {
      condition = new BucketLifecycleRuleCondition.fromJson(_json["condition"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (action != null) {
      _json["action"] = (action).toJson();
    }
    if (condition != null) {
      _json["condition"] = (condition).toJson();
    }
    return _json;
  }
}

/**
 * The bucket's lifecycle configuration. See lifecycle management for more
 * information.
 */
class BucketLifecycle {
  /**
   * A lifecycle management rule, which is made of an action to take and the
   * condition(s) under which the action will be taken.
   */
  core.List<BucketLifecycleRule> rule;

  BucketLifecycle();

  BucketLifecycle.fromJson(core.Map _json) {
    if (_json.containsKey("rule")) {
      rule = _json["rule"].map((value) => new BucketLifecycleRule.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (rule != null) {
      _json["rule"] = rule.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * The bucket's logging configuration, which defines the destination bucket and
 * optional name prefix for the current bucket's logs.
 */
class BucketLogging {
  /**
   * The destination bucket where the current bucket's logs should be placed.
   */
  core.String logBucket;
  /** A prefix for log object names. */
  core.String logObjectPrefix;

  BucketLogging();

  BucketLogging.fromJson(core.Map _json) {
    if (_json.containsKey("logBucket")) {
      logBucket = _json["logBucket"];
    }
    if (_json.containsKey("logObjectPrefix")) {
      logObjectPrefix = _json["logObjectPrefix"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (logBucket != null) {
      _json["logBucket"] = logBucket;
    }
    if (logObjectPrefix != null) {
      _json["logObjectPrefix"] = logObjectPrefix;
    }
    return _json;
  }
}

/** The owner of the bucket. This is always the project team's owner group. */
class BucketOwner {
  /** The entity, in the form project-owner-projectId. */
  core.String entity;
  /** The ID for the entity. */
  core.String entityId;

  BucketOwner();

  BucketOwner.fromJson(core.Map _json) {
    if (_json.containsKey("entity")) {
      entity = _json["entity"];
    }
    if (_json.containsKey("entityId")) {
      entityId = _json["entityId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (entity != null) {
      _json["entity"] = entity;
    }
    if (entityId != null) {
      _json["entityId"] = entityId;
    }
    return _json;
  }
}

/** The bucket's versioning configuration. */
class BucketVersioning {
  /** While set to true, versioning is fully enabled for this bucket. */
  core.bool enabled;

  BucketVersioning();

  BucketVersioning.fromJson(core.Map _json) {
    if (_json.containsKey("enabled")) {
      enabled = _json["enabled"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (enabled != null) {
      _json["enabled"] = enabled;
    }
    return _json;
  }
}

/**
 * The bucket's website configuration, controlling how the service behaves when
 * accessing bucket contents as a web site. See the Static Website Examples for
 * more information.
 */
class BucketWebsite {
  /**
   * If the requested object path is missing, the service will ensure the path
   * has a trailing '/', append this suffix, and attempt to retrieve the
   * resulting object. This allows the creation of index.html objects to
   * represent directory pages.
   */
  core.String mainPageSuffix;
  /**
   * If the requested object path is missing, and any mainPageSuffix object is
   * missing, if applicable, the service will return the named object from this
   * bucket as the content for a 404 Not Found result.
   */
  core.String notFoundPage;

  BucketWebsite();

  BucketWebsite.fromJson(core.Map _json) {
    if (_json.containsKey("mainPageSuffix")) {
      mainPageSuffix = _json["mainPageSuffix"];
    }
    if (_json.containsKey("notFoundPage")) {
      notFoundPage = _json["notFoundPage"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (mainPageSuffix != null) {
      _json["mainPageSuffix"] = mainPageSuffix;
    }
    if (notFoundPage != null) {
      _json["notFoundPage"] = notFoundPage;
    }
    return _json;
  }
}

/** A bucket. */
class Bucket {
  /** Access controls on the bucket. */
  core.List<BucketAccessControl> acl;
  /** The bucket's Cross-Origin Resource Sharing (CORS) configuration. */
  core.List<BucketCors> cors;
  /**
   * Default access controls to apply to new objects when no ACL is provided.
   */
  core.List<ObjectAccessControl> defaultObjectAcl;
  /** HTTP 1.1 Entity tag for the bucket. */
  core.String etag;
  /**
   * The ID of the bucket. For buckets, the id and name properities are the
   * same.
   */
  core.String id;
  /** The kind of item this is. For buckets, this is always storage#bucket. */
  core.String kind;
  /**
   * The bucket's lifecycle configuration. See lifecycle management for more
   * information.
   */
  BucketLifecycle lifecycle;
  /**
   * The location of the bucket. Object data for objects in the bucket resides
   * in physical storage within this region. Defaults to US. See the developer's
   * guide for the authoritative list.
   */
  core.String location;
  /**
   * The bucket's logging configuration, which defines the destination bucket
   * and optional name prefix for the current bucket's logs.
   */
  BucketLogging logging;
  /** The metadata generation of this bucket. */
  core.String metageneration;
  /** The name of the bucket. */
  core.String name;
  /**
   * The owner of the bucket. This is always the project team's owner group.
   */
  BucketOwner owner;
  /** The project number of the project the bucket belongs to. */
  core.String projectNumber;
  /** The URI of this bucket. */
  core.String selfLink;
  /**
   * The bucket's default storage class, used whenever no storageClass is
   * specified for a newly-created object. This defines how objects in the
   * bucket are stored and determines the SLA and the cost of storage. Values
   * include MULTI_REGIONAL, REGIONAL, STANDARD, NEARLINE, COLDLINE, and
   * DURABLE_REDUCED_AVAILABILITY. If this value is not specified when the
   * bucket is created, it will default to STANDARD. For more information, see
   * storage classes.
   */
  core.String storageClass;
  /** The creation time of the bucket in RFC 3339 format. */
  core.DateTime timeCreated;
  /** The modification time of the bucket in RFC 3339 format. */
  core.DateTime updated;
  /** The bucket's versioning configuration. */
  BucketVersioning versioning;
  /**
   * The bucket's website configuration, controlling how the service behaves
   * when accessing bucket contents as a web site. See the Static Website
   * Examples for more information.
   */
  BucketWebsite website;

  Bucket();

  Bucket.fromJson(core.Map _json) {
    if (_json.containsKey("acl")) {
      acl = _json["acl"].map((value) => new BucketAccessControl.fromJson(value)).toList();
    }
    if (_json.containsKey("cors")) {
      cors = _json["cors"].map((value) => new BucketCors.fromJson(value)).toList();
    }
    if (_json.containsKey("defaultObjectAcl")) {
      defaultObjectAcl = _json["defaultObjectAcl"].map((value) => new ObjectAccessControl.fromJson(value)).toList();
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
    if (_json.containsKey("lifecycle")) {
      lifecycle = new BucketLifecycle.fromJson(_json["lifecycle"]);
    }
    if (_json.containsKey("location")) {
      location = _json["location"];
    }
    if (_json.containsKey("logging")) {
      logging = new BucketLogging.fromJson(_json["logging"]);
    }
    if (_json.containsKey("metageneration")) {
      metageneration = _json["metageneration"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("owner")) {
      owner = new BucketOwner.fromJson(_json["owner"]);
    }
    if (_json.containsKey("projectNumber")) {
      projectNumber = _json["projectNumber"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("storageClass")) {
      storageClass = _json["storageClass"];
    }
    if (_json.containsKey("timeCreated")) {
      timeCreated = core.DateTime.parse(_json["timeCreated"]);
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
    if (_json.containsKey("versioning")) {
      versioning = new BucketVersioning.fromJson(_json["versioning"]);
    }
    if (_json.containsKey("website")) {
      website = new BucketWebsite.fromJson(_json["website"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (acl != null) {
      _json["acl"] = acl.map((value) => (value).toJson()).toList();
    }
    if (cors != null) {
      _json["cors"] = cors.map((value) => (value).toJson()).toList();
    }
    if (defaultObjectAcl != null) {
      _json["defaultObjectAcl"] = defaultObjectAcl.map((value) => (value).toJson()).toList();
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
    if (lifecycle != null) {
      _json["lifecycle"] = (lifecycle).toJson();
    }
    if (location != null) {
      _json["location"] = location;
    }
    if (logging != null) {
      _json["logging"] = (logging).toJson();
    }
    if (metageneration != null) {
      _json["metageneration"] = metageneration;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (owner != null) {
      _json["owner"] = (owner).toJson();
    }
    if (projectNumber != null) {
      _json["projectNumber"] = projectNumber;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (storageClass != null) {
      _json["storageClass"] = storageClass;
    }
    if (timeCreated != null) {
      _json["timeCreated"] = (timeCreated).toIso8601String();
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    if (versioning != null) {
      _json["versioning"] = (versioning).toJson();
    }
    if (website != null) {
      _json["website"] = (website).toJson();
    }
    return _json;
  }
}

/** The project team associated with the entity, if any. */
class BucketAccessControlProjectTeam {
  /** The project number. */
  core.String projectNumber;
  /** The team. */
  core.String team;

  BucketAccessControlProjectTeam();

  BucketAccessControlProjectTeam.fromJson(core.Map _json) {
    if (_json.containsKey("projectNumber")) {
      projectNumber = _json["projectNumber"];
    }
    if (_json.containsKey("team")) {
      team = _json["team"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (projectNumber != null) {
      _json["projectNumber"] = projectNumber;
    }
    if (team != null) {
      _json["team"] = team;
    }
    return _json;
  }
}

/** An access-control entry. */
class BucketAccessControl {
  /** The name of the bucket. */
  core.String bucket;
  /** The domain associated with the entity, if any. */
  core.String domain;
  /** The email address associated with the entity, if any. */
  core.String email;
  /**
   * The entity holding the permission, in one of the following forms:
   * - user-userId
   * - user-email
   * - group-groupId
   * - group-email
   * - domain-domain
   * - project-team-projectId
   * - allUsers
   * - allAuthenticatedUsers Examples:
   * - The user liz@example.com would be user-liz@example.com.
   * - The group example@googlegroups.com would be
   * group-example@googlegroups.com.
   * - To refer to all members of the Google Apps for Business domain
   * example.com, the entity would be domain-example.com.
   */
  core.String entity;
  /** The ID for the entity, if any. */
  core.String entityId;
  /** HTTP 1.1 Entity tag for the access-control entry. */
  core.String etag;
  /** The ID of the access-control entry. */
  core.String id;
  /**
   * The kind of item this is. For bucket access control entries, this is always
   * storage#bucketAccessControl.
   */
  core.String kind;
  /** The project team associated with the entity, if any. */
  BucketAccessControlProjectTeam projectTeam;
  /** The access permission for the entity. */
  core.String role;
  /** The link to this access-control entry. */
  core.String selfLink;

  BucketAccessControl();

  BucketAccessControl.fromJson(core.Map _json) {
    if (_json.containsKey("bucket")) {
      bucket = _json["bucket"];
    }
    if (_json.containsKey("domain")) {
      domain = _json["domain"];
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("entity")) {
      entity = _json["entity"];
    }
    if (_json.containsKey("entityId")) {
      entityId = _json["entityId"];
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
    if (_json.containsKey("projectTeam")) {
      projectTeam = new BucketAccessControlProjectTeam.fromJson(_json["projectTeam"]);
    }
    if (_json.containsKey("role")) {
      role = _json["role"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (bucket != null) {
      _json["bucket"] = bucket;
    }
    if (domain != null) {
      _json["domain"] = domain;
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (entity != null) {
      _json["entity"] = entity;
    }
    if (entityId != null) {
      _json["entityId"] = entityId;
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
    if (projectTeam != null) {
      _json["projectTeam"] = (projectTeam).toJson();
    }
    if (role != null) {
      _json["role"] = role;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    return _json;
  }
}

/** An access-control list. */
class BucketAccessControls {
  /** The list of items. */
  core.List<BucketAccessControl> items;
  /**
   * The kind of item this is. For lists of bucket access control entries, this
   * is always storage#bucketAccessControls.
   */
  core.String kind;

  BucketAccessControls();

  BucketAccessControls.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new BucketAccessControl.fromJson(value)).toList();
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

/** A list of buckets. */
class Buckets {
  /** The list of items. */
  core.List<Bucket> items;
  /**
   * The kind of item this is. For lists of buckets, this is always
   * storage#buckets.
   */
  core.String kind;
  /**
   * The continuation token, used to page through large result sets. Provide
   * this value in a subsequent request to return the next page of results.
   */
  core.String nextPageToken;

  Buckets();

  Buckets.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Bucket.fromJson(value)).toList();
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

/** An notification channel used to watch for resource changes. */
class Channel {
  /** The address where notifications are delivered for this channel. */
  core.String address;
  /**
   * Date and time of notification channel expiration, expressed as a Unix
   * timestamp, in milliseconds. Optional.
   */
  core.String expiration;
  /** A UUID or similar unique string that identifies this channel. */
  core.String id;
  /**
   * Identifies this as a notification channel used to watch for changes to a
   * resource. Value: the fixed string "api#channel".
   */
  core.String kind;
  /** Additional parameters controlling delivery channel behavior. Optional. */
  core.Map<core.String, core.String> params;
  /** A Boolean value to indicate whether payload is wanted. Optional. */
  core.bool payload;
  /**
   * An opaque ID that identifies the resource being watched on this channel.
   * Stable across different API versions.
   */
  core.String resourceId;
  /** A version-specific identifier for the watched resource. */
  core.String resourceUri;
  /**
   * An arbitrary string delivered to the target address with each notification
   * delivered over this channel. Optional.
   */
  core.String token;
  /** The type of delivery mechanism used for this channel. */
  core.String type;

  Channel();

  Channel.fromJson(core.Map _json) {
    if (_json.containsKey("address")) {
      address = _json["address"];
    }
    if (_json.containsKey("expiration")) {
      expiration = _json["expiration"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("params")) {
      params = _json["params"];
    }
    if (_json.containsKey("payload")) {
      payload = _json["payload"];
    }
    if (_json.containsKey("resourceId")) {
      resourceId = _json["resourceId"];
    }
    if (_json.containsKey("resourceUri")) {
      resourceUri = _json["resourceUri"];
    }
    if (_json.containsKey("token")) {
      token = _json["token"];
    }
    if (_json.containsKey("type")) {
      type = _json["type"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (address != null) {
      _json["address"] = address;
    }
    if (expiration != null) {
      _json["expiration"] = expiration;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (params != null) {
      _json["params"] = params;
    }
    if (payload != null) {
      _json["payload"] = payload;
    }
    if (resourceId != null) {
      _json["resourceId"] = resourceId;
    }
    if (resourceUri != null) {
      _json["resourceUri"] = resourceUri;
    }
    if (token != null) {
      _json["token"] = token;
    }
    if (type != null) {
      _json["type"] = type;
    }
    return _json;
  }
}

/** Conditions that must be met for this operation to execute. */
class ComposeRequestSourceObjectsObjectPreconditions {
  /**
   * Only perform the composition if the generation of the source object that
   * would be used matches this value. If this value and a generation are both
   * specified, they must be the same value or the call will fail.
   */
  core.String ifGenerationMatch;

  ComposeRequestSourceObjectsObjectPreconditions();

  ComposeRequestSourceObjectsObjectPreconditions.fromJson(core.Map _json) {
    if (_json.containsKey("ifGenerationMatch")) {
      ifGenerationMatch = _json["ifGenerationMatch"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (ifGenerationMatch != null) {
      _json["ifGenerationMatch"] = ifGenerationMatch;
    }
    return _json;
  }
}

class ComposeRequestSourceObjects {
  /** The generation of this object to use as the source. */
  core.String generation;
  /**
   * The source object's name. The source object's bucket is implicitly the
   * destination bucket.
   */
  core.String name;
  /** Conditions that must be met for this operation to execute. */
  ComposeRequestSourceObjectsObjectPreconditions objectPreconditions;

  ComposeRequestSourceObjects();

  ComposeRequestSourceObjects.fromJson(core.Map _json) {
    if (_json.containsKey("generation")) {
      generation = _json["generation"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("objectPreconditions")) {
      objectPreconditions = new ComposeRequestSourceObjectsObjectPreconditions.fromJson(_json["objectPreconditions"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (generation != null) {
      _json["generation"] = generation;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (objectPreconditions != null) {
      _json["objectPreconditions"] = (objectPreconditions).toJson();
    }
    return _json;
  }
}

/** A Compose request. */
class ComposeRequest {
  /** Properties of the resulting object. */
  Object destination;
  /** The kind of item this is. */
  core.String kind;
  /**
   * The list of source objects that will be concatenated into a single object.
   */
  core.List<ComposeRequestSourceObjects> sourceObjects;

  ComposeRequest();

  ComposeRequest.fromJson(core.Map _json) {
    if (_json.containsKey("destination")) {
      destination = new Object.fromJson(_json["destination"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("sourceObjects")) {
      sourceObjects = _json["sourceObjects"].map((value) => new ComposeRequestSourceObjects.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (destination != null) {
      _json["destination"] = (destination).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (sourceObjects != null) {
      _json["sourceObjects"] = sourceObjects.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/**
 * Metadata of customer-supplied encryption key, if the object is encrypted by
 * such a key.
 */
class ObjectCustomerEncryption {
  /** The encryption algorithm. */
  core.String encryptionAlgorithm;
  /** SHA256 hash value of the encryption key. */
  core.String keySha256;

  ObjectCustomerEncryption();

  ObjectCustomerEncryption.fromJson(core.Map _json) {
    if (_json.containsKey("encryptionAlgorithm")) {
      encryptionAlgorithm = _json["encryptionAlgorithm"];
    }
    if (_json.containsKey("keySha256")) {
      keySha256 = _json["keySha256"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (encryptionAlgorithm != null) {
      _json["encryptionAlgorithm"] = encryptionAlgorithm;
    }
    if (keySha256 != null) {
      _json["keySha256"] = keySha256;
    }
    return _json;
  }
}

/** The owner of the object. This will always be the uploader of the object. */
class ObjectOwner {
  /** The entity, in the form user-userId. */
  core.String entity;
  /** The ID for the entity. */
  core.String entityId;

  ObjectOwner();

  ObjectOwner.fromJson(core.Map _json) {
    if (_json.containsKey("entity")) {
      entity = _json["entity"];
    }
    if (_json.containsKey("entityId")) {
      entityId = _json["entityId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (entity != null) {
      _json["entity"] = entity;
    }
    if (entityId != null) {
      _json["entityId"] = entityId;
    }
    return _json;
  }
}

/** An object. */
class Object {
  /** Access controls on the object. */
  core.List<ObjectAccessControl> acl;
  /** The name of the bucket containing this object. */
  core.String bucket;
  /**
   * Cache-Control directive for the object data. If omitted, and the object is
   * accessible to all anonymous users, the default will be public,
   * max-age=3600.
   */
  core.String cacheControl;
  /**
   * Number of underlying components that make up this object. Components are
   * accumulated by compose operations.
   */
  core.int componentCount;
  /** Content-Disposition of the object data. */
  core.String contentDisposition;
  /** Content-Encoding of the object data. */
  core.String contentEncoding;
  /** Content-Language of the object data. */
  core.String contentLanguage;
  /**
   * Content-Type of the object data. If contentType is not specified, object
   * downloads will be served as application/octet-stream.
   */
  core.String contentType;
  /**
   * CRC32c checksum, as described in RFC 4960, Appendix B; encoded using base64
   * in big-endian byte order. For more information about using the CRC32c
   * checksum, see Hashes and ETags: Best Practices.
   */
  core.String crc32c;
  /**
   * Metadata of customer-supplied encryption key, if the object is encrypted by
   * such a key.
   */
  ObjectCustomerEncryption customerEncryption;
  /** HTTP 1.1 Entity tag for the object. */
  core.String etag;
  /** The content generation of this object. Used for object versioning. */
  core.String generation;
  /**
   * The ID of the object, including the bucket name, object name, and
   * generation number.
   */
  core.String id;
  /** The kind of item this is. For objects, this is always storage#object. */
  core.String kind;
  /**
   * MD5 hash of the data; encoded using base64. For more information about
   * using the MD5 hash, see Hashes and ETags: Best Practices.
   */
  core.String md5Hash;
  /** Media download link. */
  core.String mediaLink;
  /** User-provided metadata, in key/value pairs. */
  core.Map<core.String, core.String> metadata;
  /**
   * The version of the metadata for this object at this generation. Used for
   * preconditions and for detecting changes in metadata. A metageneration
   * number is only meaningful in the context of a particular generation of a
   * particular object.
   */
  core.String metageneration;
  /** The name of the object. Required if not specified by URL parameter. */
  core.String name;
  /**
   * The owner of the object. This will always be the uploader of the object.
   */
  ObjectOwner owner;
  /** The link to this object. */
  core.String selfLink;
  /** Content-Length of the data in bytes. */
  core.String size;
  /** Storage class of the object. */
  core.String storageClass;
  /** The creation time of the object in RFC 3339 format. */
  core.DateTime timeCreated;
  /**
   * The deletion time of the object in RFC 3339 format. Will be returned if and
   * only if this version of the object has been deleted.
   */
  core.DateTime timeDeleted;
  /**
   * The time at which the object's storage class was last changed. When the
   * object is initially created, it will be set to timeCreated.
   */
  core.DateTime timeStorageClassUpdated;
  /** The modification time of the object metadata in RFC 3339 format. */
  core.DateTime updated;

  Object();

  Object.fromJson(core.Map _json) {
    if (_json.containsKey("acl")) {
      acl = _json["acl"].map((value) => new ObjectAccessControl.fromJson(value)).toList();
    }
    if (_json.containsKey("bucket")) {
      bucket = _json["bucket"];
    }
    if (_json.containsKey("cacheControl")) {
      cacheControl = _json["cacheControl"];
    }
    if (_json.containsKey("componentCount")) {
      componentCount = _json["componentCount"];
    }
    if (_json.containsKey("contentDisposition")) {
      contentDisposition = _json["contentDisposition"];
    }
    if (_json.containsKey("contentEncoding")) {
      contentEncoding = _json["contentEncoding"];
    }
    if (_json.containsKey("contentLanguage")) {
      contentLanguage = _json["contentLanguage"];
    }
    if (_json.containsKey("contentType")) {
      contentType = _json["contentType"];
    }
    if (_json.containsKey("crc32c")) {
      crc32c = _json["crc32c"];
    }
    if (_json.containsKey("customerEncryption")) {
      customerEncryption = new ObjectCustomerEncryption.fromJson(_json["customerEncryption"]);
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("generation")) {
      generation = _json["generation"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("md5Hash")) {
      md5Hash = _json["md5Hash"];
    }
    if (_json.containsKey("mediaLink")) {
      mediaLink = _json["mediaLink"];
    }
    if (_json.containsKey("metadata")) {
      metadata = _json["metadata"];
    }
    if (_json.containsKey("metageneration")) {
      metageneration = _json["metageneration"];
    }
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
    if (_json.containsKey("owner")) {
      owner = new ObjectOwner.fromJson(_json["owner"]);
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
    if (_json.containsKey("size")) {
      size = _json["size"];
    }
    if (_json.containsKey("storageClass")) {
      storageClass = _json["storageClass"];
    }
    if (_json.containsKey("timeCreated")) {
      timeCreated = core.DateTime.parse(_json["timeCreated"]);
    }
    if (_json.containsKey("timeDeleted")) {
      timeDeleted = core.DateTime.parse(_json["timeDeleted"]);
    }
    if (_json.containsKey("timeStorageClassUpdated")) {
      timeStorageClassUpdated = core.DateTime.parse(_json["timeStorageClassUpdated"]);
    }
    if (_json.containsKey("updated")) {
      updated = core.DateTime.parse(_json["updated"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (acl != null) {
      _json["acl"] = acl.map((value) => (value).toJson()).toList();
    }
    if (bucket != null) {
      _json["bucket"] = bucket;
    }
    if (cacheControl != null) {
      _json["cacheControl"] = cacheControl;
    }
    if (componentCount != null) {
      _json["componentCount"] = componentCount;
    }
    if (contentDisposition != null) {
      _json["contentDisposition"] = contentDisposition;
    }
    if (contentEncoding != null) {
      _json["contentEncoding"] = contentEncoding;
    }
    if (contentLanguage != null) {
      _json["contentLanguage"] = contentLanguage;
    }
    if (contentType != null) {
      _json["contentType"] = contentType;
    }
    if (crc32c != null) {
      _json["crc32c"] = crc32c;
    }
    if (customerEncryption != null) {
      _json["customerEncryption"] = (customerEncryption).toJson();
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (generation != null) {
      _json["generation"] = generation;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (md5Hash != null) {
      _json["md5Hash"] = md5Hash;
    }
    if (mediaLink != null) {
      _json["mediaLink"] = mediaLink;
    }
    if (metadata != null) {
      _json["metadata"] = metadata;
    }
    if (metageneration != null) {
      _json["metageneration"] = metageneration;
    }
    if (name != null) {
      _json["name"] = name;
    }
    if (owner != null) {
      _json["owner"] = (owner).toJson();
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    if (size != null) {
      _json["size"] = size;
    }
    if (storageClass != null) {
      _json["storageClass"] = storageClass;
    }
    if (timeCreated != null) {
      _json["timeCreated"] = (timeCreated).toIso8601String();
    }
    if (timeDeleted != null) {
      _json["timeDeleted"] = (timeDeleted).toIso8601String();
    }
    if (timeStorageClassUpdated != null) {
      _json["timeStorageClassUpdated"] = (timeStorageClassUpdated).toIso8601String();
    }
    if (updated != null) {
      _json["updated"] = (updated).toIso8601String();
    }
    return _json;
  }
}

/** The project team associated with the entity, if any. */
class ObjectAccessControlProjectTeam {
  /** The project number. */
  core.String projectNumber;
  /** The team. */
  core.String team;

  ObjectAccessControlProjectTeam();

  ObjectAccessControlProjectTeam.fromJson(core.Map _json) {
    if (_json.containsKey("projectNumber")) {
      projectNumber = _json["projectNumber"];
    }
    if (_json.containsKey("team")) {
      team = _json["team"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (projectNumber != null) {
      _json["projectNumber"] = projectNumber;
    }
    if (team != null) {
      _json["team"] = team;
    }
    return _json;
  }
}

/** An access-control entry. */
class ObjectAccessControl {
  /** The name of the bucket. */
  core.String bucket;
  /** The domain associated with the entity, if any. */
  core.String domain;
  /** The email address associated with the entity, if any. */
  core.String email;
  /**
   * The entity holding the permission, in one of the following forms:
   * - user-userId
   * - user-email
   * - group-groupId
   * - group-email
   * - domain-domain
   * - project-team-projectId
   * - allUsers
   * - allAuthenticatedUsers Examples:
   * - The user liz@example.com would be user-liz@example.com.
   * - The group example@googlegroups.com would be
   * group-example@googlegroups.com.
   * - To refer to all members of the Google Apps for Business domain
   * example.com, the entity would be domain-example.com.
   */
  core.String entity;
  /** The ID for the entity, if any. */
  core.String entityId;
  /** HTTP 1.1 Entity tag for the access-control entry. */
  core.String etag;
  /** The content generation of the object, if applied to an object. */
  core.String generation;
  /** The ID of the access-control entry. */
  core.String id;
  /**
   * The kind of item this is. For object access control entries, this is always
   * storage#objectAccessControl.
   */
  core.String kind;
  /** The name of the object, if applied to an object. */
  core.String object;
  /** The project team associated with the entity, if any. */
  ObjectAccessControlProjectTeam projectTeam;
  /** The access permission for the entity. */
  core.String role;
  /** The link to this access-control entry. */
  core.String selfLink;

  ObjectAccessControl();

  ObjectAccessControl.fromJson(core.Map _json) {
    if (_json.containsKey("bucket")) {
      bucket = _json["bucket"];
    }
    if (_json.containsKey("domain")) {
      domain = _json["domain"];
    }
    if (_json.containsKey("email")) {
      email = _json["email"];
    }
    if (_json.containsKey("entity")) {
      entity = _json["entity"];
    }
    if (_json.containsKey("entityId")) {
      entityId = _json["entityId"];
    }
    if (_json.containsKey("etag")) {
      etag = _json["etag"];
    }
    if (_json.containsKey("generation")) {
      generation = _json["generation"];
    }
    if (_json.containsKey("id")) {
      id = _json["id"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("object")) {
      object = _json["object"];
    }
    if (_json.containsKey("projectTeam")) {
      projectTeam = new ObjectAccessControlProjectTeam.fromJson(_json["projectTeam"]);
    }
    if (_json.containsKey("role")) {
      role = _json["role"];
    }
    if (_json.containsKey("selfLink")) {
      selfLink = _json["selfLink"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (bucket != null) {
      _json["bucket"] = bucket;
    }
    if (domain != null) {
      _json["domain"] = domain;
    }
    if (email != null) {
      _json["email"] = email;
    }
    if (entity != null) {
      _json["entity"] = entity;
    }
    if (entityId != null) {
      _json["entityId"] = entityId;
    }
    if (etag != null) {
      _json["etag"] = etag;
    }
    if (generation != null) {
      _json["generation"] = generation;
    }
    if (id != null) {
      _json["id"] = id;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (object != null) {
      _json["object"] = object;
    }
    if (projectTeam != null) {
      _json["projectTeam"] = (projectTeam).toJson();
    }
    if (role != null) {
      _json["role"] = role;
    }
    if (selfLink != null) {
      _json["selfLink"] = selfLink;
    }
    return _json;
  }
}

/** An access-control list. */
class ObjectAccessControls {
  /** The list of items. */
  core.List<ObjectAccessControl> items;
  /**
   * The kind of item this is. For lists of object access control entries, this
   * is always storage#objectAccessControls.
   */
  core.String kind;

  ObjectAccessControls();

  ObjectAccessControls.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new ObjectAccessControl.fromJson(value)).toList();
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

/** A list of objects. */
class Objects {
  /** The list of items. */
  core.List<Object> items;
  /**
   * The kind of item this is. For lists of objects, this is always
   * storage#objects.
   */
  core.String kind;
  /**
   * The continuation token, used to page through large result sets. Provide
   * this value in a subsequent request to return the next page of results.
   */
  core.String nextPageToken;
  /**
   * The list of prefixes of objects matching-but-not-listed up to and including
   * the requested delimiter.
   */
  core.List<core.String> prefixes;

  Objects();

  Objects.fromJson(core.Map _json) {
    if (_json.containsKey("items")) {
      items = _json["items"].map((value) => new Object.fromJson(value)).toList();
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("nextPageToken")) {
      nextPageToken = _json["nextPageToken"];
    }
    if (_json.containsKey("prefixes")) {
      prefixes = _json["prefixes"];
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
    if (prefixes != null) {
      _json["prefixes"] = prefixes;
    }
    return _json;
  }
}

/** A rewrite response. */
class RewriteResponse {
  /**
   * true if the copy is finished; otherwise, false if the copy is in progress.
   * This property is always present in the response.
   */
  core.bool done;
  /** The kind of item this is. */
  core.String kind;
  /**
   * The total size of the object being copied in bytes. This property is always
   * present in the response.
   */
  core.String objectSize;
  /**
   * A resource containing the metadata for the copied-to object. This property
   * is present in the response only when copying completes.
   */
  Object resource;
  /**
   * A token to use in subsequent requests to continue copying data. This token
   * is present in the response only when there is more data to copy.
   */
  core.String rewriteToken;
  /**
   * The total bytes written so far, which can be used to provide a waiting user
   * with a progress indicator. This property is always present in the response.
   */
  core.String totalBytesRewritten;

  RewriteResponse();

  RewriteResponse.fromJson(core.Map _json) {
    if (_json.containsKey("done")) {
      done = _json["done"];
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"];
    }
    if (_json.containsKey("objectSize")) {
      objectSize = _json["objectSize"];
    }
    if (_json.containsKey("resource")) {
      resource = new Object.fromJson(_json["resource"]);
    }
    if (_json.containsKey("rewriteToken")) {
      rewriteToken = _json["rewriteToken"];
    }
    if (_json.containsKey("totalBytesRewritten")) {
      totalBytesRewritten = _json["totalBytesRewritten"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (done != null) {
      _json["done"] = done;
    }
    if (kind != null) {
      _json["kind"] = kind;
    }
    if (objectSize != null) {
      _json["objectSize"] = objectSize;
    }
    if (resource != null) {
      _json["resource"] = (resource).toJson();
    }
    if (rewriteToken != null) {
      _json["rewriteToken"] = rewriteToken;
    }
    if (totalBytesRewritten != null) {
      _json["totalBytesRewritten"] = totalBytesRewritten;
    }
    return _json;
  }
}
