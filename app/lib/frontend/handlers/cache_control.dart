// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:collection';
import 'dart:io' show HttpDate;
import 'package:clock/clock.dart';
import 'package:shelf/shelf.dart' as shelf;

extension HasCacheControl on shelf.Response {
  bool get hasCacheControl => headers.containsKey('Cache-Control');
}

/// A configuration for the `Cache-Control` and `Expires` headers.
final class CacheControl {
  final Duration? maxAge;
  final bool noStore;
  final bool noCache;
  final bool mustRevalidate;
  final bool private;
  final bool public;

  const CacheControl({
    this.maxAge,
    this.noStore = false,
    this.noCache = false,
    this.mustRevalidate = false,
    this.private = false,
    this.public = false,
  });

  /// Apply this [CacheControl] configuration to [response] and return an
  /// updated response object.
  shelf.Response apply(shelf.Response response) =>
      response.change(headers: headers);

  /// Create `Cache-Control` and `Expires` headers for this [CacheControl]
  /// configration.
  Map<String, String> get headers => UnmodifiableMapView({
        'Cache-Control': [
          if (noStore) 'no-store',
          if (noCache) 'no-cache',
          if (mustRevalidate) 'must-revalidate',
          if (private) 'private',
          if (public) 'public',
          if (maxAge case final maxage?) 'max-age=${maxage.inSeconds}'
        ].join(', '),
        'Expires': HttpDate.format(clock.fromNowBy(
          maxAge ?? Duration(minutes: -5),
        )),
      });

  /// `Cache-Control` headers for static files where the URL includes a hash!
  static const staticFiles = CacheControl(
    maxAge: Duration(days: 7),
    public: true,
  );

  /// `Cache-Control` headers for API end-points returning completion data for
  /// use in IDE integrations.
  static const completionData = CacheControl(
    maxAge: Duration(hours: 8),
    public: true,
  );

  /// `Cache-Control` headers for API used by the client.
  static const clientApi = CacheControl(
    maxAge: Duration(minutes: 10),
    public: true,
  );

  /// `Cache-Control` headers for all authenticated responses, and responses we
  /// haven't decided to add `Cache-Control` headers for yet.
  static const defaultPrivate = CacheControl(
    noStore: true,
    noCache: true,
    mustRevalidate: true,
  );

  /// `Cache-Control` headers for responses that absolutely shouldn't be cached.
  static const explicitlyPrivate = CacheControl(
    noStore: true,
    noCache: true,
    mustRevalidate: true,
  );
}
