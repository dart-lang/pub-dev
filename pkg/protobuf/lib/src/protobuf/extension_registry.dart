// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of protobuf;

/// A collection of [Extension] objects, organized by the message type they
/// extend.
class ExtensionRegistry {
  final Map<String, Map<int, Extension>> _extensions =
      <String, Map<int, Extension>>{};

  static const ExtensionRegistry EMPTY = const _EmptyExtensionRegistry();

  /// Stores an [extension] in the registry.
  void add(Extension extension) {
    var map = _extensions.putIfAbsent(
        extension.extendee, () => new Map<int, Extension>());
    map[extension.tagNumber] = extension;
  }

  /// Retrieves an extension from the registry that adds tag number [tagNumber]
  /// to the [messageName] message type.
  Extension getExtension(String messageName, int tagNumber) {
    var map = _extensions[messageName];
    if (map != null) {
      return map[tagNumber];
    }
    return null;
  }
}

class _EmptyExtensionRegistry implements ExtensionRegistry {
  const _EmptyExtensionRegistry();

  // Needed to quiet missing member warning.
  get _extensions => null;

  void add(Extension extension) {
    throw new UnsupportedError('Immutable ExtensionRegistry');
  }

  Extension getExtension(String messageName, int tagNumber) => null;
}
