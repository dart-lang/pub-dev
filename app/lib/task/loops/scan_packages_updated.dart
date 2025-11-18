// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';

/// The internal state for deciding which package needs to be updated.
class ScanPackagesUpdatedState {
  /// The last time the algorithm checked on a package.
  final Map<String, DateTime> seen;

  /// The cycle's reference timestamp.
  final DateTime since;

  /// Most scan cycle will process changes only from a short time period,
  /// however, periodically we want to process a longer overlap window.
  /// This timestamp indicates the future time when such longer scan should happen.
  final DateTime nextLongerOverlap;

  ScanPackagesUpdatedState({
    required this.seen,
    required this.since,
    required this.nextLongerOverlap,
  });

  factory ScanPackagesUpdatedState.init({
    Map<String, DateTime>? seen,
  }) => ScanPackagesUpdatedState(
    seen: seen ?? {},
    // In theory 30 minutes overlap should be enough. In practice we should
    // allow an ample room for missed windows, and 3 days seems to be large enough.
    since: clock.ago(days: 3),
    // We will schedule longer overlaps every 6 hours.
    nextLongerOverlap: clock.fromNow(hours: 6),
  );
}

/// The result of the scan package operation.
class ScanPackagesUpdatedNextState {
  /// The next state of the data.
  final ScanPackagesUpdatedState state;

  /// The package to update.
  final List<String> packages;

  ScanPackagesUpdatedNextState({required this.state, required this.packages});
}

/// Calculates the next state of scan packages updated loop by
/// processing the input [stream].
Future<ScanPackagesUpdatedNextState> calculateScanPackagesUpdatedLoop(
  ScanPackagesUpdatedState state,
  Stream<({String name, DateTime updated})> stream,
  bool Function() isAbortedFn,
) async {
  var since = state.since;
  var nextLongScan = state.nextLongerOverlap;
  if (clock.now().isAfter(state.nextLongerOverlap)) {
    // Next time we'll do a longer scan
    since = clock.ago(days: 1);
    nextLongScan = clock.fromNow(hours: 6);
  } else {
    // Next time we'll only consider changes since now - 30 minutes
    since = clock.ago(minutes: 30);
  }

  final seen = {...state.seen};
  final packages = <String>[];

  await for (final p in stream) {
    if (isAbortedFn()) {
      break;
    }
    // Check if the [updated] timestamp has been seen before.
    // If so, we skip checking it!
    final lastSeen = seen[p.name];
    if (lastSeen != null && lastSeen.toUtc() == p.updated.toUtc()) {
      continue;
    }
    // Remember the updated time for this package, so we don't check it
    // again...
    seen[p.name] = p.updated;
    // Needs to be updated.
    packages.add(p.name);
  }

  // Cleanup the [seen] map for anything older than [since], as this won't
  // be relevant to the next iteration.
  seen.removeWhere((_, updated) => updated.isBefore(since));

  return ScanPackagesUpdatedNextState(
    state: ScanPackagesUpdatedState(
      seen: seen,
      since: since,
      nextLongerOverlap: nextLongScan,
    ),
    packages: packages,
  );
}
