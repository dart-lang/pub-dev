// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// An isolate-compatible object registry and lookup service.
library isolate.registry;

import 'dart:async' show Future, Completer, TimeoutException;
import 'dart:collection' show HashMap, HashSet;
import 'dart:isolate' show RawReceivePort, SendPort, Capability;

import 'ports.dart';
import 'src/lists.dart';

// Command tags.
const int _ADD = 0;
const int _REMOVE = 1;
const int _ADD_TAGS = 2;
const int _REMOVE_TAGS = 3;
const int _GET_TAGS = 4;
const int _FIND = 5;

/// An isolate-compatible object registry.
///
/// Objects can be stored as elements of a registry,
/// have "tags" assigned to them, and be looked up by tag.
///
/// A `Registry` object caches objects found using the [lookup]
/// method, or added using [add], and returns the same object every time
/// they are requested.
/// A different `Registry` object that works on the same registry will not
/// preserve the identity of elements
///
/// It is recommended to only have one `Registry` object working on the
/// same registry in each isolate.
///
/// When the registry is shared across isolates, both elements and tags must
/// be sendable between the isolates.
/// Between isolates spawned using [Isolate.spawn] from the same initial
/// isolate, most objects can be sent.
/// Only simple objects can be sent between isolates originating from different
/// [Isolate.spawnUri] calls.
class Registry<T> {
  // Most operations fail if they haven't received a response for this duration.
  final Duration _timeout;

  // Each `Registry` object has a cache of objects being controlled by it.
  // The cache is stored in an [Expando], not on the object.
  // This allows sending the `Registry` object through a `SendPort` without
  // also copying the cache.
  static final Expando _caches = new Expando();

  /// Port for sending command to the central registry manager.
  SendPort _commandPort;

  /// Create a registry linked to a [RegistryManager] through [commandPort].
  ///
  /// In most cases, a registry is created by using the
  /// [RegistryManager.registry] getter.
  ///
  /// If a registry is used between isolates created using [Isolate.spawnUri],
  /// the `Registry` object can't be sent between the isolates directly.
  /// Instead the [RegistryManager.commandPort] port can be sent and a
  /// `Registry` created from the command port using this constructor.
  ///
  /// The optional [timeout] parameter can be set to the duration
  /// this registry should wait before assuming that an operation
  /// has failed.
  Registry.fromPort(SendPort commandPort,
      {Duration timeout: const Duration(seconds: 5)})
      : _commandPort = commandPort,
        _timeout = timeout;

  _RegistryCache get _cache {
    _RegistryCache cache = _caches[this];
    if (cache != null) return cache;
    cache = new _RegistryCache();
    _caches[this] = cache;
    return cache;
  }

  /// Check and get the identity of an element.
  ///
  /// Throws if [element] is not an element in the registry.
  int _getId(T element) {
    int id = _cache.id(element);
    if (id == null) {
      throw new StateError("Not an element: ${Error.safeToString(element)}");
    }
    return id;
  }

  /// Adds [element] to the registry with the provided tags.
  ///
  /// Fails if [element] is already in this registry.
  /// An object is already in the registry if it has been added using [add],
  /// or if it was returned by a [lookup] call on this registry object.
  ///
  /// Returns a capability that can be used with [remove] to remove
  /// the element from the registry again.
  ///
  /// The [tags] can be used to distinguish some of the elements
  /// from other elements. Any object can be used as a tag, as long as
  /// it preserves equality when sent through a [SendPort].
  /// This makes [Capability] objects a good choice for tags.
  Future<Capability> add(T element, {Iterable tags}) {
    _RegistryCache cache = _cache;
    if (cache.contains(element)) {
      return new Future<Capability>.sync(() {
        throw new StateError(
            "Object already in registry: ${Error.safeToString(element)}");
      });
    }
    Completer completer = new Completer<Capability>();
    SendPort port = singleCompletePort(completer,
        callback: (List response) {
          assert(cache.isAdding(element));
          int id = response[0];
          Capability removeCapability = response[1];
          cache.register(id, element);
          return removeCapability;
        },
        timeout: _timeout,
        onTimeout: () {
          cache.stopAdding(element);
          throw new TimeoutException("Future not completed", _timeout);
        });
    if (tags != null) tags = tags.toList(growable: false);
    cache.setAdding(element);
    _commandPort.send(list4(_ADD, element, tags, port));
    return completer.future;
  }

  /// Remove the element from the registry.
  ///
  /// Returns `true` if removing the element succeeded, or `false` if the
  /// elements wasn't in the registry, or if it couldn't be removed.
  ///
  /// The [removeCapability] must be the same capability returned by [add]
  /// when the object was added. If the capability is wrong, the
  /// object is not removed, and this function returns false.
  Future<bool> remove(T element, Capability removeCapability) {
    int id = _cache.id(element);
    if (id == null) {
      return new Future<bool>.value(false);
    }
    Completer completer = new Completer<bool>();
    SendPort port = singleCompletePort(completer, callback: (bool result) {
      _cache.remove(id);
      return result;
    }, timeout: _timeout);
    _commandPort.send(list4(_REMOVE, id, removeCapability, port));
    return completer.future;
  }

  /// Add tags to an object in the registry.
  ///
  /// Each element of the registry has a number of tags associated with
  /// it. A tag is either associated with an element or not, adding it more
  /// than once does not make any difference.
  ///
  /// Tags are compared using [Object.==] equality.
  ///
  /// Fails if any of the elements are not in the registry.
  Future addTags(Iterable<T> elements, Iterable tags) {
    List ids = elements.map(_getId).toList(growable: false);
    return _addTags(ids, tags);
  }

  /// Remove tags from an object in the registry.
  ///
  /// After this operation, the [elements] will not be associated to the [tags].
  /// It doesn't matter whether the elements were associated with the tags
  /// before or not.
  ///
  /// Fails if any of the elements are not in the registry.
  Future removeTags(Iterable<T> elements, Iterable tags) {
    List ids = elements.map(_getId).toList(growable: false);
    tags = tags.toList(growable: false);
    Completer completer = new Completer();
    SendPort port = singleCompletePort(completer, timeout: _timeout);
    _commandPort.send(list4(_REMOVE_TAGS, ids, tags, port));
    return completer.future;
  }

  Future _addTags(List<int> ids, Iterable tags) {
    tags = tags.toList(growable: false);
    Completer completer = new Completer();
    SendPort port = singleCompletePort(completer, timeout: _timeout);
    _commandPort.send(list4(_ADD_TAGS, ids, tags, port));
    return completer.future;
  }

  /// Finds a number of elements that have all the desired [tags].
  ///
  /// If [tags] is omitted or empty, any element of the registry can be
  /// returned.
  ///
  /// If [max] is specified, it must be greater than zero.
  /// In that case, at most the first `max` results are returned,
  /// in whatever order the registry finds its results.
  /// Otherwise all matching elements are returned.
  Future<List<T>> lookup({Iterable tags, int max}) {
    if (max != null && max < 1) {
      throw new RangeError.range(max, 1, null, "max");
    }
    if (tags != null) tags = tags.toList(growable: false);
    Completer completer = new Completer<List<T>>();
    SendPort port = singleCompletePort(completer, callback: (List response) {
      // Response is even-length list of (id, element) pairs.
      _RegistryCache cache = _cache;
      int count = response.length ~/ 2;
      List result = new List(count);
      for (int i = 0; i < count; i++) {
        int id = response[i * 2];
        var element = response[i * 2 + 1];
        element = cache.register(id, element);
        result[i] = element;
      }
      return result;
    }, timeout: _timeout);
    _commandPort.send(list4(_FIND, tags, max, port));
    return completer.future;
  }
}

/// Isolate-local cache used by a [Registry].
///
/// Maps between id-numbers and elements.
/// An object is considered an element of the registry if it
class _RegistryCache {
  // Temporary marker until an object gets an id.
  static const int _BEING_ADDED = -1;

  final Map<int, Object> id2object = new HashMap();
  final Map<Object, int> object2id = new HashMap.identity();

  int id(Object object) {
    int result = object2id[object];
    if (result == _BEING_ADDED) return null;
    return result;
  }

  Object operator [](int id) => id2object[id];

  // Register a pair of id/object in the cache.
  // if the id is already in the cache, just return the existing
  // object.
  Object register(int id, Object object) {
    object = id2object.putIfAbsent(id, () {
      object2id[object] = id;
      return object;
    });
    return object;
  }

  bool isAdding(element) => object2id[element] == _BEING_ADDED;

  void setAdding(element) {
    assert(!contains(element));
    object2id[element] = _BEING_ADDED;
  }

  void stopAdding(element) {
    assert(object2id[element] == _BEING_ADDED);
    object2id.remove(element);
  }

  void remove(int id) {
    var element = id2object.remove(id);
    if (element != null) {
      object2id.remove(element);
    }
  }

  bool contains(element) => object2id.containsKey(element);
}

/// The central repository used by distributed [Registry] instances.
class RegistryManager {
  final Duration _timeout;
  int _nextId = 0;
  RawReceivePort _commandPort;

  /// Maps id to entry. Each entry contains the id, the element, its tags,
  /// and a capability required to remove it again.
  final _entries = new HashMap<int, _RegistryEntry>();
  final _tag2id = new HashMap<Object, Set<int>>();

  /// Create a new registry managed by the created [RegistryManager].
  ///
  /// The optional [timeout] parameter can be set to the duration
  /// registry objects should wait before assuming that an operation
  /// has failed.
  RegistryManager({Duration timeout: const Duration(seconds: 5)})
      : _timeout = timeout,
        _commandPort = new RawReceivePort() {
    _commandPort.handler = _handleCommand;
  }

  /// The command port receiving commands for the registry manager.
  ///
  /// Use this port with [Registry.fromPort] to link a registry to the
  /// manager in isolates where you can't send a [Registry] object directly.
  SendPort get commandPort => _commandPort.sendPort;

  /// Get a registry backed by this manager.
  ///
  /// This registry can be sent to other isolates created using
  /// [Isolate.spawn].
  Registry get registry =>
      new Registry.fromPort(_commandPort.sendPort, timeout: _timeout);

  // Used as argument to putIfAbsent.
  static Set<int> _createSet() => new HashSet<int>();

  void _handleCommand(List command) {
    switch (command[0]) {
      case _ADD:
        _add(command[1], command[2], command[3]);
        return;
      case _REMOVE:
        _remove(command[1], command[2], command[3]);
        return;
      case _ADD_TAGS:
        _addTags(command[1], command[2], command[3]);
        return;
      case _REMOVE_TAGS:
        _removeTags(command[1], command[2], command[3]);
        return;
      case _GET_TAGS:
        _getTags(command[1], command[2]);
        return;
      case _FIND:
        _find(command[1], command[2], command[3]);
        return;
      default:
        throw new UnsupportedError("Unknown command: ${command[0]}");
    }
  }

  void _add(Object object, List tags, SendPort replyPort) {
    int id = ++_nextId;
    var entry = new _RegistryEntry(id, object);
    _entries[id] = entry;
    if (tags != null) {
      for (var tag in tags) {
        entry.tags.add(tag);
        _tag2id.putIfAbsent(tag, _createSet).add(id);
      }
    }
    replyPort.send(list2(id, entry.removeCapability));
  }

  void _remove(int id, Capability removeCapability, SendPort replyPort) {
    _RegistryEntry entry = _entries[id];
    if (entry == null || entry.removeCapability != removeCapability) {
      replyPort.send(false);
      return;
    }
    _entries.remove(id);
    for (var tag in entry.tags) {
      _tag2id[tag].remove(id);
    }
    replyPort.send(true);
  }

  void _addTags(List<int> ids, List tags, SendPort replyPort) {
    assert(tags != null);
    assert(tags.isNotEmpty);
    for (int id in ids) {
      _RegistryEntry entry = _entries[id];
      if (entry == null) continue; // Entry was removed.
      entry.tags.addAll(tags);
      for (var tag in tags) {
        Set ids = _tag2id.putIfAbsent(tag, _createSet);
        ids.add(id);
      }
    }
    replyPort.send(null);
  }

  void _removeTags(List<int> ids, List tags, SendPort replyPort) {
    assert(tags != null);
    assert(tags.isNotEmpty);
    for (int id in ids) {
      _RegistryEntry entry = _entries[id];
      if (entry == null) continue; // Object was removed.
      entry.tags.removeAll(tags);
    }
    for (var tag in tags) {
      Set tagIds = _tag2id[tag];
      if (tagIds == null) continue;
      tagIds.removeAll(ids);
    }
    replyPort.send(null);
  }

  void _getTags(int id, SendPort replyPort) {
    _RegistryEntry entry = _entries[id];
    if (entry != null) {
      replyPort.send(entry.tags.toList(growable: false));
    } else {
      replyPort.send(const []);
    }
  }

  Iterable<int> _findTaggedIds(List tags) {
    var matchingFirstTagIds = _tag2id[tags[0]];
    if (matchingFirstTagIds == null) {
      return const [];
    }
    if (matchingFirstTagIds.isEmpty || tags.length == 1) {
      return matchingFirstTagIds;
    }
    // Create new set, then start removing ids not also matched
    // by other tags.
    Set<int> matchingIds = matchingFirstTagIds.toSet();
    for (int i = 1; i < tags.length; i++) {
      var tagIds = _tag2id[tags[i]];
      if (tagIds == null) return const [];
      matchingIds.retainAll(tagIds);
      if (matchingIds.isEmpty) break;
    }
    return matchingIds;
  }

  void _find(List tags, int max, SendPort replyPort) {
    assert(max == null || max > 0);
    List result = [];
    if (tags == null || tags.isEmpty) {
      var entries = _entries.values;
      if (max != null) entries = entries.take(max);
      for (_RegistryEntry entry in entries) {
        result.add(entry.id);
        result.add(entry.element);
      }
      replyPort.send(result);
      return;
    }
    var matchingIds = _findTaggedIds(tags);
    if (max == null) max = matchingIds.length; // All results.
    for (var id in matchingIds) {
      result.add(id);
      result.add(_entries[id].element);
      max--;
      if (max == 0) break;
    }
    replyPort.send(result);
  }

  /// Shut down the registry service.
  ///
  /// After this, all [Registry] operations will time out.
  void close() {
    _commandPort.close();
  }
}

/// Entry in [RegistryManager].
class _RegistryEntry {
  final int id;
  final Object element;
  final Set tags = new HashSet();
  final Capability removeCapability = new Capability();
  _RegistryEntry(this.id, this.element);
}
