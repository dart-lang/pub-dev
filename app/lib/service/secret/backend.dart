// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/service_scope.dart' as ss;

import '../../shared/datastore.dart';
import '../../shared/redis_cache.dart';
import 'models.dart';

export 'models.dart' show SecretKey;

/// Sets the secret backend service.
void registerSecretBackend(SecretBackend backend) =>
    ss.register(#_secretBackend, backend);

/// The active secret backend service.
SecretBackend get secretBackend => ss.lookup(#_secretBackend) as SecretBackend;

/// Represents the backend for the secret handling and related utilities.
class SecretBackend {
  final DatastoreDB _db;

  SecretBackend(this._db);

  /// Loads the Secret value from the Datastore.
  /// Returns `null` if no Secret entity is found.
  ///
  /// Throws if [id] is not valid.
  Future<String> lookup(String id) async {
    if (!SecretKey.isValid(id)) {
      throw ArgumentError.value(id, 'id', 'invalid secret key identifier');
    }
    final key = _db.emptyKey.append(Secret, id: id);
    final secret = await _db.lookupValue<Secret>(key, orElse: () => null);
    return secret?.value;
  }

  /// Updates a Secret value.
  ///
  /// Throws if [id] is not valid.
  Future<void> update(String id, String value) async {
    if (!SecretKey.isValid(id)) {
      throw ArgumentError.value(id, 'id', 'invalid secret key identifier');
    }
    final key = _db.emptyKey.append(Secret, id: id);
    await withRetryTransaction(_db, (tx) async {
      final secret = await tx.lookupValue<Secret>(key, orElse: () => null);
      if (secret == null) {
        tx.insert(Secret()
          ..parentKey = dbService.emptyKey
          ..id = id
          ..value = value);
      } else {
        tx.insert(secret..value = value);
      }
    });
    await cache.secretValue(id).purge();
  }

  /// Gets the cached secret value from redis cache (or when no cache entry
  /// exists, lookup current value from the Datastore).
  ///
  /// WARNING: Do not use this method for sensitive data, as it will be put in
  ///          redis too.
  Future<String> getCachedValue(String id) async {
    return await cache.secretValue(id).get(() => lookup(id));
  }
}
