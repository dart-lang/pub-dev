// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:path/path.dart' as p;
import 'package:stack_trace/stack_trace.dart';
import 'package:test/test.dart';

import 'utils.dart';

typedef void ChainErrorCallback(stack, Chain chain);

void main() {
  group('Chain.parse()', () {
    test('parses a real Chain', () {
      return captureFuture(() => inMicrotask(() => throw 'error'))
          .then((chain) {
        expect(new Chain.parse(chain.toString()).toString(),
            equals(chain.toString()));
      });
    });

    test('parses an empty string', () {
      var chain = new Chain.parse('');
      expect(chain.traces, isEmpty);
    });

    test('parses a chain containing empty traces', () {
      var chain =
          new Chain.parse('===== asynchronous gap ===========================\n'
              '===== asynchronous gap ===========================\n');
      expect(chain.traces, hasLength(3));
      expect(chain.traces[0].frames, isEmpty);
      expect(chain.traces[1].frames, isEmpty);
      expect(chain.traces[2].frames, isEmpty);
    });
  });

  group("Chain.capture() with when: false", () {
    test("with no onError doesn't block errors", () {
      expect(Chain.capture(() => new Future.error("oh no"), when: false),
          throwsA("oh no"));
    });

    test("with onError blocks errors", () {
      Chain.capture(() {
        return new Future.error("oh no");
      }, onError: expectAsync2((error, chain) {
        expect(error, equals("oh no"));
        expect(chain, new isInstanceOf<Chain>());
      }), when: false);
    });

    test("doesn't enable chain-tracking", () {
      return Chain.disable(() {
        return Chain.capture(() {
          var completer = new Completer();
          inMicrotask(() {
            completer.complete(new Chain.current());
          });

          return completer.future.then((chain) {
            expect(chain.traces, hasLength(1));
          });
        }, when: false);
      });
    });
  });

  group("Chain.disable()", () {
    test("disables chain-tracking", () {
      return Chain.disable(() {
        var completer = new Completer();
        inMicrotask(() => completer.complete(new Chain.current()));

        return completer.future.then((chain) {
          expect(chain.traces, hasLength(1));
        });
      });
    });

    test("Chain.capture() re-enables chain-tracking", () {
      return Chain.disable(() {
        return Chain.capture(() {
          var completer = new Completer();
          inMicrotask(() => completer.complete(new Chain.current()));

          return completer.future.then((chain) {
            expect(chain.traces, hasLength(2));
          });
        });
      });
    });

    test("preserves parent zones of the capture zone", () {
      // The outer disable call turns off the test package's chain-tracking.
      return Chain.disable(() {
        return runZoned(() {
          return Chain.capture(() {
            expect(Chain.disable(() => Zone.current[#enabled]), isTrue);
          });
        }, zoneValues: {#enabled: true});
      });
    });

    test("preserves child zones of the capture zone", () {
      // The outer disable call turns off the test package's chain-tracking.
      return Chain.disable(() {
        return Chain.capture(() {
          return runZoned(() {
            expect(Chain.disable(() => Zone.current[#enabled]), isTrue);
          }, zoneValues: {#enabled: true});
        });
      });
    });

    test("with when: false doesn't disable", () {
      return Chain.capture(() {
        return Chain.disable(() {
          var completer = new Completer();
          inMicrotask(() => completer.complete(new Chain.current()));

          return completer.future.then((chain) {
            expect(chain.traces, hasLength(2));
          });
        }, when: false);
      });
    });
  });

  test("toString() ensures that all traces are aligned", () {
    var chain = new Chain([
      new Trace.parse('short 10:11  Foo.bar\n'),
      new Trace.parse('loooooooooooong 10:11  Zop.zoop')
    ]);

    expect(
        chain.toString(),
        equals('short 10:11            Foo.bar\n'
            '===== asynchronous gap ===========================\n'
            'loooooooooooong 10:11  Zop.zoop\n'));
  });

  var userSlashCode = p.join('user', 'code.dart');
  group('Chain.terse', () {
    test('makes each trace terse', () {
      var chain = new Chain([
        new Trace.parse('dart:core 10:11       Foo.bar\n'
            'dart:core 10:11       Bar.baz\n'
            'user/code.dart 10:11  Bang.qux\n'
            'dart:core 10:11       Zip.zap\n'
            'dart:core 10:11       Zop.zoop'),
        new Trace.parse('user/code.dart 10:11                        Bang.qux\n'
            'dart:core 10:11                             Foo.bar\n'
            'package:stack_trace/stack_trace.dart 10:11  Bar.baz\n'
            'dart:core 10:11                             Zip.zap\n'
            'user/code.dart 10:11                        Zop.zoop')
      ]);

      expect(
          chain.terse.toString(),
          equals('dart:core             Bar.baz\n'
              '$userSlashCode 10:11  Bang.qux\n'
              '===== asynchronous gap ===========================\n'
              '$userSlashCode 10:11  Bang.qux\n'
              'dart:core             Zip.zap\n'
              '$userSlashCode 10:11  Zop.zoop\n'));
    });

    test('eliminates internal-only traces', () {
      var chain = new Chain([
        new Trace.parse('user/code.dart 10:11  Foo.bar\n'
            'dart:core 10:11       Bar.baz'),
        new Trace.parse('dart:core 10:11                             Foo.bar\n'
            'package:stack_trace/stack_trace.dart 10:11  Bar.baz\n'
            'dart:core 10:11                             Zip.zap'),
        new Trace.parse('user/code.dart 10:11  Foo.bar\n'
            'dart:core 10:11       Bar.baz')
      ]);

      expect(
          chain.terse.toString(),
          equals('$userSlashCode 10:11  Foo.bar\n'
              '===== asynchronous gap ===========================\n'
              '$userSlashCode 10:11  Foo.bar\n'));
    });

    test("doesn't return an empty chain", () {
      var chain = new Chain([
        new Trace.parse('dart:core 10:11                             Foo.bar\n'
            'package:stack_trace/stack_trace.dart 10:11  Bar.baz\n'
            'dart:core 10:11                             Zip.zap'),
        new Trace.parse('dart:core 10:11                             A.b\n'
            'package:stack_trace/stack_trace.dart 10:11  C.d\n'
            'dart:core 10:11                             E.f')
      ]);

      expect(chain.terse.toString(), equals('dart:core  E.f\n'));
    });

    // Regression test for #9
    test("doesn't crash on empty traces", () {
      var chain = new Chain([
        new Trace.parse('user/code.dart 10:11  Bang.qux'),
        new Trace([]),
        new Trace.parse('user/code.dart 10:11  Bang.qux')
      ]);

      expect(
          chain.terse.toString(),
          equals('$userSlashCode 10:11  Bang.qux\n'
              '===== asynchronous gap ===========================\n'
              '$userSlashCode 10:11  Bang.qux\n'));
    });
  });

  group('Chain.foldFrames', () {
    test('folds each trace', () {
      var chain = new Chain([
        new Trace.parse('a.dart 10:11  Foo.bar\n'
            'a.dart 10:11  Bar.baz\n'
            'b.dart 10:11  Bang.qux\n'
            'a.dart 10:11  Zip.zap\n'
            'a.dart 10:11  Zop.zoop'),
        new Trace.parse('a.dart 10:11  Foo.bar\n'
            'a.dart 10:11  Bar.baz\n'
            'a.dart 10:11  Bang.qux\n'
            'a.dart 10:11  Zip.zap\n'
            'b.dart 10:11  Zop.zoop')
      ]);

      var folded = chain.foldFrames((frame) => frame.library == 'a.dart');
      expect(
          folded.toString(),
          equals('a.dart 10:11  Bar.baz\n'
              'b.dart 10:11  Bang.qux\n'
              'a.dart 10:11  Zop.zoop\n'
              '===== asynchronous gap ===========================\n'
              'a.dart 10:11  Zip.zap\n'
              'b.dart 10:11  Zop.zoop\n'));
    });

    test('with terse: true, folds core frames as well', () {
      var chain = new Chain([
        new Trace.parse('a.dart 10:11                        Foo.bar\n'
            'dart:async-patch/future.dart 10:11  Zip.zap\n'
            'b.dart 10:11                        Bang.qux\n'
            'dart:core 10:11                     Bar.baz\n'
            'a.dart 10:11                        Zop.zoop'),
        new Trace.parse('a.dart 10:11  Foo.bar\n'
            'a.dart 10:11  Bar.baz\n'
            'a.dart 10:11  Bang.qux\n'
            'a.dart 10:11  Zip.zap\n'
            'b.dart 10:11  Zop.zoop')
      ]);

      var folded =
          chain.foldFrames((frame) => frame.library == 'a.dart', terse: true);
      expect(
          folded.toString(),
          equals('dart:async    Zip.zap\n'
              'b.dart 10:11  Bang.qux\n'
              '===== asynchronous gap ===========================\n'
              'a.dart        Zip.zap\n'
              'b.dart 10:11  Zop.zoop\n'));
    });

    test('eliminates completely-folded traces', () {
      var chain = new Chain([
        new Trace.parse('a.dart 10:11  Foo.bar\n'
            'b.dart 10:11  Bang.qux'),
        new Trace.parse('a.dart 10:11  Foo.bar\n'
            'a.dart 10:11  Bang.qux'),
        new Trace.parse('a.dart 10:11  Zip.zap\n'
            'b.dart 10:11  Zop.zoop')
      ]);

      var folded = chain.foldFrames((frame) => frame.library == 'a.dart');
      expect(
          folded.toString(),
          equals('a.dart 10:11  Foo.bar\n'
              'b.dart 10:11  Bang.qux\n'
              '===== asynchronous gap ===========================\n'
              'a.dart 10:11  Zip.zap\n'
              'b.dart 10:11  Zop.zoop\n'));
    });

    test("doesn't return an empty trace", () {
      var chain = new Chain([
        new Trace.parse('a.dart 10:11  Foo.bar\n'
            'a.dart 10:11  Bang.qux')
      ]);

      var folded = chain.foldFrames((frame) => frame.library == 'a.dart');
      expect(folded.toString(), equals('a.dart 10:11  Bang.qux\n'));
    });
  });

  test('Chain.toTrace eliminates asynchronous gaps', () {
    var trace = new Chain([
      new Trace.parse('user/code.dart 10:11  Foo.bar\n'
          'dart:core 10:11       Bar.baz'),
      new Trace.parse('user/code.dart 10:11  Foo.bar\n'
          'dart:core 10:11       Bar.baz')
    ]).toTrace();

    expect(
        trace.toString(),
        equals('$userSlashCode 10:11  Foo.bar\n'
            'dart:core 10:11       Bar.baz\n'
            '$userSlashCode 10:11  Foo.bar\n'
            'dart:core 10:11       Bar.baz\n'));
  });
}
