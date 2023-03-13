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

  /// The cache storage category used for signed-in users.
  /// `private` by default.
  final String? signedInStorage;

  CacheHeaders._(
    this.maxAge, {
    this.signedInStorage,
  });

  Map<String, String> call() {
    return <String, String>{
      HttpHeaders.cacheControlHeader: <String>[
        requestContext.isNotAuthenticated
            ? 'public'
            : (signedInStorage ?? 'private'),
        if (maxAge >= Duration.zero) 'max-age=${maxAge.inSeconds}',
      ].join(', '),
    };
  }

  /// Returns true if the current [headers] contain any cache-control header.
  static bool hasCacheHeader(Map<String, String> headers) {
    return headers.containsKey(HttpHeaders.cacheControlHeader);
  }

  /// Default private-only caching.
  static final private = CacheHeaders._(Duration.zero);

  /// Everything under the /documentation/ endpoint.
  static final dartdocAsset = CacheHeaders._(Duration(minutes: 15));

  /// The package name completition API endpoint serves the cached names
  /// of top packages.
  static final packageNameCompletion = CacheHeaders._(Duration(hours: 8));

  /// The package names API endpoint serves the cached names of all packages.
  static final packageNames = CacheHeaders._(Duration(hours: 2));

  /// Everything under the /static/ endpoint.
  static final staticAsset = CacheHeaders._(
    Duration(days: 7),
    signedInStorage: 'public',
  );
}
