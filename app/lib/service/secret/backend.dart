// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;

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
  /// Returns null if no Secret entity is found.
  /// Throws InvalidInputException if the [id] is no valid.
  Future<String> lookup(String id) async {
    if (!SecretKey.isValid(id)) {
      throw ArgumentError.value(id, 'id', 'invalid secret key identifier');
    }
    final key = _db.emptyKey.append(Secret, id: id);
    final secret = (await _db.lookup<Secret>([key])).single;
    return secret?.value;
  }

  /// Updates a Secret value.
  /// Throws InvalidInputException if the [id] is no valid.
  Future<void> update(String id, String value) async {
    if (!SecretKey.isValid(id)) {
      throw ArgumentError.value(id, 'id', 'invalid secret key identifier');
    }
    final key = _db.emptyKey.append(Secret, id: id);
    await _db.withTransaction((tx) async {
      final secret = (await tx.lookup<Secret>([key])).single;
      if (secret == null) {
        tx.queueMutations(inserts: [
          Secret()
            ..parentKey = dbService.emptyKey
            ..id = id
            ..value = value,
        ]);
      } else {
        tx.queueMutations(inserts: [secret..value = value]);
      }
      await tx.commit();
    });
  }
}
