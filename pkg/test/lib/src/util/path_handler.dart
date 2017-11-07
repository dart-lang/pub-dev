// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:path/path.dart' as p;
import 'package:shelf/shelf.dart' as shelf;

/// A handler that routes to sub-handlers based on exact path prefixes.
class PathHandler {
  /// A trie of path components to handlers.
  final _paths = new _Node();

  /// The shelf handler.
  shelf.Handler get handler => _onRequest;

  /// Returns middleware that nests all requests beneath the URL prefix
  /// [beneath].
  static shelf.Middleware nestedIn(String beneath) {
    return (handler) {
      var pathHandler = new PathHandler()..add(beneath, handler);
      return pathHandler.handler;
    };
  }

  /// Routes requests at or under [path] to [handler].
  ///
  /// If [path] is a parent or child directory of another path in this handler,
  /// the longest matching prefix wins.
  void add(String path, shelf.Handler handler) {
    var node = _paths;
    for (var component in p.url.split(path)) {
      node = node.children.putIfAbsent(component, () => new _Node());
    }
    node.handler = handler;
  }

  _onRequest(shelf.Request request) {
    var handler;
    var handlerIndex;
    var node = _paths;
    var components = p.url.split(request.url.path);
    for (var i = 0; i < components.length; i++) {
      node = node.children[components[i]];
      if (node == null) break;
      if (node.handler == null) continue;
      handler = node.handler;
      handlerIndex = i;
    }

    if (handler == null) return new shelf.Response.notFound("Not found.");

    return handler(
        request.change(path: p.url.joinAll(components.take(handlerIndex + 1))));
  }
}

/// A trie node.
class _Node {
  shelf.Handler handler;
  final children = new Map<String, _Node>();
}
