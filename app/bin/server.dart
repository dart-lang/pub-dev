// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:async';

import 'package:appengine/appengine.dart';
import 'package:gcloud/db.dart' as db;
import 'package:gcloud/service_scope.dart';
import 'package:gcloud/storage.dart';
import 'package:gcloud/db.dart' show dbService;
import 'package:gcloud/src/datastore_impl.dart' as datastore_impl;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:pubserver/shelf_pubserver.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'package:pub_dartlang_org/appengine_repository.dart';
import 'package:pub_dartlang_org/handlers.dart';
import 'package:pub_dartlang_org/search_service.dart';

final String ProjectId = 'mkustermann-dartvm';

final Credentials = new auth.ServiceAccountCredentials.fromJson(
    new File('/project/key.json').readAsStringSync());

const List<String> SCOPES = const [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/datastore",
    "https://www.googleapis.com/auth/devstorage.full_control",
    "https://www.googleapis.com/auth/userinfo.email",
];

void main() {
  bool localDevelopment = false;

  withAppEngineServices(() async {
    var authClient = await auth.clientViaServiceAccount(Credentials, SCOPES);
    registerScopeExitCallback(authClient.close);

    return fork(() async {
      initApiaryStorage(authClient);
      if (localDevelopment) initApiaryDatastore(authClient);
      await initSearchService();

      var apiHandler = initPubServer();
      var dbServiceCopy = dbService;
      var storageServiceCopy = storageService;

      await runAppEngine((request) {
        // Here we fork the current service scope and override
        // datastore/storage to be what we setup above.
        return fork(() {
          db.registerDbService(dbServiceCopy);
          registerStorageService(storageServiceCopy);
          return shelf_io.handleRequest(request,
                                        (r) => appHandler(r, apiHandler));
        });
      });
    });
  });
}

void initApiaryStorage(authClient) {
  var ds = new datastore_impl.DatastoreImpl(authClient, 's~$ProjectId');
  registerStorageService(new Storage(authClient, ProjectId));
}

void initApiaryDatastore(authClient) {
  var ds = new datastore_impl.DatastoreImpl(authClient, 's~$ProjectId');
  db.registerDbService(new db.DatastoreDB(ds));
  registerScopeExitCallback(() => authClient.close());
}

Future initSearchService() async {
  var searchService = await searchServiceViaApiKeyFromDb();
  registerSearchService(searchService);
  registerScopeExitCallback(searchService.httpClient.close);
}

shelf.Handler initPubServer() {
  var appengineRepo = new AppEnginePackageRepo(
      dbService, storageService, 'pub.dartlang.org');
  return new ShelfPubServer(appengineRepo).requestHandler;
}
