// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/service_scope.dart' as ss;

/// Sets the active [RequestContext].
void registerRequestContext(RequestContext value) =>
    ss.register(#_request_context, value);

/// The active [RequestContext].
RequestContext get requestContext =>
    ss.lookup(#_request_context) as RequestContext ?? const RequestContext();

/// Holds flags for request context.
class RequestContext {
  /// Whether the JSON responses should be indented.
  final bool indentJson;

  /// Whether experimental UI features are activated.
  final bool isExperimental;

  /// Whether indexing of the content by robots should be blocked.
  final bool blockRobots;

  /// Whether the use of UI cache is enabled (when there is a risk of cache
  /// pollution by visually changing the site).
  final bool uiCacheEnabled;

  const RequestContext({
    this.indentJson = false,
    this.isExperimental = false,
    this.blockRobots = true,
    this.uiCacheEnabled = false,
  });
}
