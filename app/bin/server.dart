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
import 'package:logging/logging.dart';
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

Logger logger = new Logger('pub');

void setupAppEngineLogging() {
  Map<Level, LogLevel> loggingLevel2appengineLevel = <Level, LogLevel>{
    Level.OFF: LogLevel.DEBUG,
    Level.ALL: LogLevel.DEBUG,
    Level.FINEST: LogLevel.DEBUG,
    Level.FINER: LogLevel.DEBUG,
    Level.FINE: LogLevel.DEBUG,
    Level.CONFIG: LogLevel.INFO,
    Level.INFO: LogLevel.INFO,
    Level.WARNING: LogLevel.WARNING,
    Level.SEVERE: LogLevel.ERROR,
    Level.SHOUT: LogLevel.CRITICAL,
  };
  Logger.root.onRecord.listen((LogRecord record) {
    record.zone.run(() {
      var logging = loggingService;
      if (logging != null) {
        var level = loggingLevel2appengineLevel[record.level];
        var message = '${record.loggerName}: ${record.message}';

        addBlock(String header, String body) {
          body = body.replaceAll('\n', '\n    ');
          message = '$message\n\n$header:\n    $body';
        }

        if (record.error != null) addBlock('Error', '${record.error}');
        if (record.stackTrace != null) {
          addBlock('Stack', '${record.stackTrace}');
        }

        logging.log(level, message, timestamp: record.time);
      } else {
        print('${record.time} ${record.level} ${record.loggerName}: '
              '${record.message}');
      }
    });
  });
}

shelf.Request fixRequest(shelf.Request R) {
  var https = R.headers['x-appengine-https'];
  if (https != null) {
    var scheme = R.requestedUri.scheme;
    if (https == 'on') {
      scheme = 'https';
    } else {
      scheme = 'http';
    }
    var requestedUri = R.requestedUri.replace(scheme: scheme);
    R = new shelf.Request(
        R.method, requestedUri, protocolVersion: R.protocolVersion,
        headers: R.headers, body: R.read(),
        context: R.context);
  }
  return R;
}

void main() {
  bool localDevelopment = false;

  setupAppEngineLogging();

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
        logger.info('Handling request: ${request.uri}');

        // Here we fork the current service scope and override
        // datastore/storage to be what we setup above.
        return fork(() {
          db.registerDbService(dbServiceCopy);
          registerStorageService(storageServiceCopy);
          return shelf_io.handleRequest(request, (shelf.Request request) {
            request = fixRequest(request);
            logger.info('Handling request: ${request.requestedUri}');
            return appHandler(request, apiHandler).catchError((error, stack) {
              logger.severe('Request handler failed', error, stack);
              return new shelf.Response.internalServerError();
            }).whenComplete(() {
              logger.info('Request handler done.');
            });
          });
        }).catchError((error, stack) {
          logger.severe('Request handler failed', error, stack);
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
