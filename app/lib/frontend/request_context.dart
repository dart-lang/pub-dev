// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/service_scope.dart' as ss;

import '../account/models.dart';
import 'handlers/experimental.dart';

/// Sets the active [RequestContext].
void registerRequestContext(RequestContext value) =>
    ss.register(#_request_context, value);

/// The active [RequestContext].
RequestContext get requestContext =>
    ss.lookup(#_request_context) as RequestContext? ?? RequestContext();

/// Holds flags for request context.
class RequestContext {
  /// Whether the JSON responses should be indented.
  final bool indentJson;

  /// Whether indexing of the content by robots should be blocked.
  final bool blockRobots;

  /// Whether the use of UI cache is enabled (when there is a risk of cache
  /// pollution by visually changing the site).
  final bool uiCacheEnabled;

  /// The parsed experimental flags.
  final ExperimentalFlags experimentalFlags;

  /// The active user's session data.
  ///
  /// **Warning:** the existence of a session MAY ONLY be used for authenticating
  /// a user for the purpose of generating HTML output served from a GET request.
  ///
  /// This may **NOT** to authenticate mutations, API interactions, not even GET
  /// APIs that return JSON. Whenever possible we require the OpenID-Connect
  /// `id_token` be present as `Authentication: Bearer <id_token>` header instead.
  /// Such scheme does not work for `GET` requests that serve content to the
  /// browser, and hence, we employ session cookies for this purpose.
  final SessionData? userSessionData;

  RequestContext({
    this.indentJson = false,
    this.blockRobots = true,
    this.uiCacheEnabled = false,
    ExperimentalFlags? experimentalFlags,
    this.userSessionData,
  }) : experimentalFlags = experimentalFlags ?? ExperimentalFlags.empty;
}
