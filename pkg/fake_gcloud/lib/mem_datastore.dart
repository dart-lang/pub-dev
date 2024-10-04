import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:gcloud/common.dart';
import 'package:gcloud/datastore.dart';

final _maxIndexedPropertyLength = 1500;
final _maxKeySegmentLength = 1500;
final _maxPropertyLength = 1024 * 1024;

/// Implementation of [Datastore] interface with in-memory storage.
///
/// Entities are cloned, and should be safe to modify them once they are stored
/// or read.
class MemDatastore implements Datastore {
  final _entities = <Key, Entity>{};
  int _unusedId = 0;

  @override
  Future<List<Key>> allocateIds(List<Key> keys) async {
    return keys.map((k) {
      if (k.elements.last.id == null) {
        final elements = List<KeyElement>.from(k.elements);
        final last = elements.removeLast();
        elements.add(KeyElement(last.kind, _unusedId++));
        return Key(elements, partition: k.partition);
      } else {
        return k;
      }
    }).toList();
  }

  @override
  Future<Transaction> beginTransaction({bool crossEntityGroup = false}) async {
    return _Transaction();
  }

  @override
  Future<CommitResult> commit({
    List<Entity> inserts = const [],
    List<Entity> autoIdInserts = const [],
    List<Key> deletes = const [],
    Transaction? transaction,
  }) async {
    if (autoIdInserts.isNotEmpty) {
      throw UnimplementedError(
          'fake_gcloud.Datastore.autoIdInserts is not implemented.');
    }

    // https://cloud.google.com/datastore/docs/concepts/transactions#what_can_be_done_in_a_transaction
    if (inserts.length + deletes.length > 500) {
      throw DatastoreError('Too many entities in the transaction.');
    }

    final newKeys = inserts.map((i) => i.key).toSet();

    // check if updated key is deleted
    for (final deletedKey in deletes) {
      if (newKeys.contains(deletedKey)) {
        throw DatastoreError('Conflicting update and delete on $deletedKey');
      }
    }

    inserts.forEach(_checkProperties);
    autoIdInserts.forEach(_checkProperties);

    // TODO: check serializability.
    // We need to track the keys that have been mutated since the Transaction
    // was created to ensure that there are no conflicts.
    // Alternatively: block overlapping transactions.

    // execute commit
    deletes.forEach((key) => _entities.remove(key));
    inserts.forEach((e) {
      _entities[e.key] = e;
    });

    return CommitResult([]);
  }

  // Returns the length of the key.
  int _verifyKeyLength(Key key) {
    int overallLength = 0;

    // A key can have at most 100 path elements.
    if (key.elements.length > 100) {
      throw DatastoreError('Key $key must not exceed 100 elements.');
    }
    // Each kind can be at most 1500 bytes.
    // Each name can be at most 1500 bytes.
    for (final element in key.elements) {
      void check(Object segmentPart) {
        final length = _propertyLength(segmentPart);
        overallLength += length;
        if (length > _maxKeySegmentLength) {
          throw DatastoreError(
              'Key segment $segmentPart must not exceed $_maxKeySegmentLength bytes.');
        }
      }

      check(element.kind);
      check('${element.id}');
    }

    return overallLength;
  }

  void _checkProperties(Entity entity) {
    int overallLength = 0;

    // key
    overallLength += _verifyKeyLength(entity.key);

    // properties
    for (final p in entity.properties.entries) {
      if (p.value == null) continue;
      final length = _propertyLength(p.value!);
      overallLength += length;

      final indexed = entity.unIndexedProperties.isEmpty ||
          !entity.unIndexedProperties.contains(p.key);

      if (length > _maxPropertyLength) {
        throw DatastoreError(
            'Property ${p.key} must not exceed $_maxPropertyLength bytes.');
      }

      if (indexed && length > _maxIndexedPropertyLength) {
        throw DatastoreError(
            'Indexed property ${p.key} must not exceed $_maxIndexedPropertyLength bytes.');
      }
    }

    if (overallLength > _maxPropertyLength) {
      throw DatastoreError(
          'Overall entity length must not exceed $_maxPropertyLength bytes.');
    }
  }

  int _propertyLength(Object value) {
    if (value is String) return utf8.encode(value).length;
    if (value is Uint8List) return value.length;
    // TODO: detect more
    return 0;
  }

  @override
  Future<List<Entity?>> lookup(List<Key> keys,
      {Transaction? transaction}) async {
    if (keys.any((k) => k.elements.any((e) => e.id == null))) {
      throw ArgumentError('Key contains null.');
    }
    return keys.map((key) {
      _verifyKeyLength(key);
      return _entities[key];
    }).toList();
  }

  dynamic _getValue(Entity entity, String property) {
    if (property == '__key__') return entity.key;
    return entity.properties[property];
  }

  int _compare(dynamic a, dynamic b) {
    // Equality filter:  to query if an array contains a value use an equality filter.
    // https://cloud.google.com/datastore/docs/concepts/queries#array_values
    if (a is List && b is! List) {
      if (a.contains(b)) {
        return 0;
      } else {
        return -1;
      }
    }
    if (a is Key && b is Key) {
      if (a.elements.length != 1) {
        throw UnimplementedError();
      }
      if (b.elements.length != 1) {
        throw UnimplementedError();
      }
      return Comparable.compare(a.elements.single.id as Comparable,
          b.elements.single.id as Comparable);
    } else {
      return Comparable.compare(a as Comparable, b as Comparable);
    }
  }

  @override
  Future<Page<Entity>> query(
    Query query, {
    Partition partition = Partition.DEFAULT,
    Transaction? transaction,
  }) async {
    List<Entity> items = _entities.values
        .where((e) => e.key.elements.last.kind == query.kind)
        .where(
      (e) {
        if (query.ancestorKey == null) {
          return true;
        } else if (query.ancestorKey!.partition != e.key.partition) {
          return false;
        } else if (query.ancestorKey!.elements.length !=
            e.key.elements.length - 1) {
          return false;
        }
        for (int i = 0; i < query.ancestorKey!.elements.length; i++) {
          if (query.ancestorKey!.elements[i] != e.key.elements[i]) {
            return false;
          }
        }
        return true;
      },
    ).where(
      (e) {
        if (query.filters == null || query.filters!.isEmpty) {
          return true;
        }
        return query.filters!.every((f) {
          if (e.unIndexedProperties.contains(f.name)) {
            throw DatastoreError(
                'Filtering on unindexed property: "${f.name}".');
          }
          final v = _getValue(e, f.name);
          if (v == null) return false;
          final c = _compare(v, f.value);
          switch (f.relation) {
            case FilterRelation.Equal:
              return c == 0;
            case FilterRelation.LessThan:
              return c < 0;
            case FilterRelation.LessThanOrEqual:
              return c <= 0;
            case FilterRelation.GreaterThan:
              return c > 0;
            case FilterRelation.GreaterThanOrEqual:
              return c >= 0;
            default:
              throw UnimplementedError('Not handled relation: ${f.relation}');
          }
        });
      },
    ).toList();
    if (query.orders != null && query.orders!.isNotEmpty) {
      items.sort((a, b) {
        for (Order o in query.orders!) {
          if (a.unIndexedProperties.contains(o.propertyName) ||
              b.unIndexedProperties.contains(o.propertyName)) {
            throw DatastoreError(
                'Ordering on unindexed property: "${o.propertyName}".');
          }

          final ap = _getValue(a, o.propertyName);
          final bp = _getValue(b, o.propertyName);
          final c = _compare(ap, bp);
          if (c == 0) continue;
          if (o.direction == OrderDirection.Ascending) {
            return c;
          } else {
            return -c;
          }
        }
        return 0;
      });
    }
    if (query.offset != null && query.offset! > 0) {
      items = items.skip(query.offset!).toList();
    }
    if (query.limit != null && query.limit! < items.length) {
      items = items.sublist(0, query.limit);
    }
    return _Page(items, 0, 100);
  }

  @override
  Future<void> rollback(Transaction transaction) async {
    return null;
  }

  /// Serializes the content of the Datastore to the [sink], with a line-by-line
  /// JSON-encoded data format.
  void writeTo(StringSink sink) async {
    _entities.forEach((_, entity) {
      sink.writeln(json.encode({'entity': _encodeEntity(entity)}));
    });
    sink.writeln(json.encode({'_unusedId': _unusedId}));
  }

  /// Reads content as a line-by-line JSON-encoded data format.
  void readFrom(Iterable<String> lines) {
    for (final line in lines) {
      if (line.isEmpty) continue;
      final map = json.decode(line) as Map<String, dynamic>;
      final key = map.keys.single;
      switch (key) {
        case '_unusedId':
          _unusedId = math.max(_unusedId, map[key] as int);
          break;
        case 'entity':
          final entity = _decodeEntity(map[key] as Map<String, dynamic>);
          _entities[entity.key] = entity;
          break;
        default:
          throw UnimplementedError('Unknown key: $key');
      }
    }
  }

  dynamic _encodeValue(Object? value) {
    if (value == null) return null;
    if (value is String || value is int || value is double || value is bool) {
      return value;
    }
    if (value is DateTime) {
      return {'datetime': value.toUtc().toIso8601String()};
    }
    if (value is BlobValue) {
      return {'blob': base64.encode(value.bytes)};
    }
    if (value is List<int>) {
      return {'bytes': base64.encode(value)};
    }
    if (value is Key) {
      return {'key': _encodeKey(value)};
    }
    if (value is List) {
      return {'list': value};
    }
    throw UnimplementedError('Unhandled type: ${value.runtimeType} ($value).');
  }

  dynamic _decodeValue(Object? value) {
    if (value == null) return null;
    if (value is String || value is int || value is double || value is bool) {
      return value;
    }
    if (value is Map<String, dynamic>) {
      final key = value.keys.single;
      switch (key) {
        case 'datetime':
          return DateTime.parse(value[key] as String);
        case 'blob':
          return BlobValue(base64.decode(value[key] as String));
        case 'bytes':
          return base64.decode(value[key] as String);
        case 'key':
          return _decodeKey(value[key] as Map<String, dynamic>);
        case 'list':
          return value[key];
        default:
          throw UnimplementedError('Unknown key: $key');
      }
    }
    throw UnimplementedError('Unhandled type: ${value.runtimeType} ($value).');
  }

  Map<String, dynamic> _encodeKey(Key key) {
    return {
      'partition': key.partition.namespace,
      'elements': key.elements
          .map((e) => {
                'kind': e.kind,
                'id': e.id,
              })
          .toList(),
    };
  }

  Key _decodeKey(Map<String, dynamic> map) {
    final partition = map['partition'] as String?;
    final elements = (map['elements'] as List)
        .cast<Map<String, dynamic>>()
        .map((e) => KeyElement(e['kind'] as String, e['id']))
        .toList();
    return Key(elements,
        partition:
            partition == null ? Partition.DEFAULT : Partition(partition));
  }

  Map<String, dynamic> _encodeEntity(Entity entity) {
    return <String, dynamic>{
      'key': _encodeKey(entity.key),
      'props': entity.properties
          .map((key, value) => MapEntry(key, _encodeValue(value))),
      'unindexed': entity.unIndexedProperties.toList(),
    };
  }

  Entity _decodeEntity(Map<String, dynamic> json) {
    final keyMap = json['key'] as Map<String, dynamic>;
    final key = _decodeKey(keyMap);
    final props = (json['props'] as Map<String, dynamic>)
        .map((k, v) => MapEntry(k, _decodeValue(v)));
    final unindexed = (json['unindexed'] as List).cast<String>();
    return Entity(key, props, unIndexedProperties: unindexed.toSet());
  }
}

class _Transaction implements Transaction {}

class _Page implements Page<Entity> {
  final List<Entity> _items;
  @override
  final List<Entity> items;
  final int _offset;
  final int _pageSize;

  _Page(this._items, this._offset, this._pageSize)
      : items = _items.skip(_offset).take(_pageSize).toList();

  @override
  bool get isLast => _offset + _pageSize > _items.length;

  @override
  Future<Page<Entity>> next({int? pageSize}) async {
    return _Page(_items, _offset + _pageSize, pageSize ?? _pageSize);
  }
}
