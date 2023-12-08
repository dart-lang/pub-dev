// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/shared/datastore.dart' as db;

/// [GlobalLockState] is used for locking in a distributed system.
///
///  * `id`, is the `lockId`.
///  * `GlobalLockState` entities never have a parent.
@db.Kind(name: 'GlobalLockState', idType: db.IdType.String)
class GlobalLockState extends db.ExpandoModel<String> {
  /// Get the lockId
  String? get lockId => id;

  /// Unique ULID identifying the claim currently holding the lock.
  ///
  /// Empty, if not currently locked.
  @db.StringProperty(required: true, indexed: false)
  String? claimId;

  /// DateTime at which point the lock becomes free again.
  @db.DateTimeProperty(required: true)
  DateTime? lockedUntil;
}
