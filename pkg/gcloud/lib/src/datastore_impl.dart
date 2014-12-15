// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library gcloud.datastore_impl;

import 'dart:async';

import 'package:http/http.dart' as http;

import '../datastore.dart' as datastore;
import '../common.dart' show Page;
import 'package:googleapis_beta/datastore/v1beta2.dart' as api;

class TransactionImpl implements datastore.Transaction {
  final String data;
  TransactionImpl(this.data);
}

class DatastoreImpl implements datastore.Datastore {
  static const List<String> SCOPES = const <String>[
      api.DatastoreApi.DatastoreScope,
      api.DatastoreApi.UserinfoEmailScope,
  ];

  final api.DatastoreApi _api;
  final String _project;

  DatastoreImpl(http.Client client, this._project)
      : _api = new api.DatastoreApi(client);

  api.Key _convertDatastore2ApiKey(datastore.Key key) {
    var apiKey = new api.Key();

    apiKey.partitionId = new api.PartitionId()
        ..datasetId = _project
        ..namespace = key.partition.namespace;

    apiKey.path = key.elements.map((datastore.KeyElement element) {
      var part = new api.KeyPathElement();
      part.kind = element.kind;
      if (element.id is int) {
        part.id = '${element.id}';
      } else if (element.id is String) {
        part.name = element.id;
      }
      return part;
    }).toList();

    return apiKey;
  }

  static datastore.Key _convertApi2DatastoreKey(api.Key key) {
    var elements = key.path.map((api.KeyPathElement element) {
      if (element.id != null) {
        return new datastore.KeyElement(element.kind, int.parse(element.id));
      } else if (element.name != null) {
        return new datastore.KeyElement(element.kind, element.name);
      } else {
        throw new datastore.DatastoreError(
            'Invalid server response: Expected allocated name/id.');
      }
    }).toList();

    var partition;
    if (key.partitionId != null) {
      partition = new datastore.Partition(key.partitionId.namespace);
      // TODO: assert projectId.
    }
    return new datastore.Key(elements, partition: partition);
  }

  bool _compareApiKey(api.Key a, api.Key b) {
    if (a.path.length != b.path.length) return false;

    // FIXME(Issue #2): Is this comparison working correctly?
    if (a.partitionId != null) {
      if (b.partitionId == null) return false;
      if (a.partitionId.datasetId != b.partitionId.datasetId) return false;
      if (a.partitionId.namespace != b.partitionId.namespace) return false;
    } else {
      if (b.partitionId != null) return false;
    }

    for (int i = 0; i < a.path.length; i++) {
      if (a.path[i].id != b.path[i].id ||
          a.path[i].name != b.path[i].name ||
          a.path[i].kind != b.path[i].kind) return false;
    }
    return true;
  }

  static _convertApi2DatastorePropertyValue(api.Value value) {
    if (value.booleanValue != null)
      return value.booleanValue;
    else if (value.integerValue != null)
      return int.parse(value.integerValue);
    else if (value.doubleValue != null)
      return value.doubleValue;
    else if (value.stringValue != null)
      return value.stringValue;
    else if (value.dateTimeValue != null)
      return value.dateTimeValue;
    else if (value.blobValue != null)
      return new datastore.BlobValue(value.blobValueAsBytes);
    else if (value.keyValue != null)
      return _convertApi2DatastoreKey(value.keyValue);
    else if (value.listValue != null)
      // FIXME(Issue #3): Consistently handle exceptions.
      throw new Exception('Cannot have lists inside lists.');
    else if (value.blobKeyValue != null)
      throw new UnsupportedError('Blob keys are not supported.');
    else if (value.entityValue != null)
      throw new UnsupportedError('Entity values are not supported.');
    return null;
  }

  api.Value _convertDatastore2ApiPropertyValue(
      value, bool indexed, {bool lists: true}) {
    var apiValue = new api.Value()
        ..indexed = indexed;
    if (value == null) {
      return apiValue;
    } else if (value is bool) {
      return apiValue
          ..booleanValue = value;
    } else if (value is int) {
      return apiValue
          ..integerValue = '$value';
    } else if (value is double) {
      return apiValue
          ..doubleValue = value;
    } else if (value is String) {
      return apiValue
          ..stringValue = value;
    } else if (value is DateTime) {
      return apiValue
          ..dateTimeValue = value;
    } else if (value is datastore.BlobValue) {
      return apiValue
          ..blobValueAsBytes = value.bytes;
    } else if (value is datastore.Key) {
      return apiValue
          ..keyValue = _convertDatastore2ApiKey(value);
    } else if (value is List) {
      if (!lists) {
        // FIXME(Issue #3): Consistently handle exceptions.
        throw new Exception('List values are not allowed.');
      }

      convertItem(i)
          => _convertDatastore2ApiPropertyValue(i, indexed, lists: false);

      return new api.Value()
          ..listValue = value.map(convertItem).toList();
    } else {
      throw new UnsupportedError(
          'Types ${value.runtimeType} cannot be used for serializing.');
    }
  }

  static _convertApi2DatastoreProperty(api.Property property) {
    if (property.booleanValue != null)
      return property.booleanValue;
    else if (property.integerValue != null)
      return int.parse(property.integerValue);
    else if (property.doubleValue != null)
      return property.doubleValue;
    else if (property.stringValue != null)
      return property.stringValue;
    else if (property.dateTimeValue != null)
      return property.dateTimeValue;
    else if (property.blobValue != null)
      return new datastore.BlobValue(property.blobValueAsBytes);
    else if (property.keyValue != null)
      return _convertApi2DatastoreKey(property.keyValue);
    else if (property.listValue != null)
      return
          property.listValue.map(_convertApi2DatastorePropertyValue).toList();
    else if (property.blobKeyValue != null)
      throw new UnsupportedError('Blob keys are not supported.');
    else if (property.entityValue != null)
      throw new UnsupportedError('Entity values are not supported.');
    return null;
  }

  api.Property _convertDatastore2ApiProperty(
      value, bool indexed, {bool lists: true}) {
    var apiProperty = new api.Property()
        ..indexed = indexed;
    if (value == null) {
      return null;
    } else if (value is bool) {
      return apiProperty
          ..booleanValue = value;
    } else if (value is int) {
      return apiProperty
          ..integerValue = '$value';
    } else if (value is double) {
      return apiProperty
          ..doubleValue = value;
    } else if (value is String) {
      return apiProperty
          ..stringValue = value;
    } else if (value is DateTime) {
      return apiProperty
          ..dateTimeValue = value;
    } else if (value is datastore.BlobValue) {
      return apiProperty
          ..blobValueAsBytes = value.bytes;
    } else if (value is datastore.Key) {
      return apiProperty
          ..keyValue = _convertDatastore2ApiKey(value);
    } else if (value is List) {
      if (!lists) {
        // FIXME(Issue #3): Consistently handle exceptions.
        throw new Exception('List values are not allowed.');
      }
      convertItem(i)
          => _convertDatastore2ApiPropertyValue(i, indexed, lists: false);
      return new api.Property()..listValue = value.map(convertItem).toList();
    } else {
      throw new UnsupportedError(
          'Types ${value.runtimeType} cannot be used for serializing.');
    }
  }

  static datastore.Entity _convertApi2DatastoreEntity(api.Entity entity) {
    var unindexedProperties = new Set();
    var properties = {};

    if (entity.properties != null) {
      entity.properties.forEach((String name, api.Property property) {
        properties[name] = _convertApi2DatastoreProperty(property);
        if (property.indexed == false) {
          // TODO(Issue #$4): Should we support mixed indexed/non-indexed list
          // values?
          if (property.listValue != null) {
            if (property.listValue.length > 0) {
              var firstIndexed = property.listValue.first.indexed;
              for (int i = 1; i < property.listValue.length; i++) {
                if (property.listValue[i].indexed != firstIndexed) {
                  throw new Exception('Some list entries are indexed and some '
                      'are not. This is currently not supported.');
                }
              }
              if (firstIndexed == false) {
                unindexedProperties.add(name);
              }
            }
          } else {
            unindexedProperties.add(name);
          }
        }
      });
    }
    return new datastore.Entity(_convertApi2DatastoreKey(entity.key),
                                properties,
                                unIndexedProperties: unindexedProperties);
  }

  api.Entity _convertDatastore2ApiEntity(datastore.Entity entity) {
    var apiEntity = new api.Entity();

    apiEntity.key  = _convertDatastore2ApiKey(entity.key);
    apiEntity.properties = {};
    if (entity.properties != null) {
      for (var key in entity.properties.keys) {
        var value = entity.properties[key];
        bool indexed = false;
        if (entity.unIndexedProperties != null) {
          indexed = !entity.unIndexedProperties.contains(key);
        }
        var property = _convertDatastore2ApiPropertyValue(value, indexed);
        apiEntity.properties[key] = property;
      }
    }
    return apiEntity;
  }

  static Map<datastore.FilterRelation, String> relationMapping = const {
    datastore.FilterRelation.LessThan: 'LESS_THAN',
    datastore.FilterRelation.LessThanOrEqual: 'LESS_THAN_OR_EQUAL',
    datastore.FilterRelation.Equal: 'EQUAL',
    datastore.FilterRelation.GreatherThan: 'GREATER_THAN',
    datastore.FilterRelation.GreatherThanOrEqual: 'GREATER_THAN_OR_EQUAL',
    // TODO(Issue #5): IN operator not supported currently.
  };

  api.Filter _convertDatastore2ApiFilter(datastore.Filter filter) {
    var pf = new api.PropertyFilter();
    var operator = relationMapping[filter.relation];
    // FIXME(Issue #5): Is this OK?
    if (filter.relation == datastore.FilterRelation.In) {
      operator = 'EQUAL';
    }

    if (operator == null) {
      throw new ArgumentError('Unknown filter relation: ${filter.relation}.');
    }
    pf.operator = operator;
    pf.property = new api.PropertyReference()..name = filter.name;

    // FIXME(Issue #5): Is this OK?
    var value = filter.value;
    if (filter.relation == datastore.FilterRelation.In) {
      if (value is List && value.length == 1) {
        value = value.first;
      } else {
        throw new ArgumentError('List values not supported');
      }
    }

    pf.value = _convertDatastore2ApiPropertyValue(value, true, lists: false);
    return new api.Filter()..propertyFilter = pf;
  }

  api.Filter _convertDatastoreAncestorKey2ApiFilter(datastore.Key key) {
    var pf = new api.PropertyFilter();
    pf.operator = 'HAS_ANCESTOR';
    pf.property = new api.PropertyReference()..name = '__key__';
    pf.value = new api.Value()..keyValue = _convertDatastore2ApiKey(key);
    return new api.Filter()..propertyFilter = pf;
  }

  api.Filter _convertDatastore2ApiFilters(List<datastore.Filter> filters,
                                          datastore.Key ancestorKey) {
    if ((filters == null || filters.length == 0) && ancestorKey == null) {
      return null;
    }

    var compFilter = new api.CompositeFilter();
    if (filters != null) {
      compFilter.filters = filters.map(_convertDatastore2ApiFilter).toList();
    }
    if (ancestorKey != null) {
      var filter = _convertDatastoreAncestorKey2ApiFilter(ancestorKey);
      if (compFilter.filters == null) {
        compFilter.filters = [filter];
      } else {
        compFilter.filters.add(filter);
      }
    }
    compFilter.operator = 'AND';
    return new api.Filter()..compositeFilter = compFilter;
  }

  api.PropertyOrder _convertDatastore2ApiOrder(datastore.Order order) {
    var property = new api.PropertyReference()..name = order.propertyName;
    var direction = order.direction == datastore.OrderDirection.Ascending
        ? 'ASCENDING' : 'DESCENDING';
    return new api.PropertyOrder()
        ..direction = direction
        ..property = property;
  }

  List<api.PropertyOrder> _convertDatastore2ApiOrders(
      List<datastore.Order> orders) {
    if (orders == null) return null;

    return orders.map(_convertDatastore2ApiOrder).toList();
  }

  static Future _handleError(error, stack) {
    if (error is api.DetailedApiRequestError) {
      if (error.status == 400) {
        return new Future.error(
            new datastore.ApplicationError(error.message), stack);
      } else if (error.status == 409) {
        // NOTE: This is reported as:
        // "too much contention on these datastore entities"
        // TODO:
        return new Future.error(new datastore.TransactionAbortedError(), stack);
      } else if (error.status == 412) {
        return  new Future.error(new datastore.NeedIndexError(), stack);
      }
    }
    return new Future.error(error, stack);
  }

  Future<List<datastore.Key>> allocateIds(List<datastore.Key> keys) {
    var request = new api.AllocateIdsRequest();
    request..keys = keys.map(_convertDatastore2ApiKey).toList();
    return _api.datasets.allocateIds(request, _project).then((response) {
      return response.keys.map(_convertApi2DatastoreKey).toList();
    }, onError: _handleError);
  }

  Future<datastore.Transaction> beginTransaction(
      {bool crossEntityGroup: false}) {
    var request = new api.BeginTransactionRequest();
    // TODO: Should this be made configurable?
    request.isolationLevel = 'SERIALIZABLE';
    return _api.datasets.beginTransaction(request, _project).then((result) {
      return new TransactionImpl(result.transaction);
    }, onError: _handleError);
  }

  Future<datastore.CommitResult> commit({List<datastore.Entity> inserts,
                                         List<datastore.Entity> autoIdInserts,
                                         List<datastore.Key> deletes,
                                         datastore.Transaction transaction}) {
    var request = new api.CommitRequest();

    if (transaction != null) {
      request.mode = 'TRANSACTIONAL';
      request.transaction = (transaction as TransactionImpl).data;
    } else {
      request.mode = 'NON_TRANSACTIONAL';
    }

    request.mutation = new api.Mutation();
    if (inserts != null) {
      request.mutation.upsert = new List(inserts.length);
      for (int i = 0; i < inserts.length; i++) {
        request.mutation.upsert[i] = _convertDatastore2ApiEntity(inserts[i]);
      }
    }
    if (autoIdInserts != null) {
      request.mutation.insertAutoId = new List(autoIdInserts.length);
      for (int i = 0; i < autoIdInserts.length; i++) {
        request.mutation.insertAutoId[i] =
            _convertDatastore2ApiEntity(autoIdInserts[i]);
      }
    }
    if (deletes != null) {
      request.mutation.delete = new List(deletes.length);
      for (int i = 0; i < deletes.length; i++) {
        request.mutation.delete[i] = _convertDatastore2ApiKey(deletes[i]);
      }
    }
    return _api.datasets.commit(request, _project).then((result) {
      var keys;
      if (autoIdInserts != null && autoIdInserts.length > 0) {
        keys = result
          .mutationResult
          .insertAutoIdKeys
          .map(_convertApi2DatastoreKey).toList();
      }
      return new datastore.CommitResult(keys);
    }, onError: _handleError);
  }

  Future<List<datastore.Entity>> lookup(List<datastore.Key> keys,
                                        {datastore.Transaction transaction}) {
    var apiKeys = keys.map(_convertDatastore2ApiKey).toList();
    var request = new api.LookupRequest();
    request.keys = apiKeys;
    if (transaction != null) {
      // TODO: Make readOptions more configurable.
      request.readOptions = new api.ReadOptions();
      request.readOptions.transaction = (transaction as TransactionImpl).data;
    }
    return _api.datasets.lookup(request, _project).then((response) {
      if (response.deferred != null && response.deferred.length > 0) {
        throw new datastore.DatastoreError(
            'Could not successfully look up all keys due to resource '
            'constraints.');
      }

      // NOTE: This is worst-case O(n^2)!
      // Maybe we can optimize this somehow. But the API says:
      //  message LookupResponse {
      //    // The order of results in these fields is undefined and has no relation to
      //    // the order of the keys in the input.
      //
      //    // Entities found as ResultType.FULL entities.
      //    repeated EntityResult found = 1;
      //
      //    // Entities not found as ResultType.KEY_ONLY entities.
      //    repeated EntityResult missing = 2;
      //
      //    // A list of keys that were not looked up due to resource constraints.
      //    repeated Key deferred = 3;
      //  }
      var entities = new List(apiKeys.length);
      for (int i = 0; i < apiKeys.length; i++) {
        var apiKey = apiKeys[i];

        bool found = false;

        if (response.found != null) {
          for (var result in response.found) {
            if (_compareApiKey(apiKey, result.entity.key)) {
              entities[i] = _convertApi2DatastoreEntity(result.entity);
              found = true;
              break;
            }
          }
        }

        if (found) continue;

        if (response.missing != null) {
          for (var result in response.missing) {
            if (_compareApiKey(apiKey, result.entity.key)) {
              entities[i] = null;
              found = true;
              break;
            }
          }
        }

        if (!found) {
          throw new datastore.DatastoreError('Invalid server response: '
              'Tried to lookup ${apiKey.toJson()} but entity was neither in '
              'missing nor in found.');
        }
      }
      return entities;
    }, onError: _handleError);
  }

  Future<Page<datastore.Entity>> query(
      datastore.Query query, {datastore.Partition partition,
                              datastore.Transaction transaction}) {
    // NOTE: We explicitly do not set 'limit' here, since this is handled by
    // QueryPageImpl.runQuery.
    var apiQuery = new api.Query()
        ..filter = _convertDatastore2ApiFilters(query.filters,
                                                query.ancestorKey)
        ..order = _convertDatastore2ApiOrders(query.orders)
        ..offset = query.offset;

    if (query.kind != null) {
      apiQuery.kinds = [new api.KindExpression()..name = query.kind];
    }

    var request = new api.RunQueryRequest();
    request.query = apiQuery;
    if (transaction != null) {
      // TODO: Make readOptions more configurable.
      request.readOptions = new api.ReadOptions();
      request.readOptions.transaction = (transaction as TransactionImpl).data;
    }
    if (partition != null) {
      request.partitionId = new api.PartitionId()
          ..namespace = partition.namespace;
    }

    return QueryPageImpl.runQuery(_api, _project, request, query.limit)
        .catchError(_handleError);
  }

  Future rollback(datastore.Transaction transaction) {
    // TODO: Handle [transaction]
    var request = new api.RollbackRequest()
        ..transaction = (transaction as TransactionImpl).data;
    return _api.datasets.rollback(request, _project).catchError(_handleError);
  }
}

class QueryPageImpl implements Page<datastore.Entity> {
  static const int MAX_ENTITIES_PER_RESPONSE = 2000;

  final api.DatastoreApi _api;
  final String _project;
  final api.RunQueryRequest _nextRequest;
  final List<datastore.Entity> _entities;
  final bool _isLast;

  // This might be `null` in which case we request as many as we can get.
  final int _remainingNumberOfEntities;

  QueryPageImpl(this._api, this._project,
                this._nextRequest, this._entities,
                this._isLast, this._remainingNumberOfEntities);

  static Future<QueryPageImpl> runQuery(api.DatastoreApi api,
                                        String project,
                                        api.RunQueryRequest request,
                                        int limit,
                                        {int batchSize}) {
    int batchLimit = batchSize;
    if (batchLimit == null) {
      batchLimit = MAX_ENTITIES_PER_RESPONSE;
    }
    if (limit != null && limit < batchLimit) {
      batchLimit = limit;
    }

    request.query.limit = batchLimit;

    return api.datasets.runQuery(request, project).then((response) {
      var returnedEntities = const [];

      var batch = response.batch;
      if (batch.entityResults != null) {
        returnedEntities = batch.entityResults
            .map((result) => result.entity)
            .map(DatastoreImpl._convertApi2DatastoreEntity)
            .toList();
      }

      // This check is only necessary for the first request/response pair
      // (if offset was supplied).
      if (request.query.offset != null &&
          request.query.offset > 0 &&
          request.query.offset != response.batch.skippedResults) {
        throw new datastore.DatastoreError(
            'Server did not skip over the specified ${request.query.offset} '
            'entities.');
      }

      if (limit != null && returnedEntities.length > limit) {
        throw new datastore.DatastoreError(
            'Server returned more entities then the limit for the request'
            '(${request.query.limit}) was.');
      }


      // FIXME: TODO: Big hack!
      // It looks like Apiary/Atlas is currently broken.
      /*
      if (limit != null &&
          returnedEntities.length < batchLimit &&
          response.batch.moreResults == 'MORE_RESULTS_AFTER_LIMIT') {
        throw new datastore.DatastoreError(
            'Server returned response with less entities then the limit was, '
            'but signals there are more results after the limit.');
      }
      */

      // In case a limit was specified, we need to subtraction the number of
      // entities we already got.
      // (the checks above guarantee that this subraction is >= 0).
      int remainingEntities;
      if (limit != null) {
        remainingEntities = limit - returnedEntities.length;
      }

      // If the server signals there are more entities and we either have no
      // limit or our limit has not been reached, we set `moreBatches` to
      // `true`.
      bool moreBatches =
          (remainingEntities == null || remainingEntities > 0) &&
          response.batch.moreResults == 'MORE_RESULTS_AFTER_LIMIT';

      bool gotAll = limit != null && remainingEntities == 0;
      bool noMore = response.batch.moreResults == 'NO_MORE_RESULTS';
      bool isLast = gotAll || noMore;

      // As a sanity check, we assert that `moreBatches XOR isLast`.
      assert (isLast != moreBatches);

      // FIXME: TODO: Big hack!
      // It looks like Apiary/Atlas is currently broken.
      if (moreBatches && returnedEntities.length == 0) {
        print('Warning: Api to Google Cloud Datastore returned bogus response. '
              'Trying a workaround.');
        isLast = true;
        moreBatches = false;
      }

      if (!isLast && response.batch.endCursor == null) {
        throw new datastore.DatastoreError(
            'Server did not supply an end cursor, even though the query '
            'is not done.');
      }

      if (isLast) {
        return new QueryPageImpl(
            api, project, request, returnedEntities, true, null);
      } else {
        // NOTE: We reuse the old RunQueryRequest object here .

        // The offset will be 0 from now on, since the first request will have
        // skipped over the first `offset` results.
        request.query.offset = 0;

        // Furthermore we set the startCursor to the endCursor of the previous
        // result batch, so we can continue where we left off.
        request.query.startCursor = batch.endCursor;

        return new QueryPageImpl(
            api, project, request, returnedEntities, false, remainingEntities);
      }
    });
  }

  bool get isLast => _isLast;

  List<datastore.Entity> get items => _entities;

  Future<Page<datastore.Entity>> next({int pageSize}) {
    // NOTE: We do not respect [pageSize] here, the only mechanism we can
    // really use is `query.limit`, but this is user-specified when making
    // the query.
    if (isLast) {
      return new Future.sync(() {
        throw new ArgumentError('Cannot call next() on last page.');
      });
    }

    return QueryPageImpl.runQuery(
        _api, _project, _nextRequest, _remainingNumberOfEntities)
        .catchError(DatastoreImpl._handleError);
  }
}
