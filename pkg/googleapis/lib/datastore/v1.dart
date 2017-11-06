// This is a generated file (see the discoveryapis_generator project).

library googleapis.datastore.v1;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;

export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client datastore/v1';

/**
 * Accesses the schemaless NoSQL database to provide fully managed, robust,
 * scalable storage for your application.
 */
class DatastoreApi {
  /** View and manage your data across Google Cloud Platform services */
  static const CloudPlatformScope = "https://www.googleapis.com/auth/cloud-platform";

  /** View and manage your Google Cloud Datastore data */
  static const DatastoreScope = "https://www.googleapis.com/auth/datastore";


  final commons.ApiRequester _requester;

  ProjectsResourceApi get projects => new ProjectsResourceApi(_requester);

  DatastoreApi(http.Client client, {core.String rootUrl: "https://datastore.googleapis.com/", core.String servicePath: ""}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class ProjectsResourceApi {
  final commons.ApiRequester _requester;

  ProjectsResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Allocates IDs for the given keys, which is useful for referencing an entity
   * before it is inserted.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [projectId] - The ID of the project against which to make the request.
   *
   * Completes with a [AllocateIdsResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<AllocateIdsResponse> allocateIds(AllocateIdsRequest request, core.String projectId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }

    _url = 'v1/projects/' + commons.Escaper.ecapeVariable('$projectId') + ':allocateIds';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new AllocateIdsResponse.fromJson(data));
  }

  /**
   * Begins a new transaction.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [projectId] - The ID of the project against which to make the request.
   *
   * Completes with a [BeginTransactionResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<BeginTransactionResponse> beginTransaction(BeginTransactionRequest request, core.String projectId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }

    _url = 'v1/projects/' + commons.Escaper.ecapeVariable('$projectId') + ':beginTransaction';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new BeginTransactionResponse.fromJson(data));
  }

  /**
   * Commits a transaction, optionally creating, deleting or modifying some
   * entities.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [projectId] - The ID of the project against which to make the request.
   *
   * Completes with a [CommitResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<CommitResponse> commit(CommitRequest request, core.String projectId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }

    _url = 'v1/projects/' + commons.Escaper.ecapeVariable('$projectId') + ':commit';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new CommitResponse.fromJson(data));
  }

  /**
   * Looks up entities by key.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [projectId] - The ID of the project against which to make the request.
   *
   * Completes with a [LookupResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<LookupResponse> lookup(LookupRequest request, core.String projectId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }

    _url = 'v1/projects/' + commons.Escaper.ecapeVariable('$projectId') + ':lookup';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new LookupResponse.fromJson(data));
  }

  /**
   * Rolls back a transaction.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [projectId] - The ID of the project against which to make the request.
   *
   * Completes with a [RollbackResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RollbackResponse> rollback(RollbackRequest request, core.String projectId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }

    _url = 'v1/projects/' + commons.Escaper.ecapeVariable('$projectId') + ':rollback';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RollbackResponse.fromJson(data));
  }

  /**
   * Queries for entities.
   *
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * [projectId] - The ID of the project against which to make the request.
   *
   * Completes with a [RunQueryResponse].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<RunQueryResponse> runQuery(RunQueryRequest request, core.String projectId) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode((request).toJson());
    }
    if (projectId == null) {
      throw new core.ArgumentError("Parameter projectId is required.");
    }

    _url = 'v1/projects/' + commons.Escaper.ecapeVariable('$projectId') + ':runQuery';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => new RunQueryResponse.fromJson(data));
  }

}



/** The request for Datastore.AllocateIds. */
class AllocateIdsRequest {
  /**
   * A list of keys with incomplete key paths for which to allocate IDs.
   * No key may be reserved/read-only.
   */
  core.List<Key> keys;

  AllocateIdsRequest();

  AllocateIdsRequest.fromJson(core.Map _json) {
    if (_json.containsKey("keys")) {
      keys = _json["keys"].map((value) => new Key.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (keys != null) {
      _json["keys"] = keys.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** The response for Datastore.AllocateIds. */
class AllocateIdsResponse {
  /**
   * The keys specified in the request (in the same order), each with
   * its key path completed with a newly allocated ID.
   */
  core.List<Key> keys;

  AllocateIdsResponse();

  AllocateIdsResponse.fromJson(core.Map _json) {
    if (_json.containsKey("keys")) {
      keys = _json["keys"].map((value) => new Key.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (keys != null) {
      _json["keys"] = keys.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** An array value. */
class ArrayValue {
  /**
   * Values in the array.
   * The order of this array may not be preserved if it contains a mix of
   * indexed and unindexed values.
   */
  core.List<Value> values;

  ArrayValue();

  ArrayValue.fromJson(core.Map _json) {
    if (_json.containsKey("values")) {
      values = _json["values"].map((value) => new Value.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (values != null) {
      _json["values"] = values.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** The request for Datastore.BeginTransaction. */
class BeginTransactionRequest {

  BeginTransactionRequest();

  BeginTransactionRequest.fromJson(core.Map _json) {
  }

  core.Map toJson() {
    var _json = new core.Map();
    return _json;
  }
}

/** The response for Datastore.BeginTransaction. */
class BeginTransactionResponse {
  /** The transaction identifier (always present). */
  core.String transaction;
  core.List<core.int> get transactionAsBytes {
    return convert.BASE64.decode(transaction);
  }

  void set transactionAsBytes(core.List<core.int> _bytes) {
    transaction = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  BeginTransactionResponse();

  BeginTransactionResponse.fromJson(core.Map _json) {
    if (_json.containsKey("transaction")) {
      transaction = _json["transaction"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (transaction != null) {
      _json["transaction"] = transaction;
    }
    return _json;
  }
}

/** The request for Datastore.Commit. */
class CommitRequest {
  /**
   * The type of commit to perform. Defaults to `TRANSACTIONAL`.
   * Possible string values are:
   * - "MODE_UNSPECIFIED" : Unspecified. This value must not be used.
   * - "TRANSACTIONAL" : Transactional: The mutations are either all applied, or
   * none are applied.
   * Learn about transactions
   * [here](https://cloud.google.com/datastore/docs/concepts/transactions).
   * - "NON_TRANSACTIONAL" : Non-transactional: The mutations may not apply as
   * all or none.
   */
  core.String mode;
  /**
   * The mutations to perform.
   *
   * When mode is `TRANSACTIONAL`, mutations affecting a single entity are
   * applied in order. The following sequences of mutations affecting a single
   * entity are not permitted in a single `Commit` request:
   *
   * - `insert` followed by `insert`
   * - `update` followed by `insert`
   * - `upsert` followed by `insert`
   * - `delete` followed by `update`
   *
   * When mode is `NON_TRANSACTIONAL`, no two mutations may affect a single
   * entity.
   */
  core.List<Mutation> mutations;
  /**
   * The identifier of the transaction associated with the commit. A
   * transaction identifier is returned by a call to
   * Datastore.BeginTransaction.
   */
  core.String transaction;
  core.List<core.int> get transactionAsBytes {
    return convert.BASE64.decode(transaction);
  }

  void set transactionAsBytes(core.List<core.int> _bytes) {
    transaction = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  CommitRequest();

  CommitRequest.fromJson(core.Map _json) {
    if (_json.containsKey("mode")) {
      mode = _json["mode"];
    }
    if (_json.containsKey("mutations")) {
      mutations = _json["mutations"].map((value) => new Mutation.fromJson(value)).toList();
    }
    if (_json.containsKey("transaction")) {
      transaction = _json["transaction"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (mode != null) {
      _json["mode"] = mode;
    }
    if (mutations != null) {
      _json["mutations"] = mutations.map((value) => (value).toJson()).toList();
    }
    if (transaction != null) {
      _json["transaction"] = transaction;
    }
    return _json;
  }
}

/** The response for Datastore.Commit. */
class CommitResponse {
  /**
   * The number of index entries updated during the commit, or zero if none were
   * updated.
   */
  core.int indexUpdates;
  /**
   * The result of performing the mutations.
   * The i-th mutation result corresponds to the i-th mutation in the request.
   */
  core.List<MutationResult> mutationResults;

  CommitResponse();

  CommitResponse.fromJson(core.Map _json) {
    if (_json.containsKey("indexUpdates")) {
      indexUpdates = _json["indexUpdates"];
    }
    if (_json.containsKey("mutationResults")) {
      mutationResults = _json["mutationResults"].map((value) => new MutationResult.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (indexUpdates != null) {
      _json["indexUpdates"] = indexUpdates;
    }
    if (mutationResults != null) {
      _json["mutationResults"] = mutationResults.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** A filter that merges multiple other filters using the given operator. */
class CompositeFilter {
  /**
   * The list of filters to combine.
   * Must contain at least one filter.
   */
  core.List<Filter> filters;
  /**
   * The operator for combining multiple filters.
   * Possible string values are:
   * - "OPERATOR_UNSPECIFIED" : Unspecified. This value must not be used.
   * - "AND" : The results are required to satisfy each of the combined filters.
   */
  core.String op;

  CompositeFilter();

  CompositeFilter.fromJson(core.Map _json) {
    if (_json.containsKey("filters")) {
      filters = _json["filters"].map((value) => new Filter.fromJson(value)).toList();
    }
    if (_json.containsKey("op")) {
      op = _json["op"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (filters != null) {
      _json["filters"] = filters.map((value) => (value).toJson()).toList();
    }
    if (op != null) {
      _json["op"] = op;
    }
    return _json;
  }
}

/**
 * A Datastore data object.
 *
 * An entity is limited to 1 megabyte when stored. That _roughly_
 * corresponds to a limit of 1 megabyte for the serialized form of this
 * message.
 */
class Entity {
  /**
   * The entity's key.
   *
   * An entity must have a key, unless otherwise documented (for example,
   * an entity in `Value.entity_value` may have no key).
   * An entity's kind is its key path's last element's kind,
   * or null if it has no key.
   */
  Key key;
  /**
   * The entity's properties.
   * The map's keys are property names.
   * A property name matching regex `__.*__` is reserved.
   * A reserved property name is forbidden in certain documented contexts.
   * The name must not contain more than 500 characters.
   * The name cannot be `""`.
   */
  core.Map<core.String, Value> properties;

  Entity();

  Entity.fromJson(core.Map _json) {
    if (_json.containsKey("key")) {
      key = new Key.fromJson(_json["key"]);
    }
    if (_json.containsKey("properties")) {
      properties = commons.mapMap(_json["properties"], (item) => new Value.fromJson(item));
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (key != null) {
      _json["key"] = (key).toJson();
    }
    if (properties != null) {
      _json["properties"] = commons.mapMap(properties, (item) => (item).toJson());
    }
    return _json;
  }
}

/** The result of fetching an entity from Datastore. */
class EntityResult {
  /**
   * A cursor that points to the position after the result entity.
   * Set only when the `EntityResult` is part of a `QueryResultBatch` message.
   */
  core.String cursor;
  core.List<core.int> get cursorAsBytes {
    return convert.BASE64.decode(cursor);
  }

  void set cursorAsBytes(core.List<core.int> _bytes) {
    cursor = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /** The resulting entity. */
  Entity entity;
  /**
   * The version of the entity, a strictly positive number that monotonically
   * increases with changes to the entity.
   *
   * This field is set for `FULL` entity
   * results.
   *
   * For missing entities in `LookupResponse`, this
   * is the version of the snapshot that was used to look up the entity, and it
   * is always set except for eventually consistent reads.
   */
  core.String version;

  EntityResult();

  EntityResult.fromJson(core.Map _json) {
    if (_json.containsKey("cursor")) {
      cursor = _json["cursor"];
    }
    if (_json.containsKey("entity")) {
      entity = new Entity.fromJson(_json["entity"]);
    }
    if (_json.containsKey("version")) {
      version = _json["version"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cursor != null) {
      _json["cursor"] = cursor;
    }
    if (entity != null) {
      _json["entity"] = (entity).toJson();
    }
    if (version != null) {
      _json["version"] = version;
    }
    return _json;
  }
}

/** A holder for any type of filter. */
class Filter {
  /** A composite filter. */
  CompositeFilter compositeFilter;
  /** A filter on a property. */
  PropertyFilter propertyFilter;

  Filter();

  Filter.fromJson(core.Map _json) {
    if (_json.containsKey("compositeFilter")) {
      compositeFilter = new CompositeFilter.fromJson(_json["compositeFilter"]);
    }
    if (_json.containsKey("propertyFilter")) {
      propertyFilter = new PropertyFilter.fromJson(_json["propertyFilter"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (compositeFilter != null) {
      _json["compositeFilter"] = (compositeFilter).toJson();
    }
    if (propertyFilter != null) {
      _json["propertyFilter"] = (propertyFilter).toJson();
    }
    return _json;
  }
}

/**
 * A [GQL
 * query](https://cloud.google.com/datastore/docs/apis/gql/gql_reference).
 */
class GqlQuery {
  /**
   * When false, the query string must not contain any literals and instead must
   * bind all values. For example,
   * `SELECT * FROM Kind WHERE a = 'string literal'` is not allowed, while
   * `SELECT * FROM Kind WHERE a = @value` is.
   */
  core.bool allowLiterals;
  /**
   * For each non-reserved named binding site in the query string, there must be
   * a named parameter with that name, but not necessarily the inverse.
   *
   * Key must match regex `A-Za-z_$*`, must not match regex
   * `__.*__`, and must not be `""`.
   */
  core.Map<core.String, GqlQueryParameter> namedBindings;
  /**
   * Numbered binding site @1 references the first numbered parameter,
   * effectively using 1-based indexing, rather than the usual 0.
   *
   * For each binding site numbered i in `query_string`, there must be an i-th
   * numbered parameter. The inverse must also be true.
   */
  core.List<GqlQueryParameter> positionalBindings;
  /**
   * A string of the format described
   * [here](https://cloud.google.com/datastore/docs/apis/gql/gql_reference).
   */
  core.String queryString;

  GqlQuery();

  GqlQuery.fromJson(core.Map _json) {
    if (_json.containsKey("allowLiterals")) {
      allowLiterals = _json["allowLiterals"];
    }
    if (_json.containsKey("namedBindings")) {
      namedBindings = commons.mapMap(_json["namedBindings"], (item) => new GqlQueryParameter.fromJson(item));
    }
    if (_json.containsKey("positionalBindings")) {
      positionalBindings = _json["positionalBindings"].map((value) => new GqlQueryParameter.fromJson(value)).toList();
    }
    if (_json.containsKey("queryString")) {
      queryString = _json["queryString"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (allowLiterals != null) {
      _json["allowLiterals"] = allowLiterals;
    }
    if (namedBindings != null) {
      _json["namedBindings"] = commons.mapMap(namedBindings, (item) => (item).toJson());
    }
    if (positionalBindings != null) {
      _json["positionalBindings"] = positionalBindings.map((value) => (value).toJson()).toList();
    }
    if (queryString != null) {
      _json["queryString"] = queryString;
    }
    return _json;
  }
}

/** A binding parameter for a GQL query. */
class GqlQueryParameter {
  /**
   * A query cursor. Query cursors are returned in query
   * result batches.
   */
  core.String cursor;
  core.List<core.int> get cursorAsBytes {
    return convert.BASE64.decode(cursor);
  }

  void set cursorAsBytes(core.List<core.int> _bytes) {
    cursor = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /** A value parameter. */
  Value value;

  GqlQueryParameter();

  GqlQueryParameter.fromJson(core.Map _json) {
    if (_json.containsKey("cursor")) {
      cursor = _json["cursor"];
    }
    if (_json.containsKey("value")) {
      value = new Value.fromJson(_json["value"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (cursor != null) {
      _json["cursor"] = cursor;
    }
    if (value != null) {
      _json["value"] = (value).toJson();
    }
    return _json;
  }
}

/**
 * A unique identifier for an entity.
 * If a key's partition ID or any of its path kinds or names are
 * reserved/read-only, the key is reserved/read-only.
 * A reserved/read-only key is forbidden in certain documented contexts.
 */
class Key {
  /**
   * Entities are partitioned into subsets, currently identified by a project
   * ID and namespace ID.
   * Queries are scoped to a single partition.
   */
  PartitionId partitionId;
  /**
   * The entity path.
   * An entity path consists of one or more elements composed of a kind and a
   * string or numerical identifier, which identify entities. The first
   * element identifies a _root entity_, the second element identifies
   * a _child_ of the root entity, the third element identifies a child of the
   * second entity, and so forth. The entities identified by all prefixes of
   * the path are called the element's _ancestors_.
   *
   * An entity path is always fully complete: *all* of the entity's ancestors
   * are required to be in the path along with the entity identifier itself.
   * The only exception is that in some documented cases, the identifier in the
   * last path element (for the entity) itself may be omitted. For example,
   * the last path element of the key of `Mutation.insert` may have no
   * identifier.
   *
   * A path can never be empty, and a path can have at most 100 elements.
   */
  core.List<PathElement> path;

  Key();

  Key.fromJson(core.Map _json) {
    if (_json.containsKey("partitionId")) {
      partitionId = new PartitionId.fromJson(_json["partitionId"]);
    }
    if (_json.containsKey("path")) {
      path = _json["path"].map((value) => new PathElement.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (partitionId != null) {
      _json["partitionId"] = (partitionId).toJson();
    }
    if (path != null) {
      _json["path"] = path.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** A representation of a kind. */
class KindExpression {
  /** The name of the kind. */
  core.String name;

  KindExpression();

  KindExpression.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/**
 * An object representing a latitude/longitude pair. This is expressed as a pair
 * of doubles representing degrees latitude and degrees longitude. Unless
 * specified otherwise, this must conform to the
 * <a href="http://www.unoosa.org/pdf/icg/2012/template/WGS_84.pdf">WGS84
 * standard</a>. Values must be within normalized ranges.
 *
 * Example of normalization code in Python:
 *
 *     def NormalizeLongitude(longitude):
 *       """Wraps decimal degrees longitude to [-180.0, 180.0]."""
 *       q, r = divmod(longitude, 360.0)
 *       if r > 180.0 or (r == 180.0 and q <= -1.0):
 *         return r - 360.0
 *       return r
 *
 *     def NormalizeLatLng(latitude, longitude):
 *       """Wraps decimal degrees latitude and longitude to
 *       [-90.0, 90.0] and [-180.0, 180.0], respectively."""
 *       r = latitude % 360.0
 *       if r <= 90.0:
 *         return r, NormalizeLongitude(longitude)
 *       elif r >= 270.0:
 *         return r - 360, NormalizeLongitude(longitude)
 *       else:
 *         return 180 - r, NormalizeLongitude(longitude + 180.0)
 *
 *     assert 180.0 == NormalizeLongitude(180.0)
 *     assert -180.0 == NormalizeLongitude(-180.0)
 *     assert -179.0 == NormalizeLongitude(181.0)
 *     assert (0.0, 0.0) == NormalizeLatLng(360.0, 0.0)
 *     assert (0.0, 0.0) == NormalizeLatLng(-360.0, 0.0)
 *     assert (85.0, 180.0) == NormalizeLatLng(95.0, 0.0)
 *     assert (-85.0, -170.0) == NormalizeLatLng(-95.0, 10.0)
 *     assert (90.0, 10.0) == NormalizeLatLng(90.0, 10.0)
 *     assert (-90.0, -10.0) == NormalizeLatLng(-90.0, -10.0)
 *     assert (0.0, -170.0) == NormalizeLatLng(-180.0, 10.0)
 *     assert (0.0, -170.0) == NormalizeLatLng(180.0, 10.0)
 *     assert (-90.0, 10.0) == NormalizeLatLng(270.0, 10.0)
 *     assert (90.0, 10.0) == NormalizeLatLng(-270.0, 10.0)
 *
 * The code in logs/storage/validator/logs_validator_traits.cc treats this type
 * as if it were annotated as ST_LOCATION.
 */
class LatLng {
  /** The latitude in degrees. It must be in the range [-90.0, +90.0]. */
  core.double latitude;
  /** The longitude in degrees. It must be in the range [-180.0, +180.0]. */
  core.double longitude;

  LatLng();

  LatLng.fromJson(core.Map _json) {
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

/** The request for Datastore.Lookup. */
class LookupRequest {
  /** Keys of entities to look up. */
  core.List<Key> keys;
  /** The options for this lookup request. */
  ReadOptions readOptions;

  LookupRequest();

  LookupRequest.fromJson(core.Map _json) {
    if (_json.containsKey("keys")) {
      keys = _json["keys"].map((value) => new Key.fromJson(value)).toList();
    }
    if (_json.containsKey("readOptions")) {
      readOptions = new ReadOptions.fromJson(_json["readOptions"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (keys != null) {
      _json["keys"] = keys.map((value) => (value).toJson()).toList();
    }
    if (readOptions != null) {
      _json["readOptions"] = (readOptions).toJson();
    }
    return _json;
  }
}

/** The response for Datastore.Lookup. */
class LookupResponse {
  /**
   * A list of keys that were not looked up due to resource constraints. The
   * order of results in this field is undefined and has no relation to the
   * order of the keys in the input.
   */
  core.List<Key> deferred;
  /**
   * Entities found as `ResultType.FULL` entities. The order of results in this
   * field is undefined and has no relation to the order of the keys in the
   * input.
   */
  core.List<EntityResult> found;
  /**
   * Entities not found as `ResultType.KEY_ONLY` entities. The order of results
   * in this field is undefined and has no relation to the order of the keys
   * in the input.
   */
  core.List<EntityResult> missing;

  LookupResponse();

  LookupResponse.fromJson(core.Map _json) {
    if (_json.containsKey("deferred")) {
      deferred = _json["deferred"].map((value) => new Key.fromJson(value)).toList();
    }
    if (_json.containsKey("found")) {
      found = _json["found"].map((value) => new EntityResult.fromJson(value)).toList();
    }
    if (_json.containsKey("missing")) {
      missing = _json["missing"].map((value) => new EntityResult.fromJson(value)).toList();
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (deferred != null) {
      _json["deferred"] = deferred.map((value) => (value).toJson()).toList();
    }
    if (found != null) {
      _json["found"] = found.map((value) => (value).toJson()).toList();
    }
    if (missing != null) {
      _json["missing"] = missing.map((value) => (value).toJson()).toList();
    }
    return _json;
  }
}

/** A mutation to apply to an entity. */
class Mutation {
  /**
   * The version of the entity that this mutation is being applied to. If this
   * does not match the current version on the server, the mutation conflicts.
   */
  core.String baseVersion;
  /**
   * The key of the entity to delete. The entity may or may not already exist.
   * Must have a complete key path and must not be reserved/read-only.
   */
  Key delete;
  /**
   * The entity to insert. The entity must not already exist.
   * The entity key's final path element may be incomplete.
   */
  Entity insert;
  /**
   * The entity to update. The entity must already exist.
   * Must have a complete key path.
   */
  Entity update;
  /**
   * The entity to upsert. The entity may or may not already exist.
   * The entity key's final path element may be incomplete.
   */
  Entity upsert;

  Mutation();

  Mutation.fromJson(core.Map _json) {
    if (_json.containsKey("baseVersion")) {
      baseVersion = _json["baseVersion"];
    }
    if (_json.containsKey("delete")) {
      delete = new Key.fromJson(_json["delete"]);
    }
    if (_json.containsKey("insert")) {
      insert = new Entity.fromJson(_json["insert"]);
    }
    if (_json.containsKey("update")) {
      update = new Entity.fromJson(_json["update"]);
    }
    if (_json.containsKey("upsert")) {
      upsert = new Entity.fromJson(_json["upsert"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (baseVersion != null) {
      _json["baseVersion"] = baseVersion;
    }
    if (delete != null) {
      _json["delete"] = (delete).toJson();
    }
    if (insert != null) {
      _json["insert"] = (insert).toJson();
    }
    if (update != null) {
      _json["update"] = (update).toJson();
    }
    if (upsert != null) {
      _json["upsert"] = (upsert).toJson();
    }
    return _json;
  }
}

/** The result of applying a mutation. */
class MutationResult {
  /**
   * Whether a conflict was detected for this mutation. Always false when a
   * conflict detection strategy field is not set in the mutation.
   */
  core.bool conflictDetected;
  /**
   * The automatically allocated key.
   * Set only when the mutation allocated a key.
   */
  Key key;
  /**
   * The version of the entity on the server after processing the mutation. If
   * the mutation doesn't change anything on the server, then the version will
   * be the version of the current entity or, if no entity is present, a version
   * that is strictly greater than the version of any previous entity and less
   * than the version of any possible future entity.
   */
  core.String version;

  MutationResult();

  MutationResult.fromJson(core.Map _json) {
    if (_json.containsKey("conflictDetected")) {
      conflictDetected = _json["conflictDetected"];
    }
    if (_json.containsKey("key")) {
      key = new Key.fromJson(_json["key"]);
    }
    if (_json.containsKey("version")) {
      version = _json["version"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (conflictDetected != null) {
      _json["conflictDetected"] = conflictDetected;
    }
    if (key != null) {
      _json["key"] = (key).toJson();
    }
    if (version != null) {
      _json["version"] = version;
    }
    return _json;
  }
}

/**
 * A partition ID identifies a grouping of entities. The grouping is always
 * by project and namespace, however the namespace ID may be empty.
 *
 * A partition ID contains several dimensions:
 * project ID and namespace ID.
 *
 * Partition dimensions:
 *
 * - May be `""`.
 * - Must be valid UTF-8 bytes.
 * - Must have values that match regex `[A-Za-z\d\.\-_]{1,100}`
 * If the value of any dimension matches regex `__.*__`, the partition is
 * reserved/read-only.
 * A reserved/read-only partition ID is forbidden in certain documented
 * contexts.
 *
 * Foreign partition IDs (in which the project ID does
 * not match the context project ID ) are discouraged.
 * Reads and writes of foreign partition IDs may fail if the project is not in
 * an active state.
 */
class PartitionId {
  /** If not empty, the ID of the namespace to which the entities belong. */
  core.String namespaceId;
  /** The ID of the project to which the entities belong. */
  core.String projectId;

  PartitionId();

  PartitionId.fromJson(core.Map _json) {
    if (_json.containsKey("namespaceId")) {
      namespaceId = _json["namespaceId"];
    }
    if (_json.containsKey("projectId")) {
      projectId = _json["projectId"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (namespaceId != null) {
      _json["namespaceId"] = namespaceId;
    }
    if (projectId != null) {
      _json["projectId"] = projectId;
    }
    return _json;
  }
}

/**
 * A (kind, ID/name) pair used to construct a key path.
 *
 * If either name or ID is set, the element is complete.
 * If neither is set, the element is incomplete.
 */
class PathElement {
  /**
   * The auto-allocated ID of the entity.
   * Never equal to zero. Values less than zero are discouraged and may not
   * be supported in the future.
   */
  core.String id;
  /**
   * The kind of the entity.
   * A kind matching regex `__.*__` is reserved/read-only.
   * A kind must not contain more than 1500 bytes when UTF-8 encoded.
   * Cannot be `""`.
   */
  core.String kind;
  /**
   * The name of the entity.
   * A name matching regex `__.*__` is reserved/read-only.
   * A name must not be more than 1500 bytes when UTF-8 encoded.
   * Cannot be `""`.
   */
  core.String name;

  PathElement();

  PathElement.fromJson(core.Map _json) {
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

  core.Map toJson() {
    var _json = new core.Map();
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

/** A representation of a property in a projection. */
class Projection {
  /** The property to project. */
  PropertyReference property;

  Projection();

  Projection.fromJson(core.Map _json) {
    if (_json.containsKey("property")) {
      property = new PropertyReference.fromJson(_json["property"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (property != null) {
      _json["property"] = (property).toJson();
    }
    return _json;
  }
}

/** A filter on a specific property. */
class PropertyFilter {
  /**
   * The operator to filter by.
   * Possible string values are:
   * - "OPERATOR_UNSPECIFIED" : Unspecified. This value must not be used.
   * - "LESS_THAN" : Less than.
   * - "LESS_THAN_OR_EQUAL" : Less than or equal.
   * - "GREATER_THAN" : Greater than.
   * - "GREATER_THAN_OR_EQUAL" : Greater than or equal.
   * - "EQUAL" : Equal.
   * - "HAS_ANCESTOR" : Has ancestor.
   */
  core.String op;
  /** The property to filter by. */
  PropertyReference property;
  /** The value to compare the property to. */
  Value value;

  PropertyFilter();

  PropertyFilter.fromJson(core.Map _json) {
    if (_json.containsKey("op")) {
      op = _json["op"];
    }
    if (_json.containsKey("property")) {
      property = new PropertyReference.fromJson(_json["property"]);
    }
    if (_json.containsKey("value")) {
      value = new Value.fromJson(_json["value"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (op != null) {
      _json["op"] = op;
    }
    if (property != null) {
      _json["property"] = (property).toJson();
    }
    if (value != null) {
      _json["value"] = (value).toJson();
    }
    return _json;
  }
}

/** The desired order for a specific property. */
class PropertyOrder {
  /**
   * The direction to order by. Defaults to `ASCENDING`.
   * Possible string values are:
   * - "DIRECTION_UNSPECIFIED" : Unspecified. This value must not be used.
   * - "ASCENDING" : Ascending.
   * - "DESCENDING" : Descending.
   */
  core.String direction;
  /** The property to order by. */
  PropertyReference property;

  PropertyOrder();

  PropertyOrder.fromJson(core.Map _json) {
    if (_json.containsKey("direction")) {
      direction = _json["direction"];
    }
    if (_json.containsKey("property")) {
      property = new PropertyReference.fromJson(_json["property"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (direction != null) {
      _json["direction"] = direction;
    }
    if (property != null) {
      _json["property"] = (property).toJson();
    }
    return _json;
  }
}

/** A reference to a property relative to the kind expressions. */
class PropertyReference {
  /**
   * The name of the property.
   * If name includes "."s, it may be interpreted as a property name path.
   */
  core.String name;

  PropertyReference();

  PropertyReference.fromJson(core.Map _json) {
    if (_json.containsKey("name")) {
      name = _json["name"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (name != null) {
      _json["name"] = name;
    }
    return _json;
  }
}

/** A query for entities. */
class Query {
  /**
   * The properties to make distinct. The query results will contain the first
   * result for each distinct combination of values for the given properties
   * (if empty, all results are returned).
   */
  core.List<PropertyReference> distinctOn;
  /**
   * An ending point for the query results. Query cursors are
   * returned in query result batches and
   * [can only be used to limit the same
   * query](https://cloud.google.com/datastore/docs/concepts/queries#cursors_limits_and_offsets).
   */
  core.String endCursor;
  core.List<core.int> get endCursorAsBytes {
    return convert.BASE64.decode(endCursor);
  }

  void set endCursorAsBytes(core.List<core.int> _bytes) {
    endCursor = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /** The filter to apply. */
  Filter filter;
  /**
   * The kinds to query (if empty, returns entities of all kinds).
   * Currently at most 1 kind may be specified.
   */
  core.List<KindExpression> kind;
  /**
   * The maximum number of results to return. Applies after all other
   * constraints. Optional.
   * Unspecified is interpreted as no limit.
   * Must be >= 0 if specified.
   */
  core.int limit;
  /**
   * The number of results to skip. Applies before limit, but after all other
   * constraints. Optional. Must be >= 0 if specified.
   */
  core.int offset;
  /**
   * The order to apply to the query results (if empty, order is unspecified).
   */
  core.List<PropertyOrder> order;
  /** The projection to return. Defaults to returning all properties. */
  core.List<Projection> projection;
  /**
   * A starting point for the query results. Query cursors are
   * returned in query result batches and
   * [can only be used to continue the same
   * query](https://cloud.google.com/datastore/docs/concepts/queries#cursors_limits_and_offsets).
   */
  core.String startCursor;
  core.List<core.int> get startCursorAsBytes {
    return convert.BASE64.decode(startCursor);
  }

  void set startCursorAsBytes(core.List<core.int> _bytes) {
    startCursor = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  Query();

  Query.fromJson(core.Map _json) {
    if (_json.containsKey("distinctOn")) {
      distinctOn = _json["distinctOn"].map((value) => new PropertyReference.fromJson(value)).toList();
    }
    if (_json.containsKey("endCursor")) {
      endCursor = _json["endCursor"];
    }
    if (_json.containsKey("filter")) {
      filter = new Filter.fromJson(_json["filter"]);
    }
    if (_json.containsKey("kind")) {
      kind = _json["kind"].map((value) => new KindExpression.fromJson(value)).toList();
    }
    if (_json.containsKey("limit")) {
      limit = _json["limit"];
    }
    if (_json.containsKey("offset")) {
      offset = _json["offset"];
    }
    if (_json.containsKey("order")) {
      order = _json["order"].map((value) => new PropertyOrder.fromJson(value)).toList();
    }
    if (_json.containsKey("projection")) {
      projection = _json["projection"].map((value) => new Projection.fromJson(value)).toList();
    }
    if (_json.containsKey("startCursor")) {
      startCursor = _json["startCursor"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (distinctOn != null) {
      _json["distinctOn"] = distinctOn.map((value) => (value).toJson()).toList();
    }
    if (endCursor != null) {
      _json["endCursor"] = endCursor;
    }
    if (filter != null) {
      _json["filter"] = (filter).toJson();
    }
    if (kind != null) {
      _json["kind"] = kind.map((value) => (value).toJson()).toList();
    }
    if (limit != null) {
      _json["limit"] = limit;
    }
    if (offset != null) {
      _json["offset"] = offset;
    }
    if (order != null) {
      _json["order"] = order.map((value) => (value).toJson()).toList();
    }
    if (projection != null) {
      _json["projection"] = projection.map((value) => (value).toJson()).toList();
    }
    if (startCursor != null) {
      _json["startCursor"] = startCursor;
    }
    return _json;
  }
}

/** A batch of results produced by a query. */
class QueryResultBatch {
  /**
   * A cursor that points to the position after the last result in the batch.
   */
  core.String endCursor;
  core.List<core.int> get endCursorAsBytes {
    return convert.BASE64.decode(endCursor);
  }

  void set endCursorAsBytes(core.List<core.int> _bytes) {
    endCursor = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /**
   * The result type for every entity in `entity_results`.
   * Possible string values are:
   * - "RESULT_TYPE_UNSPECIFIED" : Unspecified. This value is never used.
   * - "FULL" : The key and properties.
   * - "PROJECTION" : A projected subset of properties. The entity may have no
   * key.
   * - "KEY_ONLY" : Only the key.
   */
  core.String entityResultType;
  /** The results for this batch. */
  core.List<EntityResult> entityResults;
  /**
   * The state of the query after the current batch.
   * Possible string values are:
   * - "MORE_RESULTS_TYPE_UNSPECIFIED" : Unspecified. This value is never used.
   * - "NOT_FINISHED" : There may be additional batches to fetch from this
   * query.
   * - "MORE_RESULTS_AFTER_LIMIT" : The query is finished, but there may be more
   * results after the limit.
   * - "MORE_RESULTS_AFTER_CURSOR" : The query is finished, but there may be
   * more results after the end
   * cursor.
   * - "NO_MORE_RESULTS" : The query has been exhausted.
   */
  core.String moreResults;
  /**
   * A cursor that points to the position after the last skipped result.
   * Will be set when `skipped_results` != 0.
   */
  core.String skippedCursor;
  core.List<core.int> get skippedCursorAsBytes {
    return convert.BASE64.decode(skippedCursor);
  }

  void set skippedCursorAsBytes(core.List<core.int> _bytes) {
    skippedCursor = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /** The number of results skipped, typically because of an offset. */
  core.int skippedResults;
  /**
   * The version number of the snapshot this batch was returned from.
   * This applies to the range of results from the query's `start_cursor` (or
   * the beginning of the query if no cursor was given) to this batch's
   * `end_cursor` (not the query's `end_cursor`).
   *
   * In a single transaction, subsequent query result batches for the same query
   * can have a greater snapshot version number. Each batch's snapshot version
   * is valid for all preceding batches.
   * The value will be zero for eventually consistent queries.
   */
  core.String snapshotVersion;

  QueryResultBatch();

  QueryResultBatch.fromJson(core.Map _json) {
    if (_json.containsKey("endCursor")) {
      endCursor = _json["endCursor"];
    }
    if (_json.containsKey("entityResultType")) {
      entityResultType = _json["entityResultType"];
    }
    if (_json.containsKey("entityResults")) {
      entityResults = _json["entityResults"].map((value) => new EntityResult.fromJson(value)).toList();
    }
    if (_json.containsKey("moreResults")) {
      moreResults = _json["moreResults"];
    }
    if (_json.containsKey("skippedCursor")) {
      skippedCursor = _json["skippedCursor"];
    }
    if (_json.containsKey("skippedResults")) {
      skippedResults = _json["skippedResults"];
    }
    if (_json.containsKey("snapshotVersion")) {
      snapshotVersion = _json["snapshotVersion"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (endCursor != null) {
      _json["endCursor"] = endCursor;
    }
    if (entityResultType != null) {
      _json["entityResultType"] = entityResultType;
    }
    if (entityResults != null) {
      _json["entityResults"] = entityResults.map((value) => (value).toJson()).toList();
    }
    if (moreResults != null) {
      _json["moreResults"] = moreResults;
    }
    if (skippedCursor != null) {
      _json["skippedCursor"] = skippedCursor;
    }
    if (skippedResults != null) {
      _json["skippedResults"] = skippedResults;
    }
    if (snapshotVersion != null) {
      _json["snapshotVersion"] = snapshotVersion;
    }
    return _json;
  }
}

/** The options shared by read requests. */
class ReadOptions {
  /**
   * The non-transactional read consistency to use.
   * Cannot be set to `STRONG` for global queries.
   * Possible string values are:
   * - "READ_CONSISTENCY_UNSPECIFIED" : Unspecified. This value must not be
   * used.
   * - "STRONG" : Strong consistency.
   * - "EVENTUAL" : Eventual consistency.
   */
  core.String readConsistency;
  /**
   * The identifier of the transaction in which to read. A
   * transaction identifier is returned by a call to
   * Datastore.BeginTransaction.
   */
  core.String transaction;
  core.List<core.int> get transactionAsBytes {
    return convert.BASE64.decode(transaction);
  }

  void set transactionAsBytes(core.List<core.int> _bytes) {
    transaction = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  ReadOptions();

  ReadOptions.fromJson(core.Map _json) {
    if (_json.containsKey("readConsistency")) {
      readConsistency = _json["readConsistency"];
    }
    if (_json.containsKey("transaction")) {
      transaction = _json["transaction"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (readConsistency != null) {
      _json["readConsistency"] = readConsistency;
    }
    if (transaction != null) {
      _json["transaction"] = transaction;
    }
    return _json;
  }
}

/** The request for Datastore.Rollback. */
class RollbackRequest {
  /**
   * The transaction identifier, returned by a call to
   * Datastore.BeginTransaction.
   */
  core.String transaction;
  core.List<core.int> get transactionAsBytes {
    return convert.BASE64.decode(transaction);
  }

  void set transactionAsBytes(core.List<core.int> _bytes) {
    transaction = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }

  RollbackRequest();

  RollbackRequest.fromJson(core.Map _json) {
    if (_json.containsKey("transaction")) {
      transaction = _json["transaction"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (transaction != null) {
      _json["transaction"] = transaction;
    }
    return _json;
  }
}

/**
 * The response for Datastore.Rollback.
 * (an empty message).
 */
class RollbackResponse {

  RollbackResponse();

  RollbackResponse.fromJson(core.Map _json) {
  }

  core.Map toJson() {
    var _json = new core.Map();
    return _json;
  }
}

/** The request for Datastore.RunQuery. */
class RunQueryRequest {
  /** The GQL query to run. */
  GqlQuery gqlQuery;
  /**
   * Entities are partitioned into subsets, identified by a partition ID.
   * Queries are scoped to a single partition.
   * This partition ID is normalized with the standard default context
   * partition ID.
   */
  PartitionId partitionId;
  /** The query to run. */
  Query query;
  /** The options for this query. */
  ReadOptions readOptions;

  RunQueryRequest();

  RunQueryRequest.fromJson(core.Map _json) {
    if (_json.containsKey("gqlQuery")) {
      gqlQuery = new GqlQuery.fromJson(_json["gqlQuery"]);
    }
    if (_json.containsKey("partitionId")) {
      partitionId = new PartitionId.fromJson(_json["partitionId"]);
    }
    if (_json.containsKey("query")) {
      query = new Query.fromJson(_json["query"]);
    }
    if (_json.containsKey("readOptions")) {
      readOptions = new ReadOptions.fromJson(_json["readOptions"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (gqlQuery != null) {
      _json["gqlQuery"] = (gqlQuery).toJson();
    }
    if (partitionId != null) {
      _json["partitionId"] = (partitionId).toJson();
    }
    if (query != null) {
      _json["query"] = (query).toJson();
    }
    if (readOptions != null) {
      _json["readOptions"] = (readOptions).toJson();
    }
    return _json;
  }
}

/** The response for Datastore.RunQuery. */
class RunQueryResponse {
  /** A batch of query results (always present). */
  QueryResultBatch batch;
  /** The parsed form of the `GqlQuery` from the request, if it was set. */
  Query query;

  RunQueryResponse();

  RunQueryResponse.fromJson(core.Map _json) {
    if (_json.containsKey("batch")) {
      batch = new QueryResultBatch.fromJson(_json["batch"]);
    }
    if (_json.containsKey("query")) {
      query = new Query.fromJson(_json["query"]);
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (batch != null) {
      _json["batch"] = (batch).toJson();
    }
    if (query != null) {
      _json["query"] = (query).toJson();
    }
    return _json;
  }
}

/**
 * A message that can hold any of the supported value types and associated
 * metadata.
 */
class Value {
  /**
   * An array value.
   * Cannot contain another array value.
   * A `Value` instance that sets field `array_value` must not set fields
   * `meaning` or `exclude_from_indexes`.
   */
  ArrayValue arrayValue;
  /**
   * A blob value.
   * May have at most 1,000,000 bytes.
   * When `exclude_from_indexes` is false, may have at most 1500 bytes.
   * In JSON requests, must be base64-encoded.
   */
  core.String blobValue;
  core.List<core.int> get blobValueAsBytes {
    return convert.BASE64.decode(blobValue);
  }

  void set blobValueAsBytes(core.List<core.int> _bytes) {
    blobValue = convert.BASE64.encode(_bytes).replaceAll("/", "_").replaceAll("+", "-");
  }
  /** A boolean value. */
  core.bool booleanValue;
  /** A double value. */
  core.double doubleValue;
  /**
   * An entity value.
   *
   * - May have no key.
   * - May have a key with an incomplete key path.
   * - May have a reserved/read-only key.
   */
  Entity entityValue;
  /**
   * If the value should be excluded from all indexes including those defined
   * explicitly.
   */
  core.bool excludeFromIndexes;
  /** A geo point value representing a point on the surface of Earth. */
  LatLng geoPointValue;
  /** An integer value. */
  core.String integerValue;
  /** A key value. */
  Key keyValue;
  /**
   * The `meaning` field should only be populated for backwards compatibility.
   */
  core.int meaning;
  /**
   * A null value.
   * Possible string values are:
   * - "NULL_VALUE" : Null value.
   */
  core.String nullValue;
  /**
   * A UTF-8 encoded string value.
   * When `exclude_from_indexes` is false (it is indexed) , may have at most
   * 1500 bytes.
   * Otherwise, may be set to at least 1,000,000 bytes.
   */
  core.String stringValue;
  /**
   * A timestamp value.
   * When stored in the Datastore, precise only to microseconds;
   * any additional precision is rounded down.
   */
  core.String timestampValue;

  Value();

  Value.fromJson(core.Map _json) {
    if (_json.containsKey("arrayValue")) {
      arrayValue = new ArrayValue.fromJson(_json["arrayValue"]);
    }
    if (_json.containsKey("blobValue")) {
      blobValue = _json["blobValue"];
    }
    if (_json.containsKey("booleanValue")) {
      booleanValue = _json["booleanValue"];
    }
    if (_json.containsKey("doubleValue")) {
      doubleValue = _json["doubleValue"];
    }
    if (_json.containsKey("entityValue")) {
      entityValue = new Entity.fromJson(_json["entityValue"]);
    }
    if (_json.containsKey("excludeFromIndexes")) {
      excludeFromIndexes = _json["excludeFromIndexes"];
    }
    if (_json.containsKey("geoPointValue")) {
      geoPointValue = new LatLng.fromJson(_json["geoPointValue"]);
    }
    if (_json.containsKey("integerValue")) {
      integerValue = _json["integerValue"];
    }
    if (_json.containsKey("keyValue")) {
      keyValue = new Key.fromJson(_json["keyValue"]);
    }
    if (_json.containsKey("meaning")) {
      meaning = _json["meaning"];
    }
    if (_json.containsKey("nullValue")) {
      nullValue = _json["nullValue"];
    }
    if (_json.containsKey("stringValue")) {
      stringValue = _json["stringValue"];
    }
    if (_json.containsKey("timestampValue")) {
      timestampValue = _json["timestampValue"];
    }
  }

  core.Map toJson() {
    var _json = new core.Map();
    if (arrayValue != null) {
      _json["arrayValue"] = (arrayValue).toJson();
    }
    if (blobValue != null) {
      _json["blobValue"] = blobValue;
    }
    if (booleanValue != null) {
      _json["booleanValue"] = booleanValue;
    }
    if (doubleValue != null) {
      _json["doubleValue"] = doubleValue;
    }
    if (entityValue != null) {
      _json["entityValue"] = (entityValue).toJson();
    }
    if (excludeFromIndexes != null) {
      _json["excludeFromIndexes"] = excludeFromIndexes;
    }
    if (geoPointValue != null) {
      _json["geoPointValue"] = (geoPointValue).toJson();
    }
    if (integerValue != null) {
      _json["integerValue"] = integerValue;
    }
    if (keyValue != null) {
      _json["keyValue"] = (keyValue).toJson();
    }
    if (meaning != null) {
      _json["meaning"] = meaning;
    }
    if (nullValue != null) {
      _json["nullValue"] = nullValue;
    }
    if (stringValue != null) {
      _json["stringValue"] = stringValue;
    }
    if (timestampValue != null) {
      _json["timestampValue"] = timestampValue;
    }
    return _json;
  }
}
