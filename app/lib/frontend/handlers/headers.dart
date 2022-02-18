// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// TODO: move other header helpers into this library

import '../../account/backend.dart';

/// Represents cache-control settings for an asset category.
class CacheHeaders {
  /// The maximum age while a response may be cached.
  final Duration maxAge;

  /// The default cache storage category.
  /// `public` by default
  final String storage;

  /// The cache storage category used for signed-in users.
  /// `private by default
  final String signedInStorage;

  CacheHeaders._(
    this.maxAge, {
    this.storage = 'public',
    this.signedInStorage = 'private',
  });

  Map<String, String> call() {
    final isSignedin = userSessionData != null;
    return <String, String>{
      'Cache-Control': <String>[
        isSignedin ? signedInStorage : storage,
        'max-age=${maxAge.inSeconds}',
      ].join(', '),
    };
  }

  /// Everything under the /documentation/ endpoint.
  static final dartdocAsset = CacheHeaders._(Duration(minutes: 15));

  /// The package name completition API endpoint serves the cache names
  /// of top packages.
  static final packageNameCompletion = CacheHeaders._(Duration(hours: 8));

  /// Everything under the /static/ endpoint.
  static final staticAsset = CacheHeaders._(Duration(days: 7));
}
