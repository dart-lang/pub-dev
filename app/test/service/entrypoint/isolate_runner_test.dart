// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:isolate';

import 'package:logging/logging.dart';
import 'package:pub_dev/service/entrypoint/_isolate.dart';
import 'package:test/test.dart';

void main() {
  group('IsolateRunner', () {
    test('create -> wait -> close', () async {
      final logger = Logger.detached('test');
      final messages = <String>[];
      final subs = logger.onRecord.listen((event) {
        messages.add(event.message);
      });
      final runner = IsolateCollection(
        logger: logger,
        servicesWrapperFn: (fn) => fn(),
      );
      await runner.startGroup(
        kind: 'test',
        entryPoint: _main1,
        count: 2,
        deadTimeout: Duration(minutes: 1),
      );

      await Future.delayed(Duration(seconds: 2));
      expect(messages, hasLength(6));
      expect(
        messages,
        containsAll([
          contains('About to start test isolate #1'),
          contains('About to start test isolate #2'),
          contains('test isolate #1 started'),
          contains('test isolate #2 started'),
          contains('Debug message from test isolate #1:'),
          contains('Debug message from test isolate #2:'),
        ]),
      );

      await runner.close();
      await subs.cancel();

      expect(messages, hasLength(10));
      expect(
        messages,
        containsAll([
          contains('About to close test isolate #1'),
          contains('About to close test isolate #2'),
          contains('test isolate #1 closed'),
          contains('test isolate #2 closed'),
        ]),
      );
    });

    test('start -> end', () async {
      final logger = Logger.detached('test');
      final messages = <String>[];
      final subs = logger.onRecord.listen((event) {
        messages.add(event.message);
      });
      final runner = IsolateCollection(
        logger: logger,
        servicesWrapperFn: (fn) => fn(),
      );
      await runner.startGroup(
        kind: 'test',
        entryPoint: _main2,
        count: 1,
        deadTimeout: Duration(minutes: 1),
      );

      await Future.delayed(Duration(seconds: 1));
      expect(
        messages,
        [
          'About to start test isolate #1 ...',
          'test isolate #1 started.',
          'test isolate #1 exited.',
          'About to close test isolate #1 ...',
          'test isolate #1 closed.',
        ],
      );
      // second isolate starts after 6 seconds
      await Future.delayed(Duration(seconds: 7));
      expect(
          messages,
          containsAll([
            'About to start test isolate #2 ...',
            'test isolate #2 started.',
            'test isolate #2 exited.',
            'About to close test isolate #2 ...',
            'test isolate #2 closed.',
          ]));

      await runner.close();
      await subs.cancel();
    });

    test('renew', () async {
      final logger = Logger.detached('test');
      final messages = <String>[];
      final subs = logger.onRecord.listen((event) {
        messages.add(event.message);
      });
      final runner = IsolateCollection(
        logger: logger,
        servicesWrapperFn: (fn) => fn(),
      );
      final group = await runner.startGroup(
        kind: 'test',
        entryPoint: _main4,
        count: 1,
        deadTimeout: Duration(minutes: 1),
      );

      await Future.delayed(Duration(seconds: 1));
      expect(
        messages,
        [
          'About to start test isolate #1 ...',
          'test isolate #1 started.',
        ],
      );
      // renew isolate
      await group.renew(wait: Duration(seconds: 1));
      await Future.delayed(Duration(seconds: 1));
      expect(
          messages,
          containsAll([
            'About to start test isolate #1 ...',
            'test isolate #1 started.',
            'About to start test isolate #2 ...',
            'test isolate #2 started.',
            'About to close test isolate #1 ...',
            'test isolate #1 closed.'
          ]));

      await runner.close();
      await subs.cancel();
    });

    test('throws', () async {
      final logger = Logger.detached('test');
      final messages = <String>[];
      final subs = logger.onRecord.listen((event) {
        messages.add(event.message);
      });
      final runner = IsolateCollection(
        logger: logger,
        servicesWrapperFn: (fn) => fn(),
      );
      await runner.startGroup(
        kind: 'test',
        entryPoint: _main3,
        count: 1,
        deadTimeout: Duration(minutes: 1),
      );

      await Future.delayed(Duration(seconds: 1));
      expect(
        messages,
        [
          'About to start test isolate #1 ...',
          'test isolate #1 started.',
          'ERROR from test isolate #1',
          'About to close test isolate #1 ...',
          'test isolate #1 closed.',
        ],
      );
      // second isolate starts after 6 seconds
      await Future.delayed(Duration(seconds: 7));
      expect(
          messages,
          containsAll([
            'About to start test isolate #2 ...',
            'test isolate #2 started.',
            'ERROR from test isolate #2',
            'About to close test isolate #2 ...',
            'test isolate #2 closed.',
          ]));

      await runner.close();
      await subs.cancel();
    });
  });
}

Future<void> _main1(EntryMessage message) async {
  message.protocolSendPort.send(ReadyMessage());
  final currentIsolate = Isolate.current;
  message.protocolSendPort.send(DebugMessage('${currentIsolate.debugName}'));
  await Completer().future;
}

Future<void> _main2(EntryMessage message) async {
  message.protocolSendPort.send(ReadyMessage());
}

Future<void> _main3(EntryMessage message) async {
  message.protocolSendPort.send(ReadyMessage());
  throw Exception('ex');
}

Future<void> _main4(EntryMessage message) async {
  message.protocolSendPort.send(ReadyMessage());
  await Completer().future;
}
