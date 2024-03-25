// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// TODO: move other header helpers into this library

import 'dart:io';

import '../../frontend/request_context.dart';

/// Represents cache-control settings for an asset category.
class CacheHeaders {
  /// The maximum age while a response may be cached.
  final Duration maxAge;

  /// Add the `private` directive, indicating that the response must not be
  /// stored in public cache (such as a CDN).
  ///
  /// If neither [private] or [public] is specified, `Cache-Control` will
  /// set `private` if the request was authenticated.
  final bool private;

  /// Add the `public` directive, indicating that the response may be
  /// stored in public cache (such as a CDN).
  ///
  /// If neither [private] or [public] is specified, `Cache-Control` will
  /// set `private` if the request was authenticated.
  final bool public;

  CacheHeaders._(
    this.maxAge, {
    bool private = false,
    bool public = false,
  })  : public = public,
        private = private {
    assert(!private || !public, 'both private and public is not allowed');
  }

  Map<String, String> call() {
    return <String, String>{
      HttpHeaders.cacheControlHeader: <String>[
        if (private)
          'private'
        else if (public)
          'public'
        else if (requestContext.isNotAuthenticated &&
            requestContext.uiCacheEnabled &&
            requestContext.sessionData == null)
          'public'
        else
          'private',
        if (maxAge >= Duration.zero) 'max-age=${maxAge.inSeconds}',
      ].join(', '),
    };
  }

  /// Returns true if the current [headers] contain any cache-control header.
  static bool hasCacheHeader(Map<String, String> headers) {
    return headers.containsKey(HttpHeaders.cacheControlHeader);
  }

  /// Private-only max-age zero.
  static final privateZero = CacheHeaders._(Duration.zero, private: true);

  /// Default cache-control for public user-interface
  static final defaultPublicUI = CacheHeaders._(
    Duration(minutes: 10),
    public: true,
  );

  /// Default cache-control for user-interface
  static final defaultUI = CacheHeaders._(
    Duration(minutes: 10),
    // public / private is inferred from authentication + session header
  );

  /// Default cache-control for API responses
  static final defaultApi = CacheHeaders._(
    Duration(minutes: 10),
    // public / private is inferred from authentication + session header
  );

  /// Everything under the /documentation/ endpoint.
  static final dartdocAsset = CacheHeaders._(Duration(minutes: 15));

  /// Version listing API used by `dart pub` client
  static final versionListingApi = CacheHeaders._(
    Duration(minutes: 10),
    public: true,
  );

  /// Response that redirects to download URL for a package archive
  static final packageDownloadApi = CacheHeaders._(
    Duration(hours: 1),
    public: true,
  );

  /// The package name completion API endpoint serves the cached names
  /// of top packages.
  static final packageNameCompletion = CacheHeaders._(
    Duration(hours: 8),
    public: true,
  );

  /// The package names API endpoint serves the cached names of all packages.
  static final packageNames = CacheHeaders._(
    Duration(hours: 2),
    public: true,
  );

  /// The topic name completion API endpoint serves the cached topic names of
  /// all topics.
  static final topicNameCompletion = CacheHeaders._(
    Duration(hours: 8),
    public: true,
  );

  /// Everything under the /static/ endpoint.
  static final staticAsset = CacheHeaders._(
    Duration(days: 7),
    public: true,
  );
}
