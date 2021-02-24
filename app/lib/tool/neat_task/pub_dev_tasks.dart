// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/service_scope.dart' as ss;
import 'package:meta/meta.dart';
import 'package:neat_periodic_task/neat_periodic_task.dart';

import '../../account/backend.dart';
import '../../account/consent_backend.dart';
import '../../audit/backend.dart';
import '../../dartdoc/backend.dart';
import '../../job/backend.dart';
import '../../package/backend.dart';
import '../../scorecard/backend.dart';
import '../../search/backend.dart';
import '../../shared/datastore.dart';

import 'datastore_status_provider.dart';

/// Setup the tasks that we are running in pub.dev frontend.
void setupFrontendPeriodicTasks() {
  // Deletes expired audit log records.
  _daily(
    name: 'delete-expired-audit-log-records',
    task: () async => await auditBackend.deleteExpiredRecords(),
  );

  // Deletes expired consent invites.
  _daily(
    name: 'delete-expired-consents',
    task: () async => await consentBackend.deleteObsoleteConsents(),
  );

  // Deletes expired sessions.
  _daily(
    name: 'delete-expired-sessions',
    task: () async => await accountBackend.deleteObsoleteSessions(),
  );

  // Updates Package's stable, prerelease and preview version fields in case a
  // new Dart SDK got released.
  _daily(
    name: 'update-package-versions',
    task: () async => await packageBackend.updateAllPackageVersions(),
  );
}

/// Setup the tasks that we are running in the analyzer service.
void setupAnalyzerPeriodicTasks() {
  _setupJobCleanupPeriodicTasks();
}

/// Setup the tasks that we are running in the dartdoc service.
void setupDartdocPeriodicTasks() {
  _setupJobCleanupPeriodicTasks();

  // Deletes the extracted dartdoc data from old SDKs.
  _weekly(
    name: 'delete-old-dartdoc-sdks',
    task: () => dartdocBackend.deleteOldData(),
  );

  // Deletes DartdocRun entities and their storage content that are older
  // than the accepted runtime versions.
  _weekly(
    name: 'delete-old-dartdoc-runs',
    task: () async => await dartdocBackend.deleteOldRuns(),
  );

  // Deletes DartdocRun entities and their storage content that are expired,
  // and have newer version with content.
  _weekly(
    name: 'delete-expired-dartdoc-runs',
    task: () async => await dartdocBackend.deleteExpiredRuns(),
  );

  // Deletes content from dartdoc storage bucket based on the old entries.
  _daily(
    name: 'gc-dartdoc-storage-bucket',
    task: () async => await dartdocBackend.gcStorageBucket(),
  );
}

/// Setup the tasks that we are running in the search service.
void setupSearchPeriodicTasks() {
  // Deletes the old search snapshots
  _weekly(
    name: 'delete-old-search-snapshots',
    task: () => snapshotStorage.deleteOldData(),
  );
}

/// Setup the tasks that we are running in both analyzer and dartdoc services.
void _setupJobCleanupPeriodicTasks() {
  // Deletes Job entities that are older than the accepted runtime versions.
  _weekly(
    name: 'delete-old-jobs',
    task: () async => await jobBackend.deleteOldEntries(),
  );

  // Deletes ScoreCard and ScoreCardReport entities that are older than the
  // accepted runtime versions.
  _weekly(
    name: 'delete-old-scorecards',
    task: () async => await scoreCardBackend.deleteOldEntries(),
  );
}

void _daily({
  @required String name,
  @required NeatPeriodicTask task,
}) {
  final scheduler = NeatPeriodicTaskScheduler(
    name: name,
    interval: Duration(hours: 24),
    timeout: Duration(hours: 12),
    status: DatastoreStatusProvider.create(dbService, name),
    task: task,
  );

  ss.registerScopeExitCallback(() => scheduler.stop());
  scheduler.start();
}

void _weekly({
  @required String name,
  @required NeatPeriodicTask task,
}) {
  final scheduler = NeatPeriodicTaskScheduler(
    name: name,
    interval: Duration(days: 7),
    timeout: Duration(hours: 12),
    status: DatastoreStatusProvider.create(dbService, name),
    task: task,
  );

  ss.registerScopeExitCallback(() => scheduler.stop());
  scheduler.start();
}
