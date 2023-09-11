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
      final runner = IsolateRunner(
        logger: logger,
        servicesWrapperFn: (fn) => fn(),
        kind: 'test',
        entryPoint: _main1,
      );
      await runner.start(2);

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

    test('renew', () async {
      final logger = Logger.detached('test');
      final messages = <String>[];
      final subs = logger.onRecord.listen((event) {
        messages.add(event.message);
      });
      final runner = IsolateRunner(
        logger: logger,
        servicesWrapperFn: (fn) => fn(),
        kind: 'test',
        entryPoint: _main4,
      );
      await runner.start(1);

      await Future.delayed(Duration(seconds: 1));
      expect(
        messages,
        [
          'About to start test isolate #1 ...',
          'test isolate #1 started.',
        ],
      );
      // renew isolate
      await runner.renew(count: 1, wait: Duration(seconds: 1));
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
      final runner = IsolateRunner(
        logger: logger,
        servicesWrapperFn: (fn) => fn(),
        kind: 'test',
        entryPoint: _main3,
      );
      await runner.start(1);

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
      // second isolate is not started
      await Future.delayed(Duration(seconds: 7));
      expect(
          messages,
          isNot(containsAll([
            'About to start test isolate #2 ...',
            'test isolate #2 started.',
            'ERROR from test isolate #2',
            'About to close test isolate #2 ...',
            'test isolate #2 closed.',
          ])));

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

Future<void> _main3(EntryMessage message) async {
  message.protocolSendPort.send(ReadyMessage());
  throw Exception('ex');
}

Future<void> _main4(EntryMessage message) async {
  message.protocolSendPort.send(ReadyMessage());
  await Completer().future;
}
