// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../shared/datastore.dart' as db;

/// A secret value stored in Datastore, typically an access credential used by
/// the application.
@db.Kind(name: 'Secret', idType: db.IdType.String)
class Secret extends db.Model {
  @db.StringProperty(required: true)
  String? value;
}

/// Identifiers of the [Secret] keys.
abstract class SecretKey {
  static const String redisConnectionString = 'redis.connectionString';
  static const String redis2ConnectionString = 'redis2.connectionString';

  /// OAuth audiences have separate secrets for each audience.
  static const String oauthPrefix = 'oauth.secret-';

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
    redisConnectionString,
    redis2ConnectionString,
    announcement,
    uploadRestriction,
    youtubeApiKey,
  ];

  /// Whether the key is valid.
  static bool isValid(String key) {
    if (values.contains(key)) return true;
    if (key.startsWith(oauthPrefix)) return true;
    return false;
  }
}
