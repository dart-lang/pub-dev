// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pub_dev/task/cloudcompute/cloudcompute.dart';

final _log = Logger('pub.task.zone_tracker');

/// Tracks compute zones and custom ban periods.
final class ComputeZoneTracker {
  final List<String> _zones;
  final _bannedUntil = <String, DateTime>{};

  int _nextZoneIndex = 0;

  ComputeZoneTracker(this._zones);

  /// Creates or extends zone ban period.
  void banZone(String zone, {int minutes = 0}) {
    final until = clock.fromNow(minutes: minutes);
    final currentBan = _bannedUntil[zone];
    if (currentBan == null || currentBan.isBefore(until)) {
      _bannedUntil[zone] = until;
    }
  }

  void _pruneBans() {
    final now = clock.now();
    _bannedUntil.removeWhere((k, v) => v.isBefore(now));
  }

  /// Whether there is any available zone that is not banned.
  bool hasAvailableZone() {
    _pruneBans();
    return _zones.any((zone) => !_bannedUntil.containsKey(zone));
  }

  /// Tries to pick an available zone.
  ///
  /// Zone selection follows a round-robin algorithm, skipping the banned zones.
  ///
  /// Returns `null` if there is no zone available.
  String? tryPickZone() {
    _pruneBans();
    // cursor may be moved at most the number of zones times
    for (var i = 0; i < _zones.length; i++) {
      final zone = _zones[_nextZoneIndex];
      _nextZoneIndex = (_nextZoneIndex + 1) % _zones.length;
      if (!_bannedUntil.containsKey(zone)) {
        return zone;
      }
    }
    return null;
  }

  /// Executes [fn] in compute [zone] and handles zone-related exceptions
  /// with the appropriate bans.
  Future<void> withZoneAndInstance(
    String zone,
    String instanceName,
    Future<void> Function() fn,
  ) async {
    try {
      await fn();
    } on ZoneExhaustedException catch (e, st) {
      // A zone being exhausted is normal operations, we just use another
      // zone for 15 minutes.
      _log.info(
        'zone resources exhausted, banning ${e.zone} for 30 minutes',
        e,
        st,
      );
      // Ban usage of zone for 30 minutes
      banZone(e.zone, minutes: 30);
    } on QuotaExhaustedException catch (e, st) {
      // Quota exhausted, this can happen, but it shouldn't. We'll just stop
      // doing anything for 10 minutes. Hopefully that'll resolve the issue.
      // We log severe, because this is a reason to adjust the quota or
      // instance limits.
      _log.severe(
        'Quota exhausted trying to create $instanceName, banning all zones '
        'for 10 minutes',
        e,
        st,
      );

      // Ban all zones for 10 minutes
      for (final zone in _zones) {
        banZone(zone, minutes: 10);
      }
    } on Exception catch (e, st) {
      // No idea what happened, but for robustness we'll stop using the zone
      // and shout into the logs
      _log.shout(
        'Failed to create instance $instanceName, banning zone "$zone" for '
        '15 minutes',
        e,
        st,
      );
      // Ban usage of zone for 15 minutes
      banZone(zone, minutes: 15);
    }
  }
}
