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
  final String _tmpDir;
  final Process _process;
  final _CoverageConfig? _coverageConfig;
  final _startedCompleter = Completer();
  StreamSubscription? _stdoutListener;
  StreamSubscription? _stderrListener;
  Timer? _startupTimeoutTimer;

  FakePubServerProcess._(
    this.port,
    this._tmpDir,
    this._process,
    this._coverageConfig,
  );

  static Future<FakePubServerProcess> start({
    String? appDir,
    int? port,
  }) async {
    appDir ??= p.join(Directory.current.path, '../../app');
    // TODO: check for free port
    port ??= 20000 + _random.nextInt(990);
    final storagePort = port + 1;
    final searchPort = port + 2;
    final analyzerPort = port + 3;
    final vmPort = port + 5;
    final coverageConfig = await _CoverageConfig.detect(vmPort);

    await _runPubGet(appDir);
    final tmpDir = await Directory.systemTemp.createTemp('fake-pub-server');
    final fakeEmailSenderOutputDir =
        p.join(tmpDir.path, 'fake-email-sender-output-dir');
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
      ],
      workingDirectory: appDir,
      environment: {
        'FAKE_EMAIL_SENDER_OUTPUT_DIR': fakeEmailSenderOutputDir,
      },
    );
    final instance =
        FakePubServerProcess._(port, tmpDir.path, process, coverageConfig);
    instance._bindListeners();
    return instance;
  }

  /// Runs `pub get` in `app`, with a lock file to indicate ongoing pub get.
  static Future<void> _runPubGet(String appDir) async {
    final lockFile = File(p.join(appDir, 'integration-pub-get.lock'));

    if (await lockFile.exists()) {
      final age = DateTime.now().difference(await lockFile.lastModified());
      if (age > Duration(minutes: 1)) {
        // lockfile is present for longer than a minute, assuming stale file
        await lockFile.delete();
      } else {
        // waiting for 15 seconds to get it deleted
        for (var i = 15; i > 0; i++) {
          await Future.delayed(Duration(seconds: 1));
          if (!await lockFile.exists()) break;
        }
        // if it still exists, deleting it
        if (await lockFile.exists()) {
          await lockFile.delete();
        }
      }
    }

    await lockFile.create();
    try {
      final pr1 =
          await Process.run('dart', ['pub', 'get'], workingDirectory: appDir);
      if (pr1.exitCode != 0) {
        throw Exception(
            'dart pub get failed in app\n${pr1.stdout}\n${pr1.stderr}');
      }
    } finally {
      await lockFile.delete();
    }
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
        _startedCompleter.completeError('Timeout starting fake_server');
      }
    });
  }

  Future<void> get started => _startedCompleter.future;

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
    await Directory(_tmpDir).delete(recursive: true);
    if (exitCode != 0) {
      throw AssertionError('non-graceful termination, exit code: $exitCode');
    }
  }

  late final fakeEmailReader = FakeEmailReaderFromOutputDirectory(
      p.join(_tmpDir, 'fake-email-sender-output-dir'));
}

class FakeEmailReaderFromOutputDirectory {
  final String _path;
  FakeEmailReaderFromOutputDirectory(this._path);

  /// Returns a list of all emails sent by this [FakePubServerProcess].
  ///
  /// Each email is a JSON object on the form:
  /// ```js
  /// {
  ///   "localMessageId": "<message-id>", // optional
  ///   "from": "<email>",
  ///   "recipients": ["<email>", ...,
  ///   "subject": "...",
  ///   "bodyText": "..."
  /// }
  /// ```
  Future<List<Map<String, Object?>>> readAllEmails() async {
    final dir = Directory(_path);
    final files = dir.listSync().whereType<File>().toList();
    files.sort((a, b) {
      final x = a.lastModifiedSync().compareTo(b.lastModifiedSync());
      if (x != 0) return x;
      return a.path.compareTo(b.path);
    });
    return files
        .map((e) => e.readAsStringSync())
        .map((s) => json.decode(s) as Map<String, Object?>)
        .toList();
  }

  /// Returns the latest email sent for [recipient].
  ///
  /// An email is a JSON object on the form:
  /// ```js
  /// {
  ///   "localMessageId": "<message-id>", // optional
  ///   "from": "<email>",
  ///   "recipients": ["<email>", ...,
  ///   "subject": "...",
  ///   "bodyText": "..."
  /// }
  /// ```
  Future<Map<String, Object?>> readLatestEmail({
    required String recipient,
  }) async {
    final emails = await readAllEmails();
    return emails.lastWhere((map) {
      final recipients = {
        ...(map['recipients'] as List? ?? <String>[]).cast<String>(),
        ...(map['ccRecipients'] as List? ?? <String>[]).cast<String>(),
      };
      return recipients.contains(recipient);
    });
  }
}

// TODO: find a better place for the utility method
String extractConsentIdFromEmail(String email) {
  final inviteUrlLogLine = email
      .split('\n')
      .firstWhere((line) => line.contains('https://pub.dev/consent'));
  final inviteUri = Uri.parse(inviteUrlLogLine
      .substring(inviteUrlLogLine.indexOf('https://pub.dev/consent')));
  final consentId = inviteUri.queryParameters['id']!;
  return consentId;
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
