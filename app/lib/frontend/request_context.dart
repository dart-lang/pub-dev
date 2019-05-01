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
  /// Whether the request is on a production host (vs. staging or dev)
  final bool isProductionHost;

  /// Whether the request is on a host that should serve packages.
  final bool showPackages;

  /// Whether the request is on a host the should serve API docs.
  final bool showApiDocs;

  /// Whether experimental UI features are activated.
  final bool isExperimental;

  const RequestContext({
    this.isProductionHost = false,
    this.showPackages = true,
    this.showApiDocs = true,
    this.isExperimental = false,
  });
}
