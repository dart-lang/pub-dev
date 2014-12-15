// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library raw_datastore_v3_impl;

import 'dart:async';
import 'dart:convert' show UTF8;

import 'package:fixnum/fixnum.dart';
import 'package:gcloud/common.dart';
import 'package:gcloud/datastore.dart' as raw;

import '../appengine_context.dart';

import '../../api/errors.dart' as errors;
import '../protobuf_api/rpc/rpc_service.dart';
import '../protobuf_api/internal/datastore_v3.pb.dart';
import '../protobuf_api/datastore_v3_service.dart';

// TODO(gcloud Issue #3): Unified exception handing.
buildDatastoreException(RpcApplicationError error) {
  var errorCode = Error_ErrorCode.valueOf(error.code);
  switch (errorCode) {
    case Error_ErrorCode.BAD_REQUEST:
      return new raw.ApplicationError("Bad request: ${error.message}");
    case Error_ErrorCode.CONCURRENT_TRANSACTION:
      return new raw.TransactionAbortedError();
    case Error_ErrorCode.INTERNAL_ERROR:
      return new raw.InternalError();
    case Error_ErrorCode.NEED_INDEX:
      return new raw.NeedIndexError();
    case Error_ErrorCode.TIMEOUT:
      return new raw.TimeoutError();
    case Error_ErrorCode.PERMISSION_DENIED:
      return new raw.PermissionDeniedError();
    case Error_ErrorCode.BIGTABLE_ERROR:
    case Error_ErrorCode.COMMITTED_BUT_STILL_APPLYING:
    case Error_ErrorCode.CAPABILITY_DISABLED:
    case Error_ErrorCode.TRY_ALTERNATE_BACKEND:
    case Error_ErrorCode.SAFE_TIME_TOO_OLD:
      return new Exception(error);
  }
}

Future catchAndReThrowDatastoreException(Future future) {
  return future.catchError((error, stack) {
    throw buildDatastoreException(error);
  }, test: (error) => error is RpcApplicationError);
}

class TransactionImpl extends raw.Transaction {
  final Transaction _rpcTransaction;

  TransactionImpl(this._rpcTransaction);
}

class Codec {
  static final ORDER_DIRECTION_MAPPING = {
    raw.OrderDirection.Ascending : Query_Order_Direction.ASCENDING,
    raw.OrderDirection.Decending : Query_Order_Direction.DESCENDING,
  };

  static final FILTER_RELATION_MAPPING = {
    raw.FilterRelation.LessThan : Query_Filter_Operator.LESS_THAN,
    raw.FilterRelation.LessThanOrEqual :
      Query_Filter_Operator.LESS_THAN_OR_EQUAL,
    raw.FilterRelation.Equal : Query_Filter_Operator.EQUAL,
    raw.FilterRelation.GreatherThan : Query_Filter_Operator.GREATER_THAN,
    raw.FilterRelation.GreatherThanOrEqual :
      Query_Filter_Operator.GREATER_THAN_OR_EQUAL,
    raw.FilterRelation.In : Query_Filter_Operator.IN,
  };

  final String _application;

  Codec(this._application);

  raw.Entity decodeEntity(EntityProto pb) {
    var properties = {};
    var unIndexedProperties = new Set<String>();

    decodeProperties(List<Property> pbList, {bool indexed: true}) {
      for (var propertyPb in pbList) {
        var name = propertyPb.name;
        var value = decodeValue(propertyPb);

        if (!indexed) {
          unIndexedProperties.add(name);
        }

        // TODO: This is a hackisch way of detecting whether to construct a list
        // or not. We may be able to use the [propertyPb.multiple] flag, but
        // we could run into issues if we get the same name twice where the flag
        // is false. (Or the flag is sometimes set and sometimes not).
        if (!properties.containsKey(name)) {
          properties[name] = decodeValue(propertyPb);
        } else {
          var oldValue = properties[name];
          if (oldValue is List) {
            properties[name].add(value);
          } else {
            properties[name] = [oldValue, value];
          }
        }
      }
    }
    decodeProperties(pb.property, indexed: true);
    decodeProperties(pb.rawProperty, indexed: false);

    return new raw.Entity(decodeKey(pb.key),
                          properties,
                          unIndexedProperties: unIndexedProperties);
  }

  Object decodeValue(Property propertyPb) {
    var pb = propertyPb.value;
    if (pb.hasBytesValue()) {
      switch (propertyPb.meaning) {
        case Property_Meaning.BYTESTRING:
        case Property_Meaning.BLOB:
          return new raw.BlobValue(pb.bytesValue);
        case Property_Meaning.TEXT:
        default:
          return UTF8.decode(pb.bytesValue);
      }
    } else if (pb.hasInt64Value()) {
      var intValue = pb.int64Value.toInt();
      switch (propertyPb.meaning) {
        case Property_Meaning.GD_WHEN:
          return new DateTime.fromMillisecondsSinceEpoch(
              intValue ~/ 1000, isUtc: true);
        default:
          return intValue;
      }
    } else if (pb.hasBooleanValue()) {
      return pb.booleanValue;
    } else if (pb.hasPointValue()) {
      throw new UnimplementedError("Point values are not supported yet.");
    } else if (pb.hasDoubleValue()) {
      return pb.doubleValue;
    } else if (pb.hasUserValue()) {
      throw new UnimplementedError("User values are not supported yet.");
    } else if (pb.hasReferenceValue()) {
      return decodeKeyValue(pb.referenceValue);
    }
    // "If no value field is set, the value is interpreted as a null"
    return null;
  }

  PropertyValue_ReferenceValue encodeKeyValue(raw.Key key) {
    var referencePb = new PropertyValue_ReferenceValue();
    var partition = key.partition;
    if (partition != null && partition.namespace != null) {
      referencePb.nameSpace = partition.namespace;
    }
    referencePb.app = _application;
    referencePb.pathElement.addAll(key.elements.map((raw.KeyElement part) {
      var pathElementPb = new PropertyValue_ReferenceValue_PathElement();
      pathElementPb.type = part.kind;
      if (part.id != null) {
        if (part.id is int) {
          pathElementPb.id = new Int64(part.id);
        } else {
          pathElementPb.name = part.id;
        }
      }
      return pathElementPb;
    }));
    return referencePb;
  }

  raw.Key decodeKeyValue(PropertyValue_ReferenceValue pb) {
    var keyElements = [];
    for (var part in pb.pathElement) {
      var id;
      if (part.hasName()) {
        id = part.name;
      } else if (part.hasId()) {
        id = part.id.toInt();
      } else {
        throw new errors.ProtocolError(
            'Invalid ReferenceValue: no int/string id.');
      }
      keyElements.add(new raw.KeyElement(part.type, id));
    }
    var partition = new raw.Partition(pb.hasNameSpace() ? pb.nameSpace : null);
    return new raw.Key(keyElements, partition: partition);
  }

  raw.Key decodeKey(Reference pb) {
    var keyElements = [];
    for (var part in pb.path.element) {
      var id;
      if (part.hasName()) {
        id = part.name;
      } else if (part.hasId()) {
        id = part.id.toInt();
      } else {
        throw new errors.ProtocolError(
            'Invalid ReferenceValue: no int/string id.');
      }
      keyElements.add(new raw.KeyElement(part.type, id));
    }
    var partition = new raw.Partition(pb.hasNameSpace() ? pb.nameSpace : null);
    return new raw.Key(keyElements, partition: partition);
  }

  EntityProto encodeEntity(raw.Entity entity) {
    var pb = new EntityProto();
    pb.key = encodeKey(entity.key, enforceId: false);
    if (entity.key.elements.length > 1) {
      pb.entityGroup =
          _encodePath([entity.key.elements.first], enforceId: true);
    } else {
      pb.entityGroup = new Path();
    }

    var unIndexedProperties = entity.unIndexedProperties;
    for (var property in entity.properties.keys) {
      bool indexProperty = (unIndexedProperties == null ||
                            !unIndexedProperties.contains(property));
      var value = entity.properties[property];
      if (value != null && value is List) {
        for (var entry in value) {
          var pbProperty = encodeProperty(
              property, entry, multiple: true, indexProperty: indexProperty);
          if (indexProperty) {
            pb.property.add(pbProperty);
          } else {
            pb.rawProperty.add(pbProperty);
          }
        }
      } else {
        var pbProperty = encodeProperty(
            property, value, indexProperty: indexProperty);
        if (indexProperty) {
          pb.property.add(pbProperty);
        } else {
          pb.rawProperty.add(pbProperty);
        }
      }
    }
    return pb;
  }

  Reference encodeKey(raw.Key key, {bool enforceId: true}) {
    var partition = key.partition;

    var pb = new Reference();
    if (partition != null && partition.namespace != null) {
      pb.nameSpace = partition.namespace;
    }
    pb.app = _application;
    pb.path = _encodePath(key.elements, enforceId: enforceId);
    return pb;
  }

  Path _encodePath(List<raw.KeyElement> elements, {bool enforceId: true}) {
    var pathPb = new Path();
    for (var part in elements) {
      var partPb = new Path_Element();
      partPb.type = part.kind;
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
      pathPb.element.add(partPb);
    }
    return pathPb;
  }

  Property encodeProperty(String name, Object value,
                          {bool multiple: false, bool indexProperty: false}) {
    var pb = new Property();
    pb.name = name;
    pb.multiple = multiple;

    if (value == null) {
      // "If no value field is set, the value is interpreted as a null"
      pb.value = new PropertyValue();
    } else  if (value is String) {
      pb.value = new PropertyValue()..bytesValue = UTF8.encode(value);
      if (!indexProperty) {
        pb.meaning = Property_Meaning.TEXT;
      }
    } else if (value is int) {
      pb.value = new PropertyValue()..int64Value = new Int64(value);
    } else if (value is double) {
      pb.value = new PropertyValue()..doubleValue = value;
    } else if (value is bool) {
      pb.value = new PropertyValue()..booleanValue = value;
    } else if (value is raw.Key) {
      pb.value = new PropertyValue()..referenceValue = encodeKeyValue(value);
    } else if (value is raw.BlobValue) {
      pb.value = new PropertyValue()..bytesValue = value.bytes;
      if (indexProperty) {
        pb.meaning = Property_Meaning.BYTESTRING;
      } else {
        pb.meaning = Property_Meaning.BLOB;
      }
    } else if (value is DateTime) {
      var usSinceEpoch = new Int64(value.toUtc().millisecondsSinceEpoch * 1000);
      pb.value = new PropertyValue()..int64Value = usSinceEpoch;
      pb.meaning = Property_Meaning.GD_WHEN;
    } else {
      throw new raw.ApplicationError(
          'Cannot encode unsupported ${value.runtimeType} type.');
    }
    return pb;
  }
}

class DatastoreV3RpcImpl implements raw.Datastore {
  final DataStoreV3ServiceClientRPCStub _clientRPCStub;
  final AppengineContext _appengineContext;
  final Codec _codec;

  DatastoreV3RpcImpl(RPCService rpcService,
                     AppengineContext appengineContext,
                     String ticket)
      : _clientRPCStub = new DataStoreV3ServiceClientRPCStub(rpcService,
                                                             ticket),
        _appengineContext = appengineContext,
        _codec = new Codec(appengineContext.fullQualifiedApplicationId);

  Future<List<raw.Key>> allocateIds(List<raw.Key> keys) {
    // TODO: We may be able to group keys if they have the same parent+kind
    // and add a size > 1.
    var requests = [];
    for (var key in keys) {
      var request = new AllocateIdsRequest();
      request.modelKey = _codec.encodeKey(key, enforceId: false);
      request.size = new Int64(1);
      requests.add(_clientRPCStub.AllocateIds(request));
    }
    return catchAndReThrowDatastoreException(
        Future.wait(requests).then((List<AllocateIdsResponse> responses) {
      var result = [];
      for (int i = 0; i < keys.length; i++) {
        var key = keys[i];
        var response = responses[i];
        var id = response.start.toInt();

        if ((response.end - response.start) != 0) {
          throw new errors.ProtocolError(
              "Server responded with invalid allocatedId range: "
              "start=${response.start}, end=${response.end}");
        }

        var parts = key.elements.take(key.elements.length - 1).toList();
        parts.add(new raw.KeyElement(key.elements.last.kind, id));
        result.add(new raw.Key(parts, partition: key.partition));
      }
      return result;
    }));
  }

  Future<raw.Transaction> beginTransaction({bool crossEntityGroup: false}) {
    var request = new BeginTransactionRequest();
    request.allowMultipleEg = crossEntityGroup;
    request.app = _appengineContext.fullQualifiedApplicationId;

    return catchAndReThrowDatastoreException(
        _clientRPCStub.BeginTransaction(request).then((Transaction t) {
      return new TransactionImpl(t);
    }));
  }

  Future<raw.CommitResult> commit({List<raw.Entity> inserts,
                                   List<raw.Entity> autoIdInserts,
                                   List<raw.Key> deletes,
                                   TransactionImpl transaction}) {
    Future insertFuture, deleteFuture;

    Transaction rpcTransaction;
    if (transaction != null) rpcTransaction = transaction._rpcTransaction;

    // Inserts
    bool needInserts = inserts != null && inserts.length > 0;
    bool needAutoIdInserts = autoIdInserts != null && autoIdInserts.length > 0;
    int totalNumberOfInserts = 0;
    if (needInserts || needAutoIdInserts) {
      var request = new PutRequest();
      if (rpcTransaction != null) request.transaction = rpcTransaction;

      if (needAutoIdInserts) {
        totalNumberOfInserts += autoIdInserts.length;
        for (var entity in autoIdInserts) {
          request.entity.add(_codec.encodeEntity(entity));
        }
      }

      if (needInserts) {
        totalNumberOfInserts += inserts.length;
        for (var entity in inserts) {
          request.entity.add(_codec.encodeEntity(entity));
        }
      }

      insertFuture = _clientRPCStub.Put(request).then((PutResponse response) {
        if (response.key.length != totalNumberOfInserts) {
          // TODO(gcloud Issue #3): Unified exception handing.
          throw new Exception(
              "Tried to insert $totalNumberOfInserts entities, but response "
              "seems to indicate we inserted ${response.key.length} entities.");
        }
        if (needAutoIdInserts) {
          // NOTE: Auto id inserts are at the beginning.
          return response.key.take(autoIdInserts.length).map(_codec.decodeKey)
              .toList();
        } else {
          return [];
        }
      });
    } else {
      insertFuture = new Future.value();
    }

    // Deletes
    if (deletes != null && deletes.length > 0) {
      var request = new DeleteRequest();
      if (rpcTransaction != null) request.transaction = rpcTransaction;

      for (var key in deletes) {
        request.key.add(_codec.encodeKey(key));
      }
      deleteFuture = _clientRPCStub.Delete(request).then((_) => null);
    } else {
      deleteFuture = new Future.value();
    }

    return catchAndReThrowDatastoreException(
        Future.wait([insertFuture, deleteFuture]).then((results) {
      var result = new raw.CommitResult(results[0]);
      if (rpcTransaction == null) return result;
      return _clientRPCStub.Commit(rpcTransaction).then((_) => result);
    }));
  }

  Future rollback(TransactionImpl transaction) {
    return catchAndReThrowDatastoreException(
        _clientRPCStub.Rollback(transaction._rpcTransaction)
        .then((_) => null));
  }

  Future<List<raw.Entity>> lookup(
      List<raw.Key> keys, {TransactionImpl transaction}) {
    var request = new GetRequest();
    // Make sure we don't get results out-of-order.
    request.allowDeferred = false;
    if (transaction != null) {
      request.transaction = transaction._rpcTransaction;
      request.strong = true;
    }
    for (var key in keys) {
      request.key.add(_codec.encodeKey(key));
    }
    return catchAndReThrowDatastoreException(
        _clientRPCStub.Get(request).then((GetResponse response) {
      return response.entity.map((GetResponse_Entity pb) {
        if (pb.hasEntity()) return _codec.decodeEntity(pb.entity);
        return null;
      }).toList();
    }));
  }

  Future<Page<raw.Entity>> query(
      raw.Query query, {raw.Partition partition, TransactionImpl transaction}) {
    if (query.kind == null && query.ancestorKey == null) {
      throw new raw.ApplicationError(
          "You must specify a kind or ancestorKey in a query");
    }

    Transaction rpcTransaction = transaction != null
         ? transaction._rpcTransaction : null;

    var request = new Query();
    if (partition != null && partition.namespace != null) {
      request.nameSpace = partition.namespace;
    }
    request.app = _appengineContext.fullQualifiedApplicationId;
    if (rpcTransaction != null) {
      request.transaction = rpcTransaction;
      request.strong = true;
    }
    if (query.kind != null) {
      request.kind = query.kind;
    }
    if (query.ancestorKey != null) {
      request.ancestor = _codec.encodeKey(query.ancestorKey);
    }

    if (query.offset != null) {
      request.offset = query.offset;
    }
    if (query.limit != null) {
      request.limit = query.limit;
    }

    if (query.filters != null) {
      for (var filter in query.filters) {
        var queryFilter = new Query_Filter();
        queryFilter.op = Codec.FILTER_RELATION_MAPPING[filter.relation];
        if (filter.relation == raw.FilterRelation.In) {
          if (filter.value == null || filter.value is! List) {
            throw new raw.ApplicationError('Filters with list entry checks '
                'must have a list value for membership checking.');
          }
          for (var listValue in filter.value) {
            queryFilter.property.add(_codec.encodeProperty(
                filter.name, listValue, indexProperty: true));
          }
        } else {
          queryFilter.property.add(_codec.encodeProperty(
              filter.name, filter.value, indexProperty: true));
        }
        request.filter.add(queryFilter);
      }
    }
    if (query.orders != null) {
      for (var order in query.orders) {
        var queryOrder = new Query_Order();
        queryOrder.direction = Codec.ORDER_DIRECTION_MAPPING[order.direction];
        queryOrder.property = order.propertyName;
        request.order.add(queryOrder);
      }
    }

    return catchAndReThrowDatastoreException(
        _clientRPCStub.RunQuery(request).then((QueryResult result) {
      return QueryPageImpl.fromQueryResult(
          _clientRPCStub, _codec, query.offset, 0, query.limit, result);
    }));
  }
}

// NOTE: We're never calling datastore_v3.DeleteCursor() here.
//   - we don't know when this is safe, due to the Page<> interface
//   - the devappserver2/apiServer does not implement `DeleteCursor()`
class QueryPageImpl implements Page<raw.Entity> {
  final DataStoreV3ServiceClientRPCStub _clientRPCStub;
  final Codec _codec;
  final Cursor _cursor;

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

  QueryPageImpl(this._clientRPCStub,
                this._codec,
                this._cursor,
                this._entities,
                this._isLast,
                this._offset,
                this._alreadySkipped,
                this._remainingNumberOfEntities);

  static QueryPageImpl fromQueryResult(
      DataStoreV3ServiceClientRPCStub clientRPCStub,
      Codec codec,
      int offset,
      int alreadySkipped,
      int remainingNumberOfEntities,
      QueryResult queryResult) {
    // If we have an offset: Check that in total we haven't skipped too many.
    if (offset != null &&
        offset > 0 &&
        queryResult.hasSkippedResults() &&
        queryResult.skippedResults > (offset - alreadySkipped)) {
      throw new raw.DatastoreError(
          'Datastore was supposed to skip ${offset} entities, '
          'but response indicated '
          '${queryResult.skippedResults + alreadySkipped} entities were '
          'skipped (which is more).');
    }

    // If we have a limit: Check that in total we haven't gotten too many.
    if (remainingNumberOfEntities != null &&
        remainingNumberOfEntities > 0 &&
        queryResult.result.length > remainingNumberOfEntities) {
      throw new raw.DatastoreError(
          'Datastore returned more entitites (${queryResult.result.length}) '
          'then the limit was ($remainingNumberOfEntities).');
    }

    // If we have a limit: Calculate the remaining limit.
    int remainingEntities;
    if (remainingNumberOfEntities != null && remainingNumberOfEntities > 0) {
      remainingEntities = remainingNumberOfEntities - queryResult.result.length;
    }

    // Determine if this is the last query batch.
    bool isLast = !(queryResult.hasMoreResults() && queryResult.moreResults);

    // If we have an offset: Calculate the new number of skipped entities.
    int skipped = alreadySkipped;
    if (offset != null && offset > 0 && queryResult.hasSkippedResults()) {
      skipped += queryResult.skippedResults;
    }

    var entities = queryResult.result.map(codec.decodeEntity).toList();
    return new QueryPageImpl(
        clientRPCStub, codec, queryResult.cursor, entities, isLast,
        offset, skipped, remainingEntities);
  }

  bool get isLast => _isLast;

  List<raw.Entity> get items => _entities;

  Future<Page<raw.Entity>> next({int pageSize}) {
    if (isLast) {
      return new Future.sync(() {
        throw new ArgumentError('Cannot call next() on last page.');
      });
    }

    var nextRequest = new NextRequest();
    nextRequest.cursor = _cursor;

    if (pageSize != null && pageSize > 0) {
      nextRequest.count = pageSize;
    }

    if (_offset != null && (_offset - _alreadySkipped) > 0) {
      nextRequest.offset = _offset - _alreadySkipped;
    } else {
      nextRequest.offset = 0;
    }

    return catchAndReThrowDatastoreException(
        _clientRPCStub.Next(nextRequest).then((QueryResult result) {
      return QueryPageImpl.fromQueryResult(
          _clientRPCStub, _codec, _offset, _alreadySkipped,
          _remainingNumberOfEntities, result);
    }));
  }
}
