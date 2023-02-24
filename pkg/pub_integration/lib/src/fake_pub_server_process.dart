// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:path/path.dart' as p;

final _random = Random.secure();

/// The timeout factor that should be used in integration tests.
final testTimeoutFactor = 6;

/// Wrapper and helper methods around the fake server process.
class FakePubServerProcess {
  final int port;
  final Process _process;
  final _CoverageConfig? _coverageConfig;
  final _startedCompleter = Completer();
  StreamSubscription? _stdoutListener;
  StreamSubscription? _stderrListener;
  Timer? _startupTimeoutTimer;
  final _linePatterns = <_LinePattern>[];

  FakePubServerProcess._(this.port, this._process, this._coverageConfig);

  static Future<FakePubServerProcess> start({
    String? pkgDir,
    int? port,
  }) async {
    pkgDir ??= p.join(Directory.current.path, '../../app');
    // TODO: check for free port
    port ??= 20000 + _random.nextInt(990);
    final storagePort = port + 1;
    final searchPort = port + 2;
    final analyzerPort = port + 3;
    final dartdocPort = port + 4;
    final vmPort = port + 5;
    final coverageConfig = await _CoverageConfig.detect(vmPort);

    final pr1 =
        await Process.run('dart', ['pub', 'get'], workingDirectory: pkgDir);
    if (pr1.exitCode != 0) {
      throw Exception('dart pub get failed in app');
    }
    final process = await Process.start(
      'dart',
      [
        if (coverageConfig != null) ...[
          '--pause-isolates-on-exit',
          '--enable-vm-service=${coverageConfig.vmPort}',
          '--disable-service-auth-codes',
        ],
        '--enable-asserts',
        'bin/fake_server.dart',
        'run',
        '--port=$port',
        '--storage-port=$storagePort',
        '--search-port=$searchPort',
        '--analyzer-port=$analyzerPort',
        '--dartdoc-port=$dartdocPort',
      ],
      workingDirectory: pkgDir,
      environment: {
        // Because we read the consent email from stdout.
        'DEBUG': Platform.environment['DEBUG'] ?? 'fake_server pub.email',
      },
    );
    final instance = FakePubServerProcess._(port, process, coverageConfig);
    instance._bindListeners();
    return instance;
  }

  void _bindListeners() {
    _stdoutListener = _process.stdout
        .transform(utf8.decoder)
        .transform(LineSplitter())
        .listen(
      (line) {
        print(line);
        if (line.contains('running on port $port')) {
          _startedCompleter.complete();
          _startupTimeoutTimer?.cancel();
          _coverageConfig?.startCollect();
        }
        for (int i = _linePatterns.length - 1; i >= 0; i--) {
          final p = _linePatterns[i];
          if (p.matcher(line)) {
            _linePatterns.removeAt(i);
            p.completer.complete(line);
          }
        }
      },
    );
    _stderrListener = _process.stderr
        .transform(utf8.decoder)
        .transform(LineSplitter())
        .listen((line) {
      print('[ERR] $line');
    });
    _startupTimeoutTimer = Timer(Duration(seconds: 60), () {
      if (!_startedCompleter.isCompleted) {
        _startedCompleter.completeError('Timout starting fake_server');
      }
    });
  }

  Future<void> get started => _startedCompleter.future;

  Future<String> waitForLine(LineMatcher matcher) {
    final p = _LinePattern(matcher);
    _linePatterns.add(p);
    return p.completer.future;
  }

  Future<void> kill() async {
    // First try SIGINT, and after 10 seconds do SIGTERM.
    print('Sending INT signal to ${_process.pid}...');
    _process.kill(ProcessSignal.sigint);
    await _coverageConfig?.waitForCollect();
    final timer = Timer(Duration(seconds: 10), () {
      print('Sending TERM signal to ${_process.pid}...');
      _process.kill();
    });
    final exitCode = await _process.exitCode;
    print('Exit code: $exitCode');
    timer.cancel();
    await _stdoutListener?.cancel();
    await _stderrListener?.cancel();
    _startupTimeoutTimer?.cancel();
    if (exitCode != 0) {
      throw AssertionError('non-graceful termination, exit code: $exitCode');
    }
  }
}

/// Matches the output line.
typedef LineMatcher = bool Function(String line);

class _LinePattern {
  final LineMatcher matcher;
  final completer = Completer<String>();
  _LinePattern(this.matcher);
}

class _CoverageConfig {
  final int vmPort;
  final String outputPath;
  late Process _process;

  _CoverageConfig(this.vmPort, this.outputPath);

  static Future<_CoverageConfig?> detect(int vmPort) async {
    final coverageDir = Platform.environment['COVERAGE_DIR'];
    if (coverageDir == null || coverageDir.isEmpty) return null;

    var sessionName = Platform.environment['COVERAGE_SESSION'];
    if (sessionName == null || sessionName.isEmpty) {
      sessionName = 'pid-$pid';
    }

    final outputPath =
        p.join(coverageDir, 'raw', '$sessionName-fake-pub-server-$vmPort.json');
    return _CoverageConfig(vmPort, outputPath);
  }

  Future<void> startCollect() async {
    await File(outputPath).parent.create(recursive: true);
    print('[collect-$outputPath] starting...');
    _process = await Process.start(
      'dart',
      [
        'pub',
        'run',
        'coverage:collect_coverage',
        '--uri=http://localhost:$vmPort',
        '-o',
        outputPath,
        '--wait-paused',
        '--resume-isolates',
      ],
    );
    _writeLogs(_process.stdout, '[collect-$outputPath][OUT]');
    _writeLogs(_process.stderr, '[collect-$outputPath][ERR]');
    final x = _process.exitCode.then((code) {
      print('[collect-$outputPath] exited with status code $code.');
    });
    x.toString();
  }

  Future<void> waitForCollect() async {
    print('[collect-$outputPath] waiting for completion...');
    await _process.exitCode;
  }
}

void _writeLogs(Stream<List<int>> stream, String prefix) {
  stream.transform(utf8.decoder).transform(LineSplitter()).listen(
    (s) {
      s = s.trim();
      if (s.isNotEmpty) {
        print('  $prefix ${s.trim()}');
      }
    },
    onDone: () {
      print('  $prefix[DONE]');
    },
  );
}
