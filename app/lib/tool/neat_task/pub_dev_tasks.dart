// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:neat_periodic_task/neat_periodic_task.dart';
import 'package:pub_dev/tool/maintenance/update_public_bucket.dart';

import '../../account/backend.dart';
import '../../account/consent_backend.dart';
import '../../audit/backend.dart';
import '../../dartdoc/backend.dart';
import '../../job/backend.dart';
import '../../package/backend.dart';
import '../../scorecard/backend.dart';
import '../../search/backend.dart';
import '../../shared/datastore.dart';
import '../../shared/integrity.dart';
import '../../tool/backfill/backfill_new_fields.dart';
import '../maintenance/remove_orphaned_likes.dart';
import '../maintenance/update_package_likes.dart';

import 'datastore_status_provider.dart';

final _logger = Logger('pub_dev_tasks');

/// Periodic task that are not tied to a specific service.
void _setupGenericPeriodicTasks() {
  // Backfills the fields that are new to the current release.
  _daily(
    name: 'backfill-new-fields',
    isRuntimeVersioned: true,
    task: backfillNewFields,
  );

  // Deletes expired audit log records.
  _daily(
    name: 'delete-expired-audit-log-records',
    isRuntimeVersioned: false,
    task: () async => await auditBackend.deleteExpiredRecords(),
  );

  // Deletes expired consent invites.
  _daily(
    name: 'delete-expired-consents',
    isRuntimeVersioned: false,
    task: () async => await consentBackend.deleteObsoleteConsents(),
  );

  // Deletes expired sessions.
  _daily(
    name: 'delete-expired-sessions',
    isRuntimeVersioned: false,
    task: () async => await accountBackend.deleteObsoleteSessions(),
  );

  // Updates Package's stable, prerelease and preview version fields in case a
  // new Dart SDK got released.
  _daily(
    name: 'update-package-versions',
    isRuntimeVersioned: false,
    task: () async => await packageBackend.updateAllPackageVersions(),
  );

  // Updates the public archive bucket from the canonical bucket, for the
  // unlikely case where an archive may be missing.
  _daily(
    name: 'update-public-archive-bucket',
    isRuntimeVersioned: false,
    task: updatePublicArchiveBucket,
  );

  // Deletes task status entities where the status hasn't been updated
  // for more than a month.
  _weekly(
    name: 'delete-old-neat-task-statuses',
    isRuntimeVersioned: false,
    task: () => deleteOldNeatTaskStatuses(dbService),
  );

  // Deletes orphaned like entities that are missing a reference.
  _weekly(
    name: 'remove-orphaned-likes',
    isRuntimeVersioned: false,
    task: removeOrphanedLikes,
  );

  // Updates Package.likes with the correct new value.
  _weekly(
    name: 'update-package-likes',
    isRuntimeVersioned: false,
    task: updatePackageLikes,
  );
}

/// Setup the tasks that we are running in the analyzer service.
void setupAnalyzerPeriodicTasks() {
  _setupGenericPeriodicTasks();
  _setupJobCleanupPeriodicTasks();

  // Checks the Datastore integrity of the model objects.
  _weekly(
    name: 'check-datastore-integrity',
    isRuntimeVersioned: true,
    task: () async =>
        await IntegrityChecker(dbService, concurrency: 2).verifyAndLogIssues(),
  );
}

/// Setup the tasks that we are running in the dartdoc service.
void setupDartdocPeriodicTasks() {
  _setupJobCleanupPeriodicTasks();

  // Deletes the extracted dartdoc data from old SDKs.
  _weekly(
    name: 'delete-old-dartdoc-sdks',
    isRuntimeVersioned: true,
    task: () => dartdocBackend.deleteOldData(),
  );

  // Deletes DartdocRun entities and their storage content that are older
  // than the accepted runtime versions.
  _weekly(
    name: 'delete-old-dartdoc-runs',
    isRuntimeVersioned: true,
    task: () async => await dartdocBackend.deleteOldRuns(),
  );

  // Deletes DartdocRun entities and their storage content that are expired,
  // and have newer version with content.
  _weekly(
    name: 'delete-expired-dartdoc-runs',
    isRuntimeVersioned: true,
    task: () async => await dartdocBackend.deleteExpiredRuns(),
  );
}

/// Setup the tasks that we are running in the search service.
void setupSearchPeriodicTasks() {
  // Deletes the old search snapshots
  _weekly(
    name: 'delete-old-search-snapshots',
    isRuntimeVersioned: true,
    task: () => snapshotStorage.deleteOldData(),
  );
}

/// Setup the tasks that we are running in both analyzer and dartdoc services.
void _setupJobCleanupPeriodicTasks() {
  // Deletes Job entities that are older than the accepted runtime versions.
  _weekly(
    name: 'delete-old-jobs',
    isRuntimeVersioned: true,
    task: () async => await jobBackend.deleteOldEntries(),
  );

  // Deletes ScoreCard and ScoreCardReport entities that are older than the
  // accepted runtime versions.
  _weekly(
    name: 'delete-old-scorecards',
    isRuntimeVersioned: true,
    task: () async => await scoreCardBackend.deleteOldEntries(),
  );
}

void _daily({
  required String name,
  required bool isRuntimeVersioned,
  required NeatPeriodicTask task,
}) {
  final scheduler = NeatPeriodicTaskScheduler(
    name: name,
    interval: Duration(hours: 24),
    timeout: Duration(hours: 12),
    status: DatastoreStatusProvider.create(dbService, name,
        isRuntimeVersioned: isRuntimeVersioned),
    task: _wrapMemoryLogging(name, task),
  );

  ss.registerScopeExitCallback(() => scheduler.stop());
  scheduler.start();
}

void _weekly({
  required String name,
  required bool isRuntimeVersioned,
  required NeatPeriodicTask task,
}) {
  final scheduler = NeatPeriodicTaskScheduler(
    name: name,
    interval: Duration(days: 6), // shifts the day when the task is triggered
    timeout: Duration(hours: 12),
    status: DatastoreStatusProvider.create(dbService, name,
        isRuntimeVersioned: isRuntimeVersioned),
    task: _wrapMemoryLogging(name, task),
  );

  ss.registerScopeExitCallback(() => scheduler.stop());
  scheduler.start();
}

NeatPeriodicTask _wrapMemoryLogging(String name, NeatPeriodicTask task) {
  return () async {
    final startMaxRssInKiB = ProcessInfo.maxRss ~/ 1024;
    try {
      await task();
    } finally {
      final endMaxRssInKiB = ProcessInfo.maxRss ~/ 1024;
      final diffMaxRssInKiB = endMaxRssInKiB - startMaxRssInKiB;
      final message =
          'Periodic task $name completed with max memory use $endMaxRssInKiB ($diffMaxRssInKiB)';
      if (diffMaxRssInKiB > 10 * 1024) {
        // Take a notice, when the memory usage increased with more than 10 MB.
        // Let the log message stand out a bit, we should investigate, but no need to alert on it.
        _logger.info('[periodic-task-max-rss-warning] $message');
      } else {
        _logger.info(message);
      }
    }
  };
}
