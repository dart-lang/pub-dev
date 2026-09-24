// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:args/command_runner.dart';

import '../../service/services.dart';
import '../../shared/datastore.dart';
import '../../shared/integrity.dart';

/// Entrypoint command for running standalone batch maintenance tasks
/// (e.g., via Cloud Run Jobs).
final class JobCommand extends Command<void> {
  /// Creates a [JobCommand] with registered maintenance subcommands.
  JobCommand() {
    addSubcommand(_DatastoreIntegrityJobCommand());
    addSubcommand(_TarballIntegrityJobCommand());
  }

  @override
  String get name => 'job';

  @override
  String get description => 'Runs a standalone maintenance job to completion.';
}

final class _DatastoreIntegrityJobCommand extends Command<void> {
  _DatastoreIntegrityJobCommand() {
    argParser.addOption(
      'concurrency',
      defaultsTo: '4',
      help: 'Number of concurrent verification workers.',
    );
  }

  @override
  String get name => 'check-datastore-integrity';

  @override
  String get description =>
      'Checks the Datastore integrity of the model objects.';

  @override
  Future<void> run() async {
    final concurrency = int.tryParse(argResults!['concurrency'] as String);
    if (concurrency == null || concurrency < 1) {
      throw UsageException('Must be a positive integer.', usage);
    }
    await withServices(() async {
      await IntegrityChecker(
        dbService,
        concurrency: concurrency,
      ).verifyAndLogIssues();
    });
  }
}

final class _TarballIntegrityJobCommand extends Command<void> {
  _TarballIntegrityJobCommand() {
    argParser.addOption(
      'concurrency',
      defaultsTo: '4',
      help: 'Number of concurrent verification workers.',
    );
  }

  @override
  String get name => 'check-tarball-integrity';

  @override
  String get description =>
      'Checks the tarball storage integrity of the archive files.';

  @override
  Future<void> run() async {
    final concurrency = int.tryParse(argResults!['concurrency'] as String);
    if (concurrency == null || concurrency < 1) {
      throw UsageException('Must be a positive integer.', usage);
    }
    await withServices(() async {
      await TarballIntegrityChecker(
        dbService,
        concurrency: concurrency,
      ).verifyAndLogIssues();
    });
  }
}
