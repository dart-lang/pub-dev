// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/service_scope.dart' as ss;
import 'package:neat_periodic_task/neat_periodic_task.dart';

import '../../package/backend.dart';
import '../../shared/datastore.dart';

import 'datastore_status_provider.dart';

/// Setup the tasks that we are running in pub-dev.
void setupPubDevPeriodicTasks() {
  _setup(NeatPeriodicTaskScheduler(
    name: 'update-package-versions',
    interval: Duration(hours: 24),
    timeout: Duration(hours: 12),
    status:
        DatastoreStatusProvider.create(dbService, 'update-package-versions'),
    task: () async => packageBackend.updateAllPackageVersions(),
  ));
}

void _setup(NeatPeriodicTaskScheduler scheduler) {
  ss.registerScopeExitCallback(() => scheduler.stop());
  scheduler.start();
}
