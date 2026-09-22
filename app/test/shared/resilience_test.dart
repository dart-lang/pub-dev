// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:pub_dev/shared/resilience.dart';
import 'package:test/test.dart';

void main() {
  group('metrics reporting', () {
    late PubResilience resilience;
    late List<LogRecord> records;
    late StreamSubscription<LogRecord> subscription;

    setUp(() {
      records = [];
      subscription = Logger.root.onRecord.listen(records.add);
      resilience = PubResilience.create();
    });

    tearDown(() async {
      await resilience.close();
      await subscription.cancel();
    });

    List<Map<String, Object?>> snapshotsIn(List<LogRecord> records) => [
      for (final record in records)
        if (record.message.startsWith('[resilience] '))
          json.decode(record.message.substring('[resilience] '.length))
              as Map<String, Object?>,
    ];

    test('writes one snapshot per resource', () {
      resilience.reportMetrics();

      final names = [
        for (final snapshot in snapshotsIn(records)) snapshot['resource'],
      ];
      expect(names, [
        'cloud-storage',
        'search-service',
        'search-service-fallback',
        'redis-cache',
        'secret-manager',
      ]);
    });

    test('counts an operation against the resource it ran on', () async {
      await resilience.redisCache.execute(() async => 'cached');
      resilience.reportMetrics();

      final snapshot = snapshotsIn(
        records,
      ).firstWhere((s) => s['resource'] == 'redis-cache');
      final counters = snapshot['counters']! as Map<String, Object?>;
      expect((counters['outcomes']! as Map)['success'], 1);
      expect(counters['totalOperations'], 1);
      expect(snapshot['circuitState'], 'closed');
    });

    test('separates a shed request from a backend failure', () async {
      // Five consecutive failures open the redis circuit, see [PubResilience].
      for (var i = 0; i < 5; i++) {
        await expectLater(
          resilience.redisCache.execute(() async => throw Exception('down')),
          throwsA(isA<Exception>()),
        );
      }
      await expectLater(
        resilience.redisCache.execute(() async => 'never runs'),
        throwsA(isA<CircuitBreakerOpenException>()),
      );

      resilience.reportMetrics();
      final snapshot = snapshotsIn(
        records,
      ).firstWhere((s) => s['resource'] == 'redis-cache');
      final counters = snapshot['counters']! as Map<String, Object?>;
      final outcomes = counters['outcomes']! as Map;

      expect(outcomes['backendFailure'], 5);
      expect(outcomes['circuitOpen'], 1);
      expect(counters['circuitOpens'], 1);
      expect(snapshot['circuitState'], 'open');
    });

    test('notices a circuit that opens repeatedly between reports', () async {
      Future<void> tripTheCircuit() async {
        for (var i = 0; i < 5; i++) {
          await expectLater(
            resilience.redisCache.execute(() async => throw Exception('down')),
            throwsA(isA<Exception>()),
          );
        }
      }

      // A single opening is already reported by the event listener, so the
      // first report must not add a flapping notice of its own.
      await tripTheCircuit();
      resilience.reportMetrics();
      expect(
        records.where((r) => r.message.contains('circuit-flapping')),
        isEmpty,
      );

      // Recover, trip again, twice, without a report in between. Only the
      // circuit is reset; the cumulative counters are what is under test.
      for (var i = 0; i < 2; i++) {
        resilience.context.states['redis-cache']!.resetCircuitBreaker();
        await tripTheCircuit();
      }
      records.clear();
      resilience.reportMetrics();

      expect(
        records.map((r) => r.message),
        contains(
          allOf(
            contains('circuit-flapping'),
            contains('`redis-cache` opened 2 times'),
          ),
        ),
      );
    });
  });
}
