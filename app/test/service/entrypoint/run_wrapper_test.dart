// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

void main() {
  group('tool/run-wrapper.sh', () {
    test('forwards SIGTERM to child process and exits 0', () async {
      final process = await Process.start('/bin/sh', [
        '../tool/run-wrapper.sh',
        '/bin/sh',
        '-c',
        'sleep 30 >/dev/null 2>&1 & SLEEP_PID=\$!; '
            'trap "kill \$SLEEP_PID 2>/dev/null || true; echo CHILD_GOT_SIGTERM; exit 0" TERM; '
            'echo CHILD_READY; wait \$SLEEP_PID',
      ]);

      final stdoutLines = process.stdout
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .asBroadcastStream();
      final stderrFuture = process.stderr.transform(utf8.decoder).join();

      final output = <String>[];
      final sub = stdoutLines.listen(output.add);

      await stdoutLines.firstWhere((line) => line == 'CHILD_READY');
      process.kill(ProcessSignal.sigterm);

      final exitCode = await process.exitCode;
      await sub.cancel();
      final stderrText = await stderrFuture;

      expect(exitCode, 0);
      expect(output, contains('CHILD_GOT_SIGTERM'));
      expect(stderrText, contains('[pub-run-wrapper-exited]'));
    });

    test('propagates non-zero exit code on failure', () async {
      final result = await Process.run('/bin/sh', [
        '../tool/run-wrapper.sh',
        '/bin/sh',
        '-c',
        'exit 42',
      ]);

      expect(result.exitCode, 42);
      expect(
        result.stderr.toString(),
        contains('[pub-run-wrapper-failed] exit code 42'),
      );
    });
  });
}
