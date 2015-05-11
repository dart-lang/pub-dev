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
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart' as shelf;

import 'package:pub_server/shelf_pubserver.dart';

import 'package:pub_dartlang_org/backend.dart';
import 'package:pub_dartlang_org/keys.dart';
import 'package:pub_dartlang_org/oauth2_service.dart';
import 'package:pub_dartlang_org/package_memcache.dart';
import 'package:pub_dartlang_org/search_service.dart';

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

Future initApiaryStorageViaDBKey(String email, String projectId) async {
  String pemFileString = await cloudStorageKeyFromDB();
  var credentials =
      new ServiceAccountCredentials(email, new ClientId('', ''), pemFileString);
  var authClient = await auth.clientViaServiceAccount(credentials, SCOPES);
  registerScopeExitCallback(authClient.close);
  initApiaryStorage(projectId, authClient);
}

void initApiaryStorage(String projectId, authClient) {
  registerStorageService(new Storage(authClient, projectId));
}

void initApiaryDatastore(String projectId, authClient) {
  var ds = new datastore_impl.DatastoreImpl(authClient, 's~${projectId}');
  db.registerDbService(new db.DatastoreDB(ds));
}

Future initSearchService() async {
  var searchService = await searchServiceViaApiKeyFromDb();
  registerSearchService(searchService);
  registerScopeExitCallback(searchService.httpClient.close);
}

void initBackend({UIPackageCache cache}) {
  registerBackend(new Backend(dbService, tarballStorage, cache: cache));
}

shelf.Handler initPubServer({PackageCache cache}) {
  return new ShelfPubServer(backend.repository, cache: cache).requestHandler;
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

/// Changes the namespace for datastore and tarball storage.
Future withChangedNamespaces(func(), String bucketName, {String namespace}) {
  if (namespace == '') namespace = null;

  var db = dbService;
  return fork(() {
    // Construct & register new DatastoreDB.
    var nsPartition = new Partition(namespace);
    var nsDB = new DatastoreDB(
        db.datastore, modelDB: db.modelDB, defaultPartition: nsPartition);
    registerDbService(nsDB);

    // Construct & register a TarballStorage.
    var bucket = storageService.bucket(bucketName);
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
