// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/service_scope.dart' as ss;
import 'package:meta/meta.dart';
import 'package:neat_periodic_task/neat_periodic_task.dart';

import '../../account/backend.dart';
import '../../account/consent_backend.dart';
import '../../audit/backend.dart';
import '../../package/backend.dart';
import '../../shared/datastore.dart';

import 'datastore_status_provider.dart';

/// Setup the tasks that we are running in pub-dev.
void setupPubDevPeriodicTasks() {
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
