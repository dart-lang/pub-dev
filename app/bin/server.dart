// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:appengine/appengine.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart';
import 'package:gcloud/storage.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'package:pub_dartlang_org/handlers.dart';
import 'package:pub_dartlang_org/package_memcache.dart';
import 'package:pub_dartlang_org/templates.dart';
import 'package:pub_dartlang_org/upload_signer_service.dart';

import 'server_common.dart';

final Credentials = new auth.ServiceAccountCredentials.fromJson(
    new File('/project/key.json').readAsStringSync());

/// The service account email address used for accessing cloud storage.
final String ProductionServiceAccountEmail =
    "818368855108@developer.gserviceaccount.com";

void main() {
  // Uses the custom `Credentials` instead of getting the keys from the DB.
  bool useDBKeys = false;

  // Using 'gcloud preview app run app.yaml' locally with apiary datastore can
  // be enabled by settings this to `true`.
  bool useApiaryDatastore = false;

  useLoggingPackageAdaptor();

  withAppEngineServices(() async {
    var projectAuthClient =
        await auth.clientViaServiceAccount(Credentials, SCOPES);
    registerScopeExitCallback(projectAuthClient.close);
    registerTemplateService(new TemplateService());

    return fork(() async {
      if (useDBKeys) {
        initApiaryStorageViaDBKey(ProductionServiceAccountEmail);
      } else {
        initApiaryStorage(projectAuthClient);
      }
      if (useApiaryDatastore) {
        initApiaryDatastore(projectAuthClient);
      }
      initOAuth2Service();
      await initSearchService();

      var namespace = getCurrentNamespace();
      return withChangedNamespaces(() async {
        var cache = new AppEnginePackageMemcache(memcacheService, namespace);
        var apiHandler = initPubServer(cache: cache);
        var storageServiceCopy = storageService;
        var dbServiceCopy = dbService;

        if (useDBKeys) {
          registerUploadSigner(await uploadSignerServiceViaApiKeyFromDb(
             ProductionServiceAccountEmail));
        } else {
          registerUploadSigner(new UploadSignerService(
              Credentials.email, Credentials.privateRSAKey));
        }

        await runAppEngine((request) {
          // Here we fork the current service scope and override
          // storage to be what we setup above.
          return fork(() {
            registerStorageService(storageServiceCopy);
            registerDbService(dbServiceCopy);
            return shelf_io.handleRequest(request,
                                          (shelf.Request request) async {
              await registerLoggedInUserIfPossible(request);

              logger.info('Handling request: ${request.requestedUri} '
                          '(Using namespace $namespace)');
              return appHandler(request, apiHandler).catchError((error, s) {
                logger.severe('Request handler failed', error, s);
                return new shelf.Response.internalServerError();
              }).whenComplete(() {
                logger.info('Request handler done.');
              });
            });
          }).catchError((error, stack) {
            logger.severe('Request handler failed', error, stack);
          });
        });
      }, namespace: namespace);
    });
  });
}

/// Gets the current namespace.
String getCurrentNamespace() {
  String version = modulesService.currentVersion;
  if (['preview', 'coming-soon'].contains(version) || isInt(version)) {
    return '';
  }
  return 'staging';
}
