// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:gcloud/datastore.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart';
import 'package:gcloud/src/datastore_impl.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;

import 'configuration.dart';

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
