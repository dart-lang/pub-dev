// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:pub_dev/audit/backend.dart';

import '../../account/agent.dart';
import '../../audit/models.dart';
import '../../shared/configuration.dart';
import '../../shared/exceptions.dart';
import '../../shared/redis_cache.dart';

/// Verifies if the current package upload has a rate limit and throws
/// if the limit has been exceeded.
Future<void> verifyPackageUploadRateLimit({
  required AuthenticatedAgent agent,
  required String package,
}) async {
  final operation = AuditLogRecordKind.packagePublished;

  if (agent is AuthenticatedUser) {
    await _verifyRateLimit(
      rateLimit: _getRateLimit(operation, RateLimitScope.user),
      userId: agent.userId,
    );
  } else {
    // apply per-user rate limit on non-user agents as they were package-specific limits
    await _verifyRateLimit(
      rateLimit: _getRateLimit(operation, RateLimitScope.user),
      package: package,
    );
  }

  // regular package-specific limits
  await _verifyRateLimit(
    rateLimit: _getRateLimit(operation, RateLimitScope.package),
    package: package,
  );
}

RateLimit? _getRateLimit(String operation, RateLimitScope scope) {
  return activeConfiguration.rateLimits?.firstWhereOrNull(
    (r) => r.operation == operation && r.scope == scope,
  );
}

Future<void> _verifyRateLimit({
  required RateLimit? rateLimit,
  String? package,
  String? userId,
}) async {
  if (rateLimit == null) {
    return;
  }
  if (rateLimit.burst == null &&
      rateLimit.hourly == null &&
      rateLimit.daily == null) {
    return;
  }

  final cacheKeyParts = [
    rateLimit.operation,
    rateLimit.scope.name,
    if (package != null) 'package-$package',
    if (userId != null) 'userId-$userId',
  ];
  final entryKey = Uri(pathSegments: cacheKeyParts).toString();

  final auditEntriesFromLastDay = await auditBackend.getEntriesFromLastDay();

  Future<void> check({
    required Duration window,
    required int? maxCount,
    required String windowAsText,
  }) async {
    if (maxCount == null || maxCount <= 0) {
      return;
    }

    final entry = cache.rateLimitUntil(entryKey);
    final current = await entry.get();
    if (current != null && current.isAfter(clock.now())) {
      throw RateLimitException(
        maxCount: maxCount,
        window: window,
        windowAsText: windowAsText,
      );
    }

    final now = clock.now().toUtc();
    final windowStart = now.subtract(window);
    final relevantEntries = auditEntriesFromLastDay
        .where((e) => e.kind == rateLimit.operation)
        .where((e) => e.created!.isAfter(windowStart))
        .where((e) => package == null || _containsPackage(e.packages, package))
        .where((e) => userId == null || _containsUserId(e.users, userId))
        .toList();

    if (relevantEntries.length >= maxCount) {
      final firstTimestamp = relevantEntries
          .map((e) => e.created!)
          .reduce((a, b) => a.isBefore(b) ? a : b);
      await entry.set(firstTimestamp.add(window), window);
      throw RateLimitException(
        maxCount: maxCount,
        window: window,
        windowAsText: windowAsText,
      );
    }
  }

  await check(
    window: Duration(minutes: 2),
    maxCount: rateLimit.burst,
    windowAsText: 'last few minutes',
  );
  await check(
    window: Duration(hours: 1),
    maxCount: rateLimit.hourly,
    windowAsText: 'last hour',
  );
  await check(
    window: Duration(days: 1),
    maxCount: rateLimit.daily,
    windowAsText: 'last day',
  );
}

bool _containsPackage(
  List<String>? packages,
  String package,
) {
  if (packages == null || packages.isEmpty) {
    return false;
  }
  return packages.contains(package);
}

bool _containsUserId(
  List<String>? users,
  String userId,
) {
  if (users == null || users.isEmpty) {
    return false;
  }
  return users.contains(userId);
}
