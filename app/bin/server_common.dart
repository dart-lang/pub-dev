// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.server_common;

import 'dart:async';

import 'package:gcloud/db.dart' as db;
import 'package:gcloud/service_scope.dart';
import 'package:gcloud/storage.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/src/datastore_impl.dart' as datastore_impl;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart' as shelf;

import 'package:pub_server/shelf_pubserver.dart';

import 'package:pub_dartlang_org/appengine_repository.dart';
import 'package:pub_dartlang_org/oauth2_service.dart';
import 'package:pub_dartlang_org/search_service.dart';

final String ProjectId = 'mkustermann-dartvm';
final String PackageBucket = 'mkustermann--pub-packages';

const List<String> SCOPES = const [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/datastore",
    "https://www.googleapis.com/auth/devstorage.full_control",
    "https://www.googleapis.com/auth/userinfo.email",
];

final Logger logger = new Logger('pub');

void initOAuth2Service() {
  // The oauth2 service is used for getting an email address from an oauth2
  // access token (which the pub client sends).
  var client = new http.Client();
  registerOAuth2Service(new OAuth2Service(client));
  registerScopeExitCallback(client.close);
}

void initApiaryStorage(authClient) {
  registerStorageService(new Storage(authClient, ProjectId));
}

void initApiaryDatastore(authClient) {
  var ds = new datastore_impl.DatastoreImpl(authClient, 's~$ProjectId');
  db.registerDbService(new db.DatastoreDB(ds));
}

Future initSearchService() async {
  var searchService = await searchServiceViaApiKeyFromDb();
  registerSearchService(searchService);
  registerScopeExitCallback(searchService.httpClient.close);
}

shelf.Handler initPubServer() {
  var appengineRepo = new GCloudPackageRepo();
  return new ShelfPubServer(appengineRepo).requestHandler;
}

/// Looks at [request] and if the 'Authorization' header was set tries to get
/// the user email address and registers it.
registerLoggedInUserIfPossible(shelf.Request request) async {
  var authorization = request.headers['authorization'];
  if (authorization != null) {
    var parts = authorization.split(' ');
    if (parts.length == 2 &&
        parts.first.trim().toLowerCase() == 'bearer') {
      var accessToken = parts.last.trim();

      var email = await oauth2Service.lookup(accessToken);
      if (email != null) {
        registerLoggedInUser(email);
      }
    }
  }
}

/// Changes the namespace for datastore and memcache.
Future withChangedNamespaces(func(), {String namespace}) {
  if (namespace == '') namespace = null;

  var db = dbService;
  return fork(() {
    // Construct & register new DatastoreDB.
    var nsPartition = new Partition(namespace);
    var nsDB = new DatastoreDB(
        db.datastore, modelDB: db.modelDB, defaultPartition: nsPartition);
    registerDbService(nsDB);

    // Construct & register a TarballStorage.
    var bucket = storageService.bucket(PackageBucket);
    var tarballStorage = new TarballStorage(storageService, bucket, namespace);
    registerTarballStorage(tarballStorage);

    return func();
  });
}

bool isInt(String s) {
  try {
    int.parse(s);
    return true;
  } on FormatException catch (_, __) {
    return false;
  }
}
