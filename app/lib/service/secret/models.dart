// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Identifiers and secret keys.
abstract class SecretKey {
  /// Postgres connection string.
  static const String postgresConnectionString = 'postgres-connection-string';

  /// Redis connection string.
  static const String redisConnectionString = 'redis-connection-string';

  /// OAuth client secret.
  static const String oauthClientSecret = 'oauth-client-secret';

  /// Site-wide announcement.
  static const String announcement = 'announcement';

  /// The restriction applied on uploads.
  ///
  /// This feature is intended as an emergency brake.
  ///
  /// Valid values for `upload-restriction` are:
  ///  * `no-uploads`, no package publications will be accepted by the server,
  ///  * `only-updates`, publication of new packages will not be accepted, but new versions of existing packages will be accepted, and,
  ///  * `no-restriction`, (default) publication of new packages and new versions is allowed.
  static const String uploadRestriction = 'upload-restriction';

  /// Youtube API Key.
  static const String youtubeApiKey = 'youtube-api-key';

  /// List of all keys.
  static const values = [
    postgresConnectionString,
    redisConnectionString,
    oauthClientSecret,
    announcement,
    uploadRestriction,
    youtubeApiKey,
  ];

  /// Whether the key is valid.
  static bool isValid(String key) {
    if (values.contains(key)) return true;
    return false;
  }
}
