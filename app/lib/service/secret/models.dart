// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart' as db;

/// A secret value stored in Datastore, typically an access credential used by
/// the application.
@db.Kind(name: 'Secret', idType: db.IdType.String)
class Secret extends db.Model {
  @db.StringProperty(required: true)
  String value;
}

/// Identifiers of the [Secret] keys.
abstract class SecretKey {
  static const String smtpUsername = 'smtp.username';
  static const String smtpPassword = 'smtp.password';
  static const String redisConnectionString = 'redis.connectionString';

  /// OAuth audiences have separate secrets for each audience.
  static const String oauthPrefix = 'oauth.secret-';

  /// List of all keys.
  static const values = [
    smtpUsername,
    smtpPassword,
    redisConnectionString,
  ];

  /// Whether the key is valid.
  static bool isValid(String key) {
    if (values.contains(key)) return true;
    if (key.startsWith(oauthPrefix)) return true;
    return false;
  }
}
