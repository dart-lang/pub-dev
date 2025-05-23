// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:isolate' show Isolate;

import 'package:logging/logging.dart';
import 'package:pub_dev/database/model.dart';

DatabaseAdapter createFakeDatabaseAdaptor() {
  return DatabaseAdapter.withLogging(
      DatabaseAdapter.fromFuture(_createFakeDatabaseAdaptor()),
      Logger('sql').info);
}

Future<DatabaseAdapter> _createFakeDatabaseAdaptor() async {
  final isCI = !['false', '0', ''].contains(
    Platform.environment['CI']?.toLowerCase() ?? '',
  );
  if (isCI) {
    // ignore: invalid_use_of_visible_for_testing_member
    return DatabaseAdapter.postgresTestDatabase();
  }

  final lib = Isolate.resolvePackageUriSync(Uri.parse('package:pub_dev/'));
  if (lib == null) {
    throw StateError('Cannot resolve package:pub_dev/ to find .dart_tool/');
  }

  await Directory('/tmp/pub_dev_postgres/run/').create(recursive: true);
  final socketPath = '/tmp/pub_dev_postgres/run/.s.PGSQL.5432';
  final lockFile = File('/tmp/pub_dev_postgres/.lock');
  if (!await _tryConnect(socketPath)) {
    final lock = await lockFile.open(mode: FileMode.append);
    try {
      await lock.lock(FileLock.blockingExclusive);

      if (!await _tryConnect(socketPath)) {
        // Start tool launching the postgres docker instance in a detatched
        // background process that can keep running.
        final tool = lib.resolve('../../tool/run_postgres_test_server.sh');
        await Process.start(
          tool.toFilePath(),
          ['--quiet'],
          workingDirectory: lib.resolve('../../').toFilePath(),
          mode: ProcessStartMode.detached,
        );

        do {
          await Future.delayed(Duration(milliseconds: 300));
        } while (!await _tryConnect(socketPath));
      }
    } finally {
      try {
        await lock.unlock();
      } finally {
        await lock.close();
      }
    }
  }

  // ignore: invalid_use_of_visible_for_testing_member
  return DatabaseAdapter.postgresTestDatabase(
    host: socketPath,
    database: 'postgres',
    user: 'postgres',
    password: 'postgres',
  );
}

Future<bool> _tryConnect(String socketPath) async {
  try {
    final s = await Socket.connect(
      InternetAddress(socketPath, type: InternetAddressType.unix),
      5432,
    );
    s.destroy();
    return true;
  } on SocketException {
    return false;
  }
}
