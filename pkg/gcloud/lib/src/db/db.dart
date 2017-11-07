// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of gcloud.db;

/**
 * A function definition for transactional functions.
 *
 * The function will be given a [Transaction] object which can be used to make
 * lookups/queries and queue modifications (inserts/updates/deletes).
 */
typedef Future TransactionHandler(Transaction transaction);

/**
 * A datastore transaction.
 *
 * It can be used for making lookups/queries and queue modifications
 * (inserts/updates/deletes). Finally the transaction can be either committed
 * or rolled back.
 */
class Transaction {
  static const int _TRANSACTION_STARTED = 0;
  static const int _TRANSACTION_ROLLED_BACK = 1;
  static const int _TRANSACTION_COMMITTED = 2;

  final DatastoreDB db;
  final datastore.Transaction _datastoreTransaction;

  final List<Model> _inserts = [];
  final List<Key> _deletes = [];

  int _transactionState = _TRANSACTION_STARTED;

  Transaction(this.db, this._datastoreTransaction);

  /**
   * Looks up [keys] within this transaction.
   */
  Future<List<Model>> lookup(List<Key> keys) {
    return _lookupHelper(db, keys, datastoreTransaction: _datastoreTransaction);
  }

  /**
   * Enqueues [inserts] and [deletes] which should be committed at commit time.
   */
  void queueMutations({List<Model> inserts, List<Key> deletes}) {
    _checkSealed();
    if (inserts != null) {
      _inserts.addAll(inserts);
    }
    if (deletes != null) {
      _deletes.addAll(deletes);
    }
  }

  /**
   * Query for [kind] models with [ancestorKey].
   *
   * Note that [ancestorKey] is required, since a transaction is not allowed to
   * touch/look at an arbitrary number of rows.
   */
  Query query(Type kind, Key ancestorKey, {Partition partition}) {
    // TODO(#25): The `partition` element is redundant and should be removed.
    if (partition == null) {
      partition = ancestorKey.partition;
    } else if (ancestorKey.partition != partition) {
      throw new ArgumentError(
          'Ancestor queries must have the same partition in the ancestor key '
          'as the partition where the query executes in.');
    }
    _checkSealed();
    return new Query(db, kind,
        partition: partition,
        ancestorKey: ancestorKey,
        datastoreTransaction: _datastoreTransaction);
  }

  /**
   * Rolls this transaction back.
   */
  Future rollback() {
    _checkSealed(changeState: _TRANSACTION_ROLLED_BACK);
    return db.datastore.rollback(_datastoreTransaction);
  }

  /**
   * Commits this transaction including all of the queued mutations.
   */
  Future commit() {
    _checkSealed(changeState: _TRANSACTION_COMMITTED);
    return _commitHelper(db,
        inserts: _inserts,
        deletes: _deletes,
        datastoreTransaction: _datastoreTransaction);
  }

  _checkSealed({int changeState}) {
    if (_transactionState == _TRANSACTION_COMMITTED) {
      throw new StateError('The transaction has already been committed.');
    } else if (_transactionState == _TRANSACTION_ROLLED_BACK) {
      throw new StateError('The transaction has already been rolled back.');
    }
    if (changeState != null) {
      _transactionState = changeState;
    }
  }
}

class Query {
  final _relationMapping = const <String, datastore.FilterRelation>{
    '<': datastore.FilterRelation.LessThan,
    '<=': datastore.FilterRelation.LessThanOrEqual,
    '>': datastore.FilterRelation.GreatherThan,
    '>=': datastore.FilterRelation.GreatherThanOrEqual,
    '=': datastore.FilterRelation.Equal,
  };

  final DatastoreDB _db;
  final datastore.Transaction _transaction;
  final String _kind;

  final Partition _partition;
  final Key _ancestorKey;

  final List<datastore.Filter> _filters = [];
  final List<datastore.Order> _orders = [];
  int _offset;
  int _limit;

  Query(DatastoreDB dbImpl, Type kind,
      {Partition partition,
      Key ancestorKey,
      datastore.Transaction datastoreTransaction})
      : _db = dbImpl,
        _kind = dbImpl.modelDB.kindName(kind),
        _partition = partition,
        _ancestorKey = ancestorKey,
        _transaction = datastoreTransaction;

  /**
   * Adds a filter to this [Query].
   *
   * [filterString] has form "name OP" where 'name' is a fieldName of the
   * model and OP is an operator. The following operators are supported:
   *
   *   * '<' (less than)
   *   * '<=' (less than or equal)
   *   * '>' (greater than)
   *   * '>=' (greater than or equal)
   *   * '=' (equal)
   *
   * [comparisonObject] is the object for comparison.
   */
  void filter(String filterString, Object comparisonObject) {
    var parts = filterString.split(' ');
    if (parts.length != 2 || !_relationMapping.containsKey(parts[1])) {
      throw new ArgumentError("Invalid filter string '$filterString'.");
    }

    var name = parts[0];
    var comparison = parts[1];
    var propertyName = _convertToDatastoreName(name);

    // This is for backwards compatibility: We allow [datastore.Key]s for now.
    // TODO: We should remove the condition in a major version update of
    // `package:gcloud`.
    if (comparisonObject is! datastore.Key) {
      comparisonObject = _db.modelDB
          .toDatastoreValue(_kind, name, comparisonObject, forComparison: true);
    }
    _filters.add(new datastore.Filter(
        _relationMapping[comparison], propertyName, comparisonObject));
  }

  /**
   * Adds an order to this [Query].
   *
   * [orderString] has the form "-name" where 'name' is a fieldName of the model
   * and the optional '-' says whether the order is descending or ascending.
   */
  void order(String orderString) {
    // TODO: validate [orderString] (e.g. is name valid)
    if (orderString.startsWith('-')) {
      _orders.add(new datastore.Order(datastore.OrderDirection.Decending,
          _convertToDatastoreName(orderString.substring(1))));
    } else {
      _orders.add(new datastore.Order(datastore.OrderDirection.Ascending,
          _convertToDatastoreName(orderString)));
    }
  }

  /**
   * Sets the [offset] of this [Query].
   *
   * When running this query, [offset] results will be skipped.
   */
  void offset(int offset) {
    _offset = offset;
  }

  /**
   * Sets the [limit] of this [Query].
   *
   * When running this query, a maximum of [limit] results will be returned.
   */
  void limit(int limit) {
    _limit = limit;
  }

  /**
   * Execute this [Query] on the datastore.
   *
   * Outside of transactions this method might return stale data or may not
   * return the newest updates performed on the datastore since updates
   * will be reflected in the indices in an eventual consistent way.
   */
  Stream<Model> run() {
    var ancestorKey;
    if (_ancestorKey != null) {
      ancestorKey = _db.modelDB.toDatastoreKey(_ancestorKey);
    }
    var query = new datastore.Query(
        ancestorKey: ancestorKey,
        kind: _kind,
        filters: _filters,
        orders: _orders,
        offset: _offset,
        limit: _limit);

    var partition;
    if (_partition != null) {
      partition = new datastore.Partition(_partition.namespace);
    }

    return new StreamFromPages((int pageSize) {
      return _db.datastore
          .query(query, transaction: _transaction, partition: partition);
    }).stream.map(_db.modelDB.fromDatastoreEntity);
  }

  // TODO:
  // - add runPaged() returning Page<Model>
  // - add run*() method once we have EntityResult{Entity,Cursor} in low-level
  //   API.

  String _convertToDatastoreName(String name) {
    var propertyName = _db.modelDB.fieldNameToPropertyName(_kind, name);
    if (propertyName == null) {
      throw new ArgumentError("Field $name is not available for kind $_kind");
    }
    return propertyName;
  }
}

class DatastoreDB {
  final datastore.Datastore datastore;
  final ModelDB _modelDB;
  Partition _defaultPartition;

  DatastoreDB(this.datastore, {ModelDB modelDB, Partition defaultPartition})
      : _modelDB = modelDB != null ? modelDB : new ModelDBImpl() {
    _defaultPartition =
        defaultPartition != null ? defaultPartition : new Partition(null);
  }

  /**
   * The [ModelDB] used to serialize/deserialize objects.
   */
  ModelDB get modelDB => _modelDB;

  /**
   * Gets the empty key using the default [Partition].
   *
   * Model keys with parent set to [emptyKey] will create their own entity
   * groups.
   */
  Key get emptyKey => defaultPartition.emptyKey;

  /**
   * Gets the default [Partition].
   */
  Partition get defaultPartition => _defaultPartition;

  /**
   * Creates a new [Partition] with namespace [namespace].
   */
  Partition newPartition(String namespace) {
    return new Partition(namespace);
  }

  /**
   * Begins a new a new transaction.
   *
   * A transaction can touch only a limited number of entity groups. This limit
   * is currently 5.
   */
  // TODO: Add retries and/or auto commit/rollback.
  Future withTransaction(TransactionHandler transactionHandler) {
    return datastore
        .beginTransaction(crossEntityGroup: true)
        .then((datastoreTransaction) {
      var transaction = new Transaction(this, datastoreTransaction);
      return transactionHandler(transaction);
    });
  }

  /**
   * Build a query for [kind] models.
   */
  Query query(Type kind, {Partition partition, Key ancestorKey}) {
    // TODO(#26): There is only one case where `partition` is not redundant
    // Namely if `ancestorKey == null` and `partition != null`. We could
    // say we get rid of `partition` and enforce `ancestorKey` to
    // be `Partition.emptyKey`?
    if (partition == null) {
      if (ancestorKey != null) {
        partition = ancestorKey.partition;
      } else {
        partition = defaultPartition;
      }
    } else if (ancestorKey != null && partition != ancestorKey.partition) {
      throw new ArgumentError(
          'Ancestor queries must have the same partition in the ancestor key '
          'as the partition where the query executes in.');
    }
    return new Query(this, kind,
        partition: partition, ancestorKey: ancestorKey);
  }

  /**
   * Looks up [keys] in the datastore and returns a list of [Model] objects.
   *
   * For transactions, please use [beginTransaction] and call the [lookup]
   * method on it's returned [Transaction] object.
   */
  Future<List<Model>> lookup(List<Key> keys) {
    return _lookupHelper(this, keys);
  }

  /**
   * Add [inserts] to the datastore and remove [deletes] from it.
   *
   * The order of inserts and deletes is not specified. When the commit is done
   * direct lookups will see the effect but non-ancestor queries will see the
   * change in an eventual consistent way.
   *
   * For transactions, please use `beginTransaction` and it's returned
   * [Transaction] object.
   */
  Future commit({List<Model> inserts, List<Key> deletes}) {
    return _commitHelper(this, inserts: inserts, deletes: deletes);
  }
}

Future _commitHelper(DatastoreDB db,
    {List<Model> inserts,
    List<Key> deletes,
    datastore.Transaction datastoreTransaction}) {
  var entityInserts, entityAutoIdInserts, entityDeletes;
  var autoIdModelInserts;
  if (inserts != null) {
    entityInserts = [];
    entityAutoIdInserts = [];
    autoIdModelInserts = [];

    for (var model in inserts) {
      // If parent was not explicitly set, we assume this model will map to
      // it's own entity group.
      if (model.parentKey == null) {
        model.parentKey = db.defaultPartition.emptyKey;
      }
      if (model.id == null) {
        autoIdModelInserts.add(model);
        entityAutoIdInserts.add(db.modelDB.toDatastoreEntity(model));
      } else {
        entityInserts.add(db.modelDB.toDatastoreEntity(model));
      }
    }
  }
  if (deletes != null) {
    entityDeletes = deletes.map(db.modelDB.toDatastoreKey).toList();
  }

  return db.datastore
      .commit(
          inserts: entityInserts,
          autoIdInserts: entityAutoIdInserts,
          deletes: entityDeletes,
          transaction: datastoreTransaction)
      .then((datastore.CommitResult result) {
    if (entityAutoIdInserts != null && entityAutoIdInserts.length > 0) {
      for (var i = 0; i < result.autoIdInsertKeys.length; i++) {
        var key = db.modelDB.fromDatastoreKey(result.autoIdInsertKeys[i]);
        autoIdModelInserts[i].parentKey = key.parent;
        autoIdModelInserts[i].id = key.id;
      }
    }
  });
}

Future<List<Model>> _lookupHelper(DatastoreDB db, List<Key> keys,
    {datastore.Transaction datastoreTransaction}) {
  var entityKeys = keys.map(db.modelDB.toDatastoreKey).toList();
  return db.datastore
      .lookup(entityKeys, transaction: datastoreTransaction)
      .then((List<datastore.Entity> entities) {
    return entities.map(db.modelDB.fromDatastoreEntity).toList();
  });
}
