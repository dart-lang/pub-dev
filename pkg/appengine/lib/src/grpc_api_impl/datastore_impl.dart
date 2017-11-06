// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library grpc_datastore;

import 'dart:async';

import 'package:gcloud/common.dart';
import 'package:gcloud/datastore.dart' as raw;

import '../errors.dart' as errors;
import '../grpc_api/datastore_api.dart';
import 'grpc.dart' as grpc;

const List<String> OAuth2Scopes = const <String>[
  "https://www.googleapis.com/auth/cloud-platform",
  "https://www.googleapis.com/auth/datastore",
];

// TODO(kustermann): Currently we only convert service specific errors to
// different exceptions (e.g. transaction aborted).
// Maybe we want to wrap all grpc.BaseException exceptions and convert them to
// appengine specific ones.
class GrpcDatastoreImpl implements raw.Datastore {
  final DatastoreApi _clientRPCStub;
  final _Codec _codec;
  final String _projectId;

  GrpcDatastoreImpl(grpc.Client client, String project)
      : _clientRPCStub =
            new DatastoreApi(new grpc.Channel('google.datastore.v1', client)),
        _codec = new _Codec(project),
        _projectId = project;

  Future<List<raw.Key>> allocateIds(List<raw.Key> keys) async {
    final request = new AllocateIdsRequest()..projectId = _projectId;
    request.keys
        .addAll(keys.map((key) => _codec.encodeKey(key, enforceId: false)));
    try {
      final response = await _clientRPCStub.allocateIds(null, request);
      return response.keys.map(_codec.decodeKey).toList();
    } on grpc.RpcException catch (_) {
      rethrow;
    }
  }

  Future<raw.Transaction> beginTransaction(
      {bool crossEntityGroup: false}) async {
    final request = new BeginTransactionRequest()..projectId = _projectId;

    try {
      final response = await _clientRPCStub.beginTransaction(null, request);
      return new _TransactionImpl(response.transaction);
    } on grpc.RpcException catch (_) {
      rethrow;
    }
  }

  Future<raw.CommitResult> commit(
      {List<raw.Entity> inserts,
      List<raw.Entity> autoIdInserts,
      List<raw.Key> deletes,
      raw.Transaction transaction}) async {
    final request = new CommitRequest()..projectId = _projectId;

    if (transaction != null) {
      request.transaction = (transaction as _TransactionImpl)._rpcTransaction;
      request.mode = CommitRequest_Mode.TRANSACTIONAL;
    } else {
      request.mode = CommitRequest_Mode.NON_TRANSACTIONAL;
    }

    if (autoIdInserts != null) {
      for (final raw.Entity insert in autoIdInserts) {
        request.mutations.add(new Mutation()
          ..insert = _codec.encodeEntity(insert, enforceId: false));
      }
    }
    if (inserts != null) {
      for (final raw.Entity insert in inserts) {
        request.mutations
            .add(new Mutation()..upsert = _codec.encodeEntity(insert));
      }
    }
    if (deletes != null) {
      for (final raw.Key delete in deletes) {
        request.mutations
            .add(new Mutation()..delete = _codec.encodeKey(delete));
      }
    }
    try {
      final CommitResponse response =
          await _clientRPCStub.commit(null, request);

      var allocatedKeys;
      if (autoIdInserts?.isNotEmpty ?? false) {
        allocatedKeys = new List<raw.Key>.generate(autoIdInserts.length, (i) {
          return _codec.decodeKey(response.mutationResults[i].key);
        });
      }
      return new raw.CommitResult(allocatedKeys);
    } on grpc.RpcException catch (error) {
      if (error.code == grpc.ErrorCode.Aborted) {
        throw new raw.TransactionAbortedError();
      } else if (error.code == grpc.ErrorCode.InvalidArgument) {
        throw new raw.ApplicationError(error.message);
      } else {
        rethrow;
      }
    }
  }

  Future rollback(raw.Transaction transaction) async {
    final request = new RollbackRequest()
      ..projectId = _projectId
      ..transaction = (transaction as _TransactionImpl)._rpcTransaction;

    try {
      await _clientRPCStub.rollback(null, request);
    } on grpc.RpcException catch (_) {
      rethrow;
    }
  }

  Future<List<raw.Entity>> lookup(List<raw.Key> keys,
      {raw.Transaction transaction}) async {
    final request = new LookupRequest()..projectId = _projectId;

    request.readOptions = new ReadOptions()
      ..readConsistency = ReadOptions_ReadConsistency.STRONG;
    if (transaction != null) {
      request.readOptions
        ..transaction = (transaction as _TransactionImpl)._rpcTransaction;
    }

    request.keys
        .addAll(keys.map((key) => _codec.encodeKey(key, enforceId: true)));

    try {
      final LookupResponse response =
          await _clientRPCStub.lookup(null, request);
      if (response.deferred != null && response.deferred.length > 0) {
        throw new raw.DatastoreError(
            'Could not successfully look up all keys due to resource '
            'constraints.');
      }

      final Map<Key, raw.Entity> entityLookupResult = <Key, raw.Entity>{};
      if (response.found != null) {
        for (final result in response.found) {
          entityLookupResult[result.entity.key] =
              _codec.decodeEntity(result.entity);
        }
      }
      if (response.missing != null) {
        for (final result in response.missing) {
          entityLookupResult[result.entity.key] = null;
        }
      }
      final entities = new List<raw.Entity>(request.keys.length);
      for (int i = 0; i < request.keys.length; i++) {
        final key = request.keys[i];
        // The key needs to be in the map, but it's value might be `null`.
        if (!entityLookupResult.containsKey(key)) {
          throw new raw.DatastoreError('Invalid server response: '
              'Tried to lookup ${key} but entity was neither in '
              'missing nor in found.\n$response');
        }

        entities[i] = entityLookupResult[key];
      }
      return entities;
    } on grpc.RpcException catch (_) {
      rethrow;
    }
  }

  Future<Page<raw.Entity>> query(raw.Query query,
      {raw.Partition partition, raw.Transaction transaction}) async {
    final request = new RunQueryRequest()..projectId = _projectId;

    if (transaction != null) {
      request.readOptions = new ReadOptions()
        ..transaction = (transaction as _TransactionImpl)._rpcTransaction
        ..readConsistency = ReadOptions_ReadConsistency.STRONG;
    }

    if (partition != null && partition.namespace != null) {
      request.partitionId = new PartitionId()
        ..projectId = _projectId
        ..namespaceId = partition.namespace;
    }

    final pbQuery = new Query();
    if (query.kind != null) {
      pbQuery.kind.add(new KindExpression()..name = query.kind);
    }
    if (query.offset != null) pbQuery.offset = query.offset;
    if (query.limit != null)
      pbQuery.limit = new Int32Value()..value = query.limit;

    // Build a list of property and ancestor query filters. The entries in this
    // list will be combined with an AND filter.
    final List<Filter> filters = <Filter>[];
    if (query.filters != null && query.filters.length > 0) {
      for (final filter in query.filters) {
        final operation = _Codec.FILTER_RELATION_MAPPING[filter.relation];
        final value = filter.value;
        final pbPropertyFilter = new PropertyFilter()
          ..property = (new PropertyReference()..name = filter.name)
          ..op = operation
          ..value = _codec.encodeValue(value);
        final pbFilter = new Filter()..propertyFilter = pbPropertyFilter;
        filters.add(pbFilter);
      }
    }
    if (query.ancestorKey != null) {
      final ancestorKey = _codec.encodeKey(query.ancestorKey, enforceId: true);
      final pbPropertyFilter = new PropertyFilter()
        ..property = (new PropertyReference()..name = '__key__')
        ..op = PropertyFilter_Operator.HAS_ANCESTOR
        ..value = (new Value()..keyValue = ancestorKey);
      final pbFilter = new Filter()..propertyFilter = pbPropertyFilter;

      filters.add(pbFilter);
    }
    if (filters.length == 1) {
      pbQuery.filter = filters[0];
    } else if (filters.length > 1) {
      final compositeFilter = new CompositeFilter()
        ..op = CompositeFilter_Operator.AND
        ..filters.addAll(filters);
      pbQuery.filter = new Filter()..compositeFilter = compositeFilter;
    }

    if (query.orders != null) {
      for (final order in query.orders) {
        final pbOrder = new PropertyOrder()
          ..property = (new PropertyReference()..name = order.propertyName)
          ..direction = order.direction == raw.OrderDirection.Ascending
              ? PropertyOrder_Direction.ASCENDING
              : PropertyOrder_Direction.DESCENDING;
        pbQuery.order.add(pbOrder);
      }
    }

    request.query = pbQuery;

    try {
      final RunQueryResponse response =
          await _clientRPCStub.runQuery(null, request);
      final QueryResultBatch batch = response.batch;
      return _QueryPageImpl.fromQueryResult(
          request, _clientRPCStub, _codec, query.offset, 0, query.limit, batch);
    } on grpc.RpcException catch (_) {
      rethrow;
    }
  }
}

class _QueryPageImpl implements Page<raw.Entity> {
  final RunQueryRequest _request;
  final DatastoreApi _clientRPCStub;
  final _Codec _codec;
  final List<int> _cursor;

  final List<raw.Entity> _entities;
  final bool _isLast;

  // This is `Query.offset` and will be carried across page walking.
  final int _offset;

  // This is always non-`null` and contains the number of entities that were
  // skiped so far.
  final int _alreadySkipped;

  // If not `null` this will hold the remaining number of entities we are
  // allowed to receive according to `Query.limit`.
  final int _remainingNumberOfEntities;

  _QueryPageImpl(
      this._request,
      this._clientRPCStub,
      this._codec,
      this._cursor,
      this._entities,
      this._isLast,
      this._offset,
      this._alreadySkipped,
      this._remainingNumberOfEntities);

  static _QueryPageImpl fromQueryResult(
      RunQueryRequest request,
      DatastoreApi clientRPCStub,
      _Codec codec,
      int offset,
      int alreadySkipped,
      int remainingNumberOfEntities,
      QueryResultBatch batch) {
    // If we have an offset: Check that in total we haven't skipped too many.
    if (offset != null &&
        offset > 0 &&
        batch.hasSkippedResults() &&
        batch.skippedResults > (offset - alreadySkipped)) {
      throw new raw.DatastoreError(
          'Datastore was supposed to skip ${offset} entities, '
          'but response indicated '
          '${batch.skippedResults + alreadySkipped} entities were '
          'skipped (which is more).');
    }

    // If we have a limit: Check that in total we haven't gotten too many.
    if (remainingNumberOfEntities != null &&
        remainingNumberOfEntities > 0 &&
        batch.entityResults.length > remainingNumberOfEntities) {
      throw new raw.DatastoreError(
          'Datastore returned more entitites (${batch.entityResults.length}) '
          'then the limit was ($remainingNumberOfEntities).');
    }

    // If we have a limit: Calculate the remaining limit.
    int remainingEntities;
    if (remainingNumberOfEntities != null && remainingNumberOfEntities > 0) {
      remainingEntities =
          remainingNumberOfEntities - batch.entityResults.length;
    }

    // Determine if this is the last query batch.
    bool isLast;
    if (!batch.hasMoreResults()) {
      throw new raw.DatastoreError(
          'Datastore was supposed to specify the "moreResults" field '
          'in the query response, but it was missing.');
    }
    if (batch.moreResults ==
            QueryResultBatch_MoreResultsType.MORE_RESULTS_AFTER_LIMIT ||
        batch.moreResults ==
            QueryResultBatch_MoreResultsType.MORE_RESULTS_AFTER_CURSOR ||
        batch.moreResults == QueryResultBatch_MoreResultsType.NO_MORE_RESULTS) {
      isLast = true;
    } else if (batch.moreResults ==
        QueryResultBatch_MoreResultsType.NOT_FINISHED) {
      isLast = false;
    } else {
      throw new raw.DatastoreError(
          'Datastore returned an unknown "moreResults" field in the query '
          'response');
    }

    // If we have an offset: Calculate the new number of skipped entities.
    int skipped = alreadySkipped;
    if (offset != null && offset > 0 && batch.hasSkippedResults()) {
      skipped += batch.skippedResults;
    }

    final entities = batch.entityResults.map((EntityResult result) {
      return codec.decodeEntity(result.entity);
    }).toList();

    return new _QueryPageImpl(request, clientRPCStub, codec, batch.endCursor,
        entities, isLast, offset, skipped, remainingEntities);
  }

  bool get isLast => _isLast;

  List<raw.Entity> get items => _entities;

  Future<Page<raw.Entity>> next({int pageSize}) async {
    if (isLast) {
      throw new ArgumentError('Cannot call next() on last page.');
    }

    // We start at the endCursor we got from the last query.
    _request.query.startCursor = _cursor;

    // We modify the adjusted offset/limits.
    if (_offset != null && (_offset - _alreadySkipped) > 0) {
      _request.query.offset = _offset - _alreadySkipped;
    } else {
      _request.query.clearOffset();
    }
    if (_remainingNumberOfEntities != null) {
      _request.query.limit = new Int32Value()
        ..value = _remainingNumberOfEntities;
    } else {
      _request.query.clearLimit();
    }

    // Maybe lower the number of entities we want to get back in one go.
    if (pageSize != null && pageSize > 0) {
      if (!_request.query.hasLimit()) {
        _request.query.limit = new Int32Value()..value = pageSize;
      } else if (_request.query.limit.value >= pageSize) {
        _request.query.limit.value = pageSize;
      }
    }

    try {
      final response = await _clientRPCStub.runQuery(null, _request);
      return _QueryPageImpl.fromQueryResult(_request, _clientRPCStub, _codec,
          _offset, _alreadySkipped, _remainingNumberOfEntities, response.batch);
    } on grpc.RpcException catch (_) {
      rethrow;
    }
  }
}

class _TransactionImpl extends raw.Transaction {
  final List<int> _rpcTransaction;

  _TransactionImpl(this._rpcTransaction);
}

class _Codec {
  static final FILTER_RELATION_MAPPING = {
    raw.FilterRelation.LessThan: PropertyFilter_Operator.LESS_THAN,
    raw.FilterRelation.LessThanOrEqual:
        PropertyFilter_Operator.LESS_THAN_OR_EQUAL,
    raw.FilterRelation.Equal: PropertyFilter_Operator.EQUAL,
    raw.FilterRelation.GreatherThan: PropertyFilter_Operator.GREATER_THAN,
    raw.FilterRelation.GreatherThanOrEqual:
        PropertyFilter_Operator.GREATER_THAN_OR_EQUAL,
  };

  final String _projectId;

  _Codec(this._projectId);

  raw.Entity decodeEntity(Entity pb) {
    final properties = {};
    final unIndexedProperties = new Set<String>();

    for (final propertyPb in pb.properties) {
      final name = propertyPb.key;
      final value = decodeValue(propertyPb.value);

      if (propertyPb.value.hasExcludeFromIndexes() &&
          propertyPb.value.excludeFromIndexes) {
        unIndexedProperties.add(name);
      }

      // NOTE: This is a hackisch way of detecting whether to construct a list
      // or not. We may be able to use the [propertyPb.multiple] flag, but
      // we could run into issues if we get the same name twice where the flag
      // is false. (Or the flag is sometimes set and sometimes not).
      //
      // The higher-level datastore API will let the user specify a list
      // annotation, which will take care of converting 0/1/N valued properties
      // to lists (no matter whether they are not present, a value or a list
      // from this `properties` here).
      if (!properties.containsKey(name)) {
        properties[name] = decodeValue(propertyPb.value);
      } else {
        final oldValue = properties[name];
        if (oldValue is List) {
          properties[name].add(value);
        } else {
          properties[name] = [oldValue, value];
        }
      }
    }

    return new raw.Entity(decodeKey(pb.key), properties,
        unIndexedProperties: unIndexedProperties);
  }

  Object decodeValue(Value value) {
    if (value.hasBooleanValue()) {
      return value.booleanValue;
    } else if (value.hasStringValue()) {
      return value.stringValue;
    } else if (value.hasIntegerValue()) {
      return value.integerValue.toInt();
    } else if (value.hasBlobValue()) {
      return new raw.BlobValue(value.blobValue);
    } else if (value.hasDoubleValue()) {
      return value.doubleValue;
    } else if (value.hasKeyValue()) {
      return decodeKey(value.keyValue);
    } else if (value.hasNullValue()) {
      return null;
    } else if (value.hasTimestampValue()) {
      final ts = value.timestampValue;
      int us = ts.seconds.toInt() * 1000 * 1000;
      if (ts.hasNanos()) us += ts.nanos ~/ 1000;
      return new DateTime.fromMicrosecondsSinceEpoch(us, isUtc: true);
    } else if (value.hasArrayValue()) {
      return value.arrayValue.values.map(decodeValue).toList();
    } else if (value.hasGeoPointValue()) {
      throw new UnimplementedError("GeoPoint values are not supported yet.");
    } else if (value.hasEntityValue()) {
      throw new UnimplementedError("Entity values are not supported yet.");
    }

    throw 'Unreachable';
  }

  raw.Key decodeKey(Key pb) {
    final keyElements = new List(pb.path.length);
    for (int i = 0; i < pb.path.length; i++) {
      final part = pb.path[i];
      var id;
      if (part.hasName()) {
        id = part.name;
      } else if (part.hasId()) {
        id = part.id.toInt();
      } else {
        throw new errors.ProtocolError('Neither name nor id present in Key.');
      }
      keyElements[i] = new raw.KeyElement(part.kind, id);
    }
    var partition;
    if (pb.hasPartitionId()) {
      final partitionId = pb.partitionId;
      if (partitionId.hasNamespaceId()) {
        partition = new raw.Partition(partitionId.namespaceId);
      }
    }
    if (partition == null) partition = new raw.Partition(null);
    return new raw.Key(keyElements, partition: partition);
  }

  Entity encodeEntity(raw.Entity entity, {bool enforceId: true}) {
    final pb = new Entity();
    pb.key = encodeKey(entity.key, enforceId: enforceId);

    final Set<String> unIndexedProperties = entity.unIndexedProperties;
    entity.properties.forEach((String property, Object value) {
      bool indexProperty = (unIndexedProperties == null ||
          !unIndexedProperties.contains(property));

      final pbProperty = new Entity_PropertiesEntry();
      pbProperty.key = property;
      pbProperty.value = encodeValue(value, !indexProperty);
      pb.properties.add(pbProperty);
    });
    return pb;
  }

  Key encodeKey(raw.Key key, {bool enforceId: true}) {
    final pbPartitionId = new PartitionId()..projectId = _projectId;
    final pb = new Key()..partitionId = pbPartitionId;

    final partition = key.partition;
    if (partition != null && partition.namespace != null) {
      pbPartitionId..namespaceId = partition.namespace;
    }

    for (final part in key.elements) {
      final partPb = new Key_PathElement();
      partPb.kind = part.kind;
      if (part.id != null) {
        if (part.id is String) {
          partPb.name = part.id;
        } else if (part.id is int) {
          partPb.id = new Int64(part.id);
        } else {
          throw new raw.ApplicationError(
              'Only strings and integers are supported as IDs '
              '(was: ${part.id.runtimeType}).');
        }
      } else {
        if (enforceId) {
          throw new raw.ApplicationError(
              'Error while encoding entity key: id was null.');
        }
      }
      pb.path.add(partPb);
    }

    return pb;
  }

  Value encodeValue(value, [bool excludeFromIndexes = false]) {
    final pb = new Value();
    if (value is bool) {
      pb.booleanValue = value;
      if (excludeFromIndexes) pb.excludeFromIndexes = true;
    } else if (value is String) {
      pb.stringValue = value;
      if (excludeFromIndexes) pb.excludeFromIndexes = true;
    } else if (value is int) {
      pb.integerValue = new Int64(value);
      if (excludeFromIndexes) pb.excludeFromIndexes = true;
    } else if (value is raw.BlobValue) {
      pb.blobValue = value.bytes;
      if (excludeFromIndexes) pb.excludeFromIndexes = true;
    } else if (value is double) {
      pb.doubleValue = value;
      if (excludeFromIndexes) pb.excludeFromIndexes = true;
    } else if (value is raw.Key) {
      pb.keyValue = encodeKey(value, enforceId: true);
      if (excludeFromIndexes) pb.excludeFromIndexes = true;
    } else if (value == null) {
      pb.nullValue = NullValue.NULL_VALUE;
      if (excludeFromIndexes) pb.excludeFromIndexes = true;
    } else if (value is DateTime) {
      final int ms = value.millisecondsSinceEpoch;
      final int seconds = ms ~/ 1000;
      final int ns = 1000 * (value.microsecond + (ms % 1000) * 1000);
      pb.timestampValue = new Timestamp()
        ..seconds = (new Int64(seconds))
        ..nanos = ns;
      if (excludeFromIndexes) pb.excludeFromIndexes = true;
    } else if (value is List) {
      // For [ArrayValue]s we need to set the indexing-bit on the individual
      // values, not on the array!
      pb.arrayValue = new ArrayValue()..values.addAll(value.map((value) {
        return encodeValue(value, excludeFromIndexes);
      }));
    } else {
      throw new raw.ApplicationError(
          'Cannot encode unsupported ${value.runtimeType} type.');
    }
    return pb;
  }
}
