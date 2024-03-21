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

Future<void> verifyAuditLogRecordRateLimits(AuditLogRecord record) async {
  final agentId = record.agent;
  await _verifyRateLimit(
    rateLimit: _getRateLimit(record.kind!, RateLimitScope.user),
    agentId: agentId,
  );
  final packages = record.packages;
  if (packages != null && packages.isNotEmpty) {
    final rateLimit = _getRateLimit(record.kind!, RateLimitScope.package);
    for (final p in packages) {
      await _verifyRateLimit(rateLimit: rateLimit, package: p);
    }
  }
}

RateLimit? _getRateLimit(String operation, RateLimitScope scope) {
  return activeConfiguration.rateLimits?.firstWhereOrNull(
    (r) => r.operation == operation && r.scope == scope,
  );
}

Future<void> _verifyRateLimit({
  required RateLimit? rateLimit,
  String? package,
  String? agentId,
}) async {
  assert(agentId != null || package != null);
  if (agentId == KnownAgents.pubSupport) {
    /// admin account actions are allowed without any rate limit
    return;
  }
  if (rateLimit == null) {
    return;
  }
  if (rateLimit.burst == null &&
      rateLimit.hourly == null &&
      rateLimit.daily == null) {
    return;
  }

  final cacheEntryKey = [
    rateLimit.operation,
    rateLimit.scope.name,
    if (package != null) 'package-$package',
    if (agentId != null) 'agentId-$agentId',
  ].join('/');

  List<AuditLogRecord>? auditEntriesFromLastDay;

  Future<void> check({
    required String operation,
    required Duration window,
    required int? maxCount,
    required String windowAsText,
  }) async {
    if (maxCount == null || maxCount <= 0) {
      return;
    }

    final entry = cache.rateLimitUntil(cacheEntryKey);
    final current = await entry.get();
    if (current != null && current.isAfter(clock.now())) {
      throw RateLimitException(
        operation: operation,
        maxCount: maxCount,
        window: window,
        windowAsText: windowAsText,
      );
    }

    auditEntriesFromLastDay ??= await auditBackend.getEntriesFromLastDay();

    final now = clock.now().toUtc();
    final windowStart = now.subtract(window);
    final relevantEntries = auditEntriesFromLastDay!
        .where((e) => e.kind == rateLimit.operation)
        .where((e) => e.created!.isAfter(windowStart))
        .where((e) => package == null || _containsPackage(e.packages, package))
        .where((e) =>
            agentId == null ||
            e.agent == agentId ||
            _containsUserId(e.users, agentId))
        .toList();

    if (relevantEntries.length >= maxCount) {
      final firstTimestamp = relevantEntries
          .map((e) => e.created!)
          .reduce((a, b) => a.isBefore(b) ? a : b);
      await entry.set(firstTimestamp.add(window), window);
      throw RateLimitException(
        operation: operation,
        maxCount: maxCount,
        window: window,
        windowAsText: windowAsText,
      );
    }
  }

  await check(
    operation: rateLimit.operation,
    window: Duration(minutes: 2),
    maxCount: rateLimit.burst,
    windowAsText: 'last few minutes',
  );
  await check(
    operation: rateLimit.operation,
    window: Duration(hours: 1),
    maxCount: rateLimit.hourly,
    windowAsText: 'last hour',
  );
  await check(
    operation: rateLimit.operation,
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
