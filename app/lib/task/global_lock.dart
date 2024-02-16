// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:clock/clock.dart';
import 'package:logging/logging.dart' show Logger;
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/task/global_lock_models.dart';
import 'package:ulid/ulid.dart' show Ulid;

final _log = Logger('pub.global_lock');

class GlobalLock {
  final String _lockId;
  final Duration _expiration;
  final DatastoreDB _db;

  GlobalLock._(this._lockId, this._expiration, this._db);

  static GlobalLock create(
    String lockId, {
    Duration expiration = const Duration(minutes: 25),
  }) =>
      GlobalLock._(lockId, expiration, dbService);

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
    final claimId = c._entry.claimId;
    var refreshed = Future.value(true);
    final done = Completer<void>();
    scheduleMicrotask(() async {
      try {
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
          // refresh, before it's truely expired.

          // Wait for done or delay
          await done.future.timeout(delay, onTimeout: () => null);

          // Try to refresh, if claim is still valid and we're not done.
          if (c.valid && !done.isCompleted) {
            refreshed = c.refresh();
            if (!await refreshed) {
              _log.warning('failed to refresh claim $claimId on $_lockId');
              return; // Stop refreshing, if refresh failed.
            }
          }
        }
      } on Exception catch (e, st) {
        // Stop refreshing, and log the error
        _log.severe('Error refreshing claim $claimId on $_lockId', e, st);
        return;
      }
    });
    try {
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
    final e = await _tryClaimOrGet(claimId);

    // Check if we got a claim
    if (e != null && _hasClaim(e, claimId)) {
      _log.info('established claim $claimId on $_lockId');
      return GlobalLockClaim._(e, _expiration, _db);
    }
    return null;
  }

  Future<GlobalLockState?> _tryClaimOrGet(String claimId) async {
    final k = _db.emptyKey.append(GlobalLockState, id: _lockId);
    try {
      return await withRetryTransaction(_db, (tx) async {
        var e = await tx.lookupOrNull<GlobalLockState>(k);
        if (e == null ||
            e.claimId == '' ||
            e.lockedUntil!.isBefore(clock.now().toUtc())) {
          // Claim the lock, if not currently locked
          e = GlobalLockState()
            ..id = _lockId
            ..claimId = claimId
            ..lockedUntil = clock.now().add(_expiration).toUtc();
          tx.insert(e);
        }
        return e;
      });
    } on TransactionAbortedError {
      // Note: withRetryTransaction will have retried this, so this means we
      // a high write congestion -- or, many connection exceptions.
      _log.shout('Write congestion tryingt to claim $_lockId');
      return null;
    }
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

    var e = await _tryClaimOrGet(claimId);

    while (!_hasClaim(e, claimId) &&
        (timeout == null || s.elapsed < timeout) &&
        !abort.isCompleted) {
      if (e != null) {
        // Sleep till lockedUntil, and always sleep at-least 10% of _expiration
        var delay = e.lockedUntil!.difference(clock.now().toUtc());
        if (delay < _expiration * 0.1) {
          delay = _expiration * 0.1;
        }
        // Wait for delay or abort
        await abort.future.timeout(delay, onTimeout: () => null);
      }
      e = await _tryClaimOrGet(claimId);
    }

    // Check if we got a claim
    if (e != null && _hasClaim(e, claimId)) {
      _log.info('established claim $claimId on $_lockId');
      return GlobalLockClaim._(e, _expiration, _db);
    }
    throw TimeoutException(
      'failed to acquire GlobalLock within timeout',
      timeout,
    );
  }
}

/// `true`, if [e] is claimed by [claimId], `false` if [e] is `null`.
bool _hasClaim(GlobalLockState? e, String claimId) {
  return e != null &&
      e.claimId == claimId &&
      e.lockedUntil!.isAfter(clock.now().toUtc());
}

class GlobalLockClaim {
  GlobalLockState _entry;
  final Duration _expiration;
  final DatastoreDB _db;
  Future<void>? _released;

  GlobalLockClaim._(this._entry, this._expiration, this._db);

  /// `true`, if this claim to the lock is still valid.
  ///
  /// A claim stops being valid when 75% of the expiration has passed.
  /// This offers some safety from clock drift. In most cases the claim should
  /// be refreshed long before we approach 75% of the expiration being passed.
  ///
  /// When a claim is refreshed 75% before expiration it allows allows us to use
  /// [expires] as _deadline_ for other operations.
  bool get valid =>
      _released == null &&
      _entry.lockedUntil!
          .subtract(_expiration * 0.25)
          .isAfter(clock.now().toUtc());

  /// Point in time at which this claim expires, if not [refresh]'ed.
  ///
  /// To protect against clock drift we consider the claim invalid when 75% of
  /// the expiration time has passed.
  DateTime get expires => _entry.lockedUntil!;

  /// Refresh the claim, setting the expiration into the future.
  ///
  /// If locked with [GlobalLock.withClaim] there is no need to call this
  /// method.
  Future<bool> refresh() async {
    try {
      final e = await withRetryTransaction(_db, (tx) async {
        final e = await tx.lookupOrNull<GlobalLockState>(_entry.key);

        if (e != null && _hasClaim(e, _entry.claimId!)) {
          e.claimId = _entry.claimId;
          e.lockedUntil = clock.now().add(_expiration).toUtc();
          tx.insert(e);
        }
        return e;
      });

      // If we refreshed the claim we update internal state
      if (e != null && _hasClaim(e, _entry.claimId!)) {
        _entry = e;
        _log.info('refreshed claim ${_entry.claimId} on ${_entry.lockId}');
        return true;
      }
      return false;
    } on TransactionAbortedError {
      // Note: withRetryTransaction will have retried this, so this means we
      // a high write congestion -- or, many connection exceptions.
      _log.shout('Write congestion tryingt to refresh $_entry.lockId');
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
    try {
      await withRetryTransaction(_db, (tx) async {
        final e = await tx.lookupOrNull<GlobalLockState>(_entry.key);

        if (e != null && _hasClaim(e, _entry.claimId!)) {
          _log.info('releasing claim ${_entry.claimId} on ${_entry.lockId}');
          e.claimId = '';
          e.lockedUntil = clock.now().toUtc();
          tx.insert(e);
        }
      });
    } on TransactionAbortedError {
      // Ignore write congestion if releasing the lock
    }
  }
}
