// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'schema.dart';

/// Stores the state of a `GlobalLock`, keyed by the lock's id.
///
/// TODO: Rename to `GlobalLockState` after it has been fully migrated.
@PrimaryKey(['lockId'])
abstract final class GlobalLockStateRow extends Row {
  /// The id of the lock.
  String get lockId;

  /// Unique ULID identifying the claim currently holding the lock.
  ///
  /// Empty, if not currently locked.
  String get claimId;

  /// The point in time at which the lock becomes free again.
  DateTime get lockedUntil;
}
