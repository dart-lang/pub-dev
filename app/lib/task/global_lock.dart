// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:clock/clock.dart';
import 'package:logging/logging.dart' show Logger;
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/task/global_lock_models.dart';
import 'package:typed_sql/typed_sql.dart';
import 'package:ulid/ulid.dart' show Ulid;

final _log = Logger('pub.global_lock');

/// The claimId and expiration of a [GlobalLockState] row, as read from SQL.
typedef _LockState = ({String claimId, DateTime lockedUntil});

class GlobalLock {
  final String _lockId;
  final Duration _expiration;
  final DatastoreDB _db;

  GlobalLock._(this._lockId, this._expiration, this._db);

  static GlobalLock create(
    String lockId, {
    Duration expiration = const Duration(minutes: 25),
  }) => GlobalLock._(lockId, expiration, dbService);

  /// Call [fn] while retaining a claim to this lock. This will wait until the
  /// lock is acquired.
  ///
  /// A [TimeoutException] is thrown if [abort] is completed before the lock is
  /// acquired.
  Future<T> withClaim<T>(
    FutureOr<T> Function(GlobalLockClaim claim) fn, {
    Completer<void>? abort,
  }) async {
    ArgumentError.checkNotNull(fn, 'fn');
    abort ??= Completer();

    final c = await claim(abort: abort);
    final claimId = c._claimId;
    var refreshed = Future.value(true);
    final done = Completer<void>();
    try {
      scheduleMicrotask(() async {
        while (c.valid && !done.isCompleted) {
          // Await for 50% of the time until expiration is gone, then we refresh
          var delay = c.expires
              .subtract(_expiration * 0.5)
              .difference(clock.now().toUtc());
          // always sleep at-least 10% of expiration before refreshing
          if (delay < _expiration * 0.1) {
            delay = _expiration * 0.1;
          }
          // This logic ensures that we try to refresh when 50% of expiration
          // has passed, at this point we refresh every 10% of expiration. This
          // ensures that if refreshing fails, then we have a few attempts to
          // refresh, before it's truly expired.

          // Wait for done or delay
          await done.future.timeout(delay, onTimeout: () => null);

          // Try to refresh, if claim is still valid and we're not done.
          if (c.valid && !done.isCompleted) {
            refreshed = c.refresh();
            try {
              if (!await refreshed) {
                _log.warning('failed to refresh claim $claimId on $_lockId');
                return; // Stop refreshing, if refresh failed.
              }
            } on Exception catch (e, st) {
              // Stop refreshing, and log the error
              _log.severe('Error refreshing claim $claimId on $_lockId', e, st);
              return;
            }
          }
        }
      });
      return await fn(c);
    } finally {
      done.complete();
      try {
        await refreshed; // wait to any ongoing refreshing attempt is done
      } on Exception {
        // Ignore the exception, we've logged this before
      }
      if (c.valid) {
        await c.release();
      }
    }
  }

  /// Try to claim the lock, return `null` if lock is currently held by a
  /// different process.
  Future<GlobalLockClaim?> tryClaim() async {
    final claimId = Ulid().toString();

    // Try to claim or get the lock
    final state = await _tryClaimOrGet(claimId);

    // Check if we got a claim
    if (_hasClaim(state, claimId)) {
      _log.info('established claim $claimId on $_lockId');
      return GlobalLockClaim._(
        _lockId,
        claimId,
        state!.lockedUntil,
        _expiration,
        _db,
      );
    }
    return null;
  }

  /// Try to claim the lock in SQL.
  ///
  /// On a successful SQL claim, the claim is mirrored (best-effort) into
  /// Datastore, so that processes not yet switched to the SQL-based
  /// implementation see it too.
  Future<_LockState?> _tryClaimOrGet(String claimId) async {
    try {
      final now = clock.now().toUtc();
      final lockedUntil = now.add(_expiration).toUtc();
      final row = await primaryDatabase.withRetry(
        (db) => db.globalLockStates
            .insertValue(
              lockId: _lockId,
              claimId: claimId,
              lockedUntil: lockedUntil,
            )
            .onConflict(.primaryKey)
            .update(
              (_, excluded, set) => set(
                claimId: excluded.claimId,
                lockedUntil: excluded.lockedUntil,
              ),
            )
            .where(
              (existing, _) =>
                  existing.claimId.equalsValue('') |
                  existing.lockedUntil.isBeforeValue(now),
            )
            .returnUpserted()
            .executeAndFetch(),
      );
      if (row == null) {
        // Someone else already holds an active claim in SQL.
        return await _fetchSqlState();
      }
      await _mirrorToDatastore(
        _db,
        _lockId,
        claimId: claimId,
        lockedUntil: lockedUntil,
      );
      return (claimId: row.claimId, lockedUntil: row.lockedUntil);
    } on DatabaseException catch (e, st) {
      // Note: primaryDatabase.withRetry will have retried this, so this
      // means we have a high write congestion -- or, many connection issues.
      _log.shout('Write congestion trying to claim $_lockId', e, st);
      return null;
    }
  }

  Future<_LockState?> _fetchSqlState() async {
    final row = await primaryDatabase.withRetry(
      (db) => db.globalLockStates.byKey(_lockId).fetch(),
    );
    if (row == null) {
      return null;
    }
    return (claimId: row.claimId, lockedUntil: row.lockedUntil);
  }

  /// Claim lock, trying as many times as necessary.
  ///
  /// If [timeout] is given, [TimeoutException] is thrown if [timeout] is
  /// exceeded.
  /// If [abort] is given, [TimeoutException] is thrown if [abort] is completed.
  Future<GlobalLockClaim> claim({
    Duration? timeout,
    Completer<void>? abort,
  }) async {
    abort ??= Completer();
    final claimId = Ulid().toString();
    final s = clock.stopwatch()..start();

    var state = await _tryClaimOrGet(claimId);

    while (!_hasClaim(state, claimId) &&
        (timeout == null || s.elapsed < timeout) &&
        !abort.isCompleted) {
      if (state != null) {
        // Sleep till lockedUntil, and always sleep at-least 10% of _expiration
        var delay = state.lockedUntil.difference(clock.now().toUtc());
        if (delay < _expiration * 0.1) {
          delay = _expiration * 0.1;
        }
        // Wait for delay or abort
        await abort.future.timeout(delay, onTimeout: () => null);
      }
      state = await _tryClaimOrGet(claimId);
    }

    // Check if we got a claim
    if (_hasClaim(state, claimId)) {
      _log.info('established claim $claimId on $_lockId');
      return GlobalLockClaim._(
        _lockId,
        claimId,
        state!.lockedUntil,
        _expiration,
        _db,
      );
    }
    throw TimeoutException(
      'failed to acquire GlobalLock within timeout',
      timeout,
    );
  }
}

/// `true`, if [state] is claimed by [claimId], `false` if [state] is `null`.
bool _hasClaim(_LockState? state, String claimId) {
  return state != null &&
      state.claimId == claimId &&
      state.lockedUntil.isAfter(clock.now().toUtc());
}

/// Best-effort mirror of a claim (or its release) into Datastore, so that
/// processes not yet switched to the SQL-based implementation still see it.
Future<void> _mirrorToDatastore(
  DatastoreDB dbService,
  String lockId, {
  required String claimId,
  required DateTime lockedUntil,
}) async {
  try {
    final e = GlobalLockState()
      ..id = lockId
      ..claimId = claimId
      ..lockedUntil = lockedUntil;
    await dbService.commit(inserts: [e]);
  } catch (e, st) {
    _log.warning('Datastore GlobalLockState mirror failed: $lockId', e, st);
  }
}

class GlobalLockClaim {
  final String _lockId;
  final String _claimId;
  DateTime _lockedUntil;
  final Duration _expiration;
  final DatastoreDB _db;
  Future<void>? _released;

  GlobalLockClaim._(
    this._lockId,
    this._claimId,
    this._lockedUntil,
    this._expiration,
    this._db,
  );

  /// `true`, if this claim to the lock is still valid.
  ///
  /// A claim stops being valid when 75% of the expiration has passed.
  /// This offers some safety from clock drift. In most cases the claim should
  /// be refreshed long before we approach 75% of the expiration being passed.
  ///
  /// When a claim is refreshed 75% before expiration it allows us to use
  /// [expires] as _deadline_ for other operations.
  bool get valid =>
      _released == null &&
      _lockedUntil.subtract(_expiration * 0.25).isAfter(clock.now().toUtc());

  /// Point in time at which this claim expires, if not [refresh]'ed.
  ///
  /// To protect against clock drift we consider the claim invalid when 75% of
  /// the expiration time has passed.
  DateTime get expires => _lockedUntil;

  /// Refresh the claim, setting the expiration into the future.
  ///
  /// If locked with [GlobalLock.withClaim] there is no need to call this
  /// method.
  Future<bool> refresh() async {
    try {
      final newLockedUntil = clock.now().add(_expiration).toUtc();
      final rows = await primaryDatabase.withRetry(
        (db) => db.globalLockStates
            .where(
              (row) =>
                  row.lockId.equalsValue(_lockId) &
                  row.claimId.equalsValue(_claimId),
            )
            .update((row, set) => set(lockedUntil: newLockedUntil.asExpr))
            .returnUpdated()
            .executeAndFetch(),
      );
      if (rows.isEmpty) {
        return false;
      }
      _lockedUntil = newLockedUntil;
      await _mirrorToDatastore(
        _db,
        _lockId,
        claimId: _claimId,
        lockedUntil: newLockedUntil,
      );
      _log.info('refreshed claim $_claimId on $_lockId');
      return true;
    } on DatabaseException catch (e, st) {
      _log.shout('Write congestion trying to refresh $_lockId', e, st);
      return false;
    }
  }

  /// Release this claim to the lock.
  ///
  /// If locked with [GlobalLock.withClaim] there is no need to call this
  /// method, but doing so will cause reclaiming to cease.
  Future<void> release() async {
    // Never release more than once
    _released ??= _release();
    return await _released;
  }

  Future<void> _release() async {
    final now = clock.now().toUtc();
    try {
      final rows = await primaryDatabase.withRetry(
        (db) => db.globalLockStates
            .where(
              (row) =>
                  row.lockId.equalsValue(_lockId) &
                  row.claimId.equalsValue(_claimId),
            )
            .update(
              (row, set) => set(claimId: ''.asExpr, lockedUntil: now.asExpr),
            )
            .returnUpdated()
            .executeAndFetch(),
      );
      if (rows.isEmpty) {
        return;
      }
    } on DatabaseException {
      // Ignore write congestion if releasing the lock
      return;
    }
    // Note: the release is not mirrored into Datastore. The mirrored claim
    // there will simply expire at `lockedUntil` like any other claim.
    _log.info('releasing claim $_claimId on $_lockId');
  }
}
