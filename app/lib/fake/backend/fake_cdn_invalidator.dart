// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import '../../service/cdn/cdn_invalidator.dart';

/// Gets the active [FakeCdnInvalidator] registered in the current service scope.
FakeCdnInvalidator get fakeCdnInvalidator =>
    cdnInvalidator as FakeCdnInvalidator;

/// In-memory [CdnInvalidator] for local runs and tests.
final class FakeCdnInvalidator implements CdnInvalidator {
  /// All deduplicated path patterns passed to [invalidatePaths], in order.
  final invalidatedPaths = <String>[];

  /// Optional callback invoked with the deduplicated paths on each non-empty
  /// [invalidatePaths] call.
  FutureOr<void> Function(List<String> paths)? onInvalidate;

  @override
  Future<void> invalidatePaths(Iterable<String> paths) async {
    final uniquePaths = <String>{};
    for (final path in paths) {
      validateCdnInvalidationPath(path);
      uniquePaths.add(path);
    }
    if (uniquePaths.isEmpty) {
      return;
    }
    final batch = List<String>.unmodifiable(uniquePaths);
    invalidatedPaths.addAll(batch);
    await onInvalidate?.call(batch);
  }

  @override
  Future<void> close() async {}
}
