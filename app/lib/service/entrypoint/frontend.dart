// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:gcloud/db.dart' as db;
import 'package:gcloud/service_scope.dart';
import 'package:gcloud/storage.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../../account/consent_backend.dart';
import '../../frontend/backend.dart';
import '../../frontend/cronjobs.dart' show CronJobs;
import '../../frontend/handlers.dart';
import '../../frontend/name_tracker.dart';
import '../../frontend/static_files.dart';
import '../../frontend/upload_signer_service.dart';
import '../../shared/analyzer_client.dart';
import '../../shared/configuration.dart';
import '../../shared/dartdoc_client.dart';
import '../../shared/deps_graph.dart';
import '../../shared/handler_helpers.dart';
import '../../shared/popularity_storage.dart';
import '../../shared/storage.dart';

import '../isolate.dart';
import '../services.dart';

final Logger _logger = Logger('pub');
final _random = Random.secure();

Future main() async {
  await startIsolates(
    logger: _logger,
    frontendEntryPoint: _main,
    workerEntryPoint: _worker,
  );
}

Future _main(FrontendEntryMessage message) async {
  setupServiceIsolate();
  message.protocolSendPort
      .send(FrontendProtocolMessage(statsConsumerPort: null));

  await updateLocalBuiltFiles();
  await withServices(() async {
    final shelf.Handler apiHandler = await setupServices(activeConfiguration);

    // Add randomization to reduce race conditions.
    // TODO: use package:neat_periodic_task
    Timer.periodic(Duration(hours: 8, minutes: _random.nextInt(240)),
        (_) async {
      await backend.deleteObsoleteInvites();
      await consentBackend.deleteObsoleteConsents();
    });

    final cron = CronJobs(await getOrCreateBucket(
      storageService,
      activeConfiguration.backupSnapshotBucketName,
    ));
    final appHandler = createAppHandler(apiHandler);
    await runHandler(_logger, appHandler,
        sanitize: true, cronHandler: cron.handler);
  });
}

Future<shelf.Handler> setupServices(Configuration configuration) async {
  await popularityStorage.init();
  nameTracker.startTracking();

  UploadSignerService uploadSigner;
  if (envConfig.hasCredentials) {
    final credentials = configuration.credentials;
    uploadSigner = ServiceAccountBasedUploadSigner(credentials);
  } else {
    final authClient = await auth.clientViaMetadataServer();
    registerScopeExitCallback(() async => authClient.close());
    final email = await obtainServiceAccountEmail();
    uploadSigner =
        IamBasedUploadSigner(configuration.projectId, email, authClient);
  }
  registerUploadSigner(uploadSigner);

  return backend.pubServer.requestHandler;
}

Future _worker(WorkerEntryMessage message) async {
  setupServiceIsolate();
  message.protocolSendPort.send(WorkerProtocolMessage());

  await withServices(() async {
    // Updates job entries for analyzer and dartdoc.
    Future triggerDependentAnalysis(
        String package, String version, Set<String> affected) async {
      await analyzerClient.triggerAnalysis(package, version, affected);
      await dartdocClient.triggerDartdoc(package, version, affected);
    }

    final pdb = await PackageDependencyBuilder.loadInitialGraphFromDb(
        db.dbService, triggerDependentAnalysis);
    await pdb.monitorInBackground(); // never returns
  });
}

Future<String> obtainServiceAccountEmail() async {
  final http.Response response = await http.get(
      'http://metadata/computeMetadata/'
          'v1/instance/service-accounts/default/email',
      headers: const {'Metadata-Flavor': 'Google'});
  return response.body.trim();
}
