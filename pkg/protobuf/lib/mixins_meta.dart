// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Provides metadata about mixins to dart-protoc-plugin.
/// (Experimental API; subject to change.)
library protobuf.mixins.meta;

/// Entry point called by dart-protoc-plugin.
PbMixin findMixin(String name) {
  for (var m in _exportedMixins) {
    if (m.name == name) {
      return m;
    }
  }
  return null; // not found
}

/// PbMixin contains metadata needed by dart-protoc-plugin to apply a mixin.
///
/// The mixin can be applied to a message using options in dart_options.proto.
/// Only one mixin can be applied to each message, but that mixin can depend
/// on another mixin, recursively, similar to single inheritance.
class PbMixin {
  /// The name of the mixin class to import into the .pb.dart file.
  final String name;

  /// The file that the .pb.dart file should import the symbol from.
  final String importFrom;

  /// Another mixin to apply ahead of this one, or null for none.
  final PbMixin parent;

  /// Names that shouldn't be used by properties in the generated child class.
  /// May be null if the mixin doesn't reserve any new names.
  final List<String> reservedNames;

  const PbMixin(this.name, {this.importFrom, this.parent, this.reservedNames});

  /// Returns the mixin and its ancestors, in the order they should be applied.
  Iterable<PbMixin> findMixinsToApply() {
    var result = [this];
    for (var p = parent; p != null; p = p.parent) {
      result.add(p);
    }
    return result.reversed;
  }

  /// Returns all the reserved names, including from ancestor mixins.
  Iterable<String> findReservedNames() {
    var names = new Set<String>();
    for (var m = this; m != null; m = m.parent) {
      names.add(m.name);
      if (m.reservedNames != null) {
        names.addAll(m.reservedNames);
      }
    }
    return names;
  }
}

/// The mixins that findMixin() can return.
final _exportedMixins = [_pbMapMixin, _pbEventMixin];

const _pbMapMixin = const PbMixin("PbMapMixin",
    importFrom: "package:protobuf/src/protobuf/mixins/map_mixin.dart",
    parent: _mapMixin);

const _pbEventMixin = const PbMixin("PbEventMixin",
    importFrom: "package:protobuf/src/protobuf/mixins/event_mixin.dart",
    reservedNames: const ["changes", "deliverChanges"]);

const List<String> _reservedNamesForMap = const [
  '[]',
  '[]=',
  'addAll',
  'containsKey',
  'containsValue',
  'forEach',
  'putIfAbsent',
  'remove',
  'isEmpty',
  'isNotEmpty',
  'keys',
  'length',
  'values',
];

const _mapMixin = const PbMixin("MapMixin",
    importFrom: "dart:collection", reservedNames: _reservedNamesForMap);
