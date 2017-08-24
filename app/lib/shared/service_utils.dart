// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'dart:isolate';
import 'package:gcloud/datastore.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart';
import 'package:gcloud/src/datastore_impl.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:logging/logging.dart';

import 'configuration.dart';
import 'handlers.dart';
import 'task_client.dart';

/// Wrapper function used to work around issue with running gRPC Datastore on
/// MacOS.
///
/// On
///    * Linux this function simply returns `fun()`
///
///    * MacOS this function makes a new service scope, optionally builds an
///      apiary Datastore and registers an apiary Datastore in the new service
///      scope
///
Future withCorrectDatastore(Future fun()) {
  if (Platform.isMacOS) {
    return fork(() async {
      DatastoreDB apiaryDatastore = lookup(_apiaryDatastoreSymbol);
      if (apiaryDatastore == null) {
        apiaryDatastore = await _initializeApiaryDatastore();
        register(_apiaryDatastoreSymbol, apiaryDatastore);
      }
      registerDbService(apiaryDatastore);
      return fun();
    });
  } else {
    assert(dbService != null);
    return fun();
  }
}

Symbol _apiaryDatastoreSymbol = #_apiaryDatastoreSymbol;

Future<DatastoreDB> _initializeApiaryDatastore() async {
  final projectId = envConfig.gcloudProject;
  final gcloudKeyVar = envConfig.gcloudKey;
  final serviceAccount = new auth.ServiceAccountCredentials.fromJson(
      new File(gcloudKeyVar).readAsStringSync());

  final authClient =
      await auth.clientViaServiceAccount(serviceAccount, DatastoreImpl.SCOPES);
  registerScopeExitCallback(authClient.close);

  final datastore = new DatastoreImpl(authClient, projectId);
  registerDatastoreService(datastore);

  return new DatastoreDB(datastore);
}

Future startIsolates(
    Logger logger, void entryPoint(List<SendPort> ports)) async {
  final ReceivePort errorReceivePort = new ReceivePort();

  Future startIsolate() async {
    logger.info('About to start isolate...');
    final ReceivePort mainReceivePort = new ReceivePort();
    final ReceivePort statsReceivePort = new ReceivePort();
    await Isolate.spawn(
      entryPoint,
      [mainReceivePort.sendPort, statsReceivePort.sendPort],
      onError: errorReceivePort.sendPort,
      onExit: errorReceivePort.sendPort,
      errorsAreFatal: true,
    );
    final List<SendPort> sendPorts = await mainReceivePort.take(1).toList();
    registerTaskSendPort(sendPorts[0]);
    registerSchedulerStatsStream(statsReceivePort as Stream<Map>);
    logger.info('Isolate started.');
  }

  errorReceivePort.listen((e) async {
    logger.severe('ERROR from isolate', e);
    // restart isolate after a brief pause
    await new Future.delayed(new Duration(minutes: 1));
    logger.warning('Restarting isolate...');
    await startIsolate();
  });

  for (int i = 0; i < envConfig.isolateCount; i++) {
    await startIsolate();
  }
}
