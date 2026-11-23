// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:logging/logging.dart';
import 'package:pub_dev/service/entrypoint/logging.dart';
import 'package:stack_trace/stack_trace.dart';
import 'package:test/test.dart';

void main() {
  group('formatCloudLogEntry', () {
    test('returns null for Level.OFF', () {
      final record = LogRecord(Level.OFF, 'ignored', 'pub');
      expect(formatCloudLogEntry(record), isNull);
    });

    test('includes V8 stack_trace for SEVERE logs with error and stackTrace', () {
      final trace = Trace.parse('''
package:pub_dev/shared/storage.dart 184:11                  BucketExt.readAsBytes.<fn>
package:retry/retry.dart 131:16                             RetryOptions.retry
dart:async                                                  _CustomZone.runUnary
package:pub_semver/src/version_constraint.dart 45:7         new VersionConstraint.parse
package:pub_dev/shared/foo.dart 12:3                        new Foo
''');
      final record = LogRecord(
        Level.SEVERE,
        'Request handler failed',
        'pub',
        TimeoutException('Reading blob timed out.', Duration(seconds: 30)),
        trace,
      );

      final entry = formatCloudLogEntry(
        record,
        traceId: 'abc123',
        projectId: 'dartlang-pub',
      )!;

      expect(entry['severity'], 'ERROR');
      expect(
        entry['message'],
        contains('package:pub_dev/shared/storage.dart 184:11'),
      );
      expect(
        entry['logging.googleapis.com/trace'],
        'projects/dartlang-pub/traces/abc123',
      );
      expect(entry['logging.googleapis.com/labels'], {'logger': 'pub'});
      expect(
        entry['stack_trace'],
        'Error: TimeoutException after 0:00:30.000000: Reading blob timed out.\n'
        '    at BucketExt.readAsBytes.<anonymous> (package:pub_dev/shared/storage.dart:184:11)\n'
        '    at RetryOptions.retry (package:retry/retry.dart:131:16)\n'
        '    at _CustomZone.runUnary (native)\n'
        '    at VersionConstraint.parse (package:pub_semver/src/version_constraint.dart:45:7)\n'
        '    at Foo.new (package:pub_dev/shared/foo.dart:12:3)\n',
      );
    });

    test('includes V8 stack_trace for SHOUT logs', () {
      final trace = StackTrace.fromString('''
#0      _ChunkedJsonParser.fail (dart:convert-patch/convert_patch.dart:1463:5)
#1      MyService.handleRequest.<anonymous closure> (package:pub_dev/service.dart:42:13)
''');
      final record = LogRecord(
        Level.SHOUT,
        'Uncaught failure',
        'pub.service',
        FormatException('Bad input'),
        trace,
      );

      final entry = formatCloudLogEntry(record)!;
      expect(entry['severity'], 'CRITICAL');
      expect(
        entry['stack_trace'],
        'Error: FormatException: Bad input\n'
        '    at _ChunkedJsonParser.fail (native)\n'
        '    at MyService.handleRequest.<anonymous> (package:pub_dev/service.dart:42:13)\n',
      );
    });

    test('flattens Chain stack traces across async gaps', () {
      final chain = Chain([
        Trace.parse(
          'package:pub_dev/task/backend.dart 824:14  TaskBackend._readFromBucket\n',
        ),
        Trace.parse(
          'package:pub_dev/task/handlers.dart 160:22  handleDartDoc.<fn>\n',
        ),
      ]);
      final record = LogRecord(
        Level.SEVERE,
        'Task failed',
        'pub.task',
        StateError('broken'),
        chain,
      );

      final entry = formatCloudLogEntry(record)!;
      expect(
        entry['stack_trace'],
        'Error: Bad state: broken\n'
        '    at TaskBackend._readFromBucket (package:pub_dev/task/backend.dart:824:14)\n'
        '    at handleDartDoc.<anonymous> (package:pub_dev/task/handlers.dart:160:22)\n',
      );
    });

    test('uses fallback message when error is null but stackTrace is set', () {
      final trace = Trace.parse(
        'package:pub_dev/shared/handler_helpers.dart 203:9  _logRequestWrapper\n',
      );
      final record = LogRecord(
        Level.SEVERE,
        'Unexpected state',
        'pub',
        null,
        trace,
      );

      final entry = formatCloudLogEntry(record)!;
      expect(
        entry['stack_trace'],
        'Error: pub: Unexpected state\n'
        '    at _logRequestWrapper (package:pub_dev/shared/handler_helpers.dart:203:9)\n',
      );
    });

    test('omits stack_trace for WARNING and below', () {
      final trace = Trace.parse(
        'package:pub_dev/shared/storage.dart 184:11  BucketExt.readAsBytes\n',
      );
      final record = LogRecord(
        Level.WARNING,
        'Transient issue',
        'pub',
        StateError('transient'),
        trace,
      );

      final entry = formatCloudLogEntry(record)!;
      expect(entry['severity'], 'WARNING');
      expect(entry.containsKey('stack_trace'), isFalse);
    });

    test('omits stack_trace when stackTrace is null or empty', () {
      final noStack = LogRecord(
        Level.SHOUT,
        'Markdown rendering taking too long: 0:00:03.836118',
        'pub.markdown',
      );
      expect(formatCloudLogEntry(noStack)!.containsKey('stack_trace'), isFalse);

      final emptyStack = LogRecord(
        Level.SEVERE,
        'Failed',
        'pub',
        StateError('empty'),
        StackTrace.empty,
      );
      expect(
        formatCloudLogEntry(emptyStack)!.containsKey('stack_trace'),
        isFalse,
      );
    });

    test('collapses multiline errors and skips unparsed frames', () {
      final trace = StackTrace.fromString('''
#0      first (package:pub_dev/a.dart:10:5)
not a parseable frame
#1      Foo.[] (package:pub_dev/b.dart:20:7)
''');
      final formatted = formatV8StackTrace(
        'Failed request\nhttps://storage.googleapis.com/foo: 504\n    at fake (x:1:1)',
        trace,
      );

      expect(
        formatted,
        'Error: Failed request https://storage.googleapis.com/foo: 504 at fake (x:1:1)\n'
        '    at first (package:pub_dev/a.dart:10:5)\n'
        '    at Foo._ (package:pub_dev/b.dart:20:7)\n',
      );
    });

    test('returns null when stackTrace has only unparsed frames', () {
      expect(
        formatV8StackTrace(
          StateError('broken'),
          Trace([UnparsedFrame('not a frame')]),
        ),
        isNull,
      );
    });

    test('truncates oversized stack traces on frame boundaries', () {
      final frames = List.generate(
        500,
        (i) =>
            'package:pub_dev/some/long/path/module_$i.dart ${i + 1}:10  SomeLongClassName.method$i',
      ).join('\n');
      final formatted = formatV8StackTrace(
        StateError('deep recursion'),
        Trace.parse(frames),
      )!;

      expect(formatted.length, lessThanOrEqualTo(32 * 1024));
      expect(formatted, endsWith('\n'));
      expect(
        formatted,
        contains(
          '    at SomeLongClassName.method0 (package:pub_dev/some/long/path/module_0.dart:1:10)\n',
        ),
      );
    });
  });
}
