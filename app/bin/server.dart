// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

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

import 'configuration.dart';
import 'server_common.dart';

// Run with production configuration.
var configuration = new Configuration.prod();

// Uncomment and use a .dev configuration for local testing using
// 'gcloud preview app run'.
//var configuration = new Configuration.dev('mkustermann-dartvm',
//                                          'mkustermann--pub-packages');

void main() {
  useLoggingPackageAdaptor();

  withAppEngineServices(() async {
    var projectAuthClient;
    if (configuration.hasCredentials) {
      projectAuthClient =
          await auth.clientViaServiceAccount(configuration.credentials, SCOPES);
      registerScopeExitCallback(projectAuthClient.close);
    }
    registerTemplateService(new TemplateService());

    return fork(() async {
      if (configuration.useDbKeys) {
        initApiaryStorageViaDBKey(configuration.serviceAccountEmail,
                                  configuration.projectId);
      } else {
        initApiaryStorage(configuration.projectId, projectAuthClient);
      }
      if (configuration.useApiaryDatastore) {
        initApiaryDatastore(configuration.projectId, projectAuthClient);
      }
      initOAuth2Service();
      await initSearchService();

      var namespace = getCurrentNamespace();
      return withChangedNamespaces(() async {
        initBackend();

        var cache = new AppEnginePackageMemcache(memcacheService, namespace);
        var apiHandler = initPubServer(cache: cache);
        var storageServiceCopy = storageService;
        var dbServiceCopy = dbService;

        if (configuration.useDbKeys) {
          registerUploadSigner(await uploadSignerServiceViaApiKeyFromDb(
             configuration.serviceAccountEmail));
        } else {
          registerUploadSigner(new UploadSignerService(
              configuration.credentials.email,
              configuration.credentials.privateRSAKey));
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
                          '(Using namespace "$namespace")');
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
      }, configuration.packageBucketName, namespace: namespace);
    });
  });
}

/// Gets the current namespace.
String getCurrentNamespace() {
  String version = modulesService.currentVersion;
  if (['preview', 'coming-soon'].contains(version) ||
      version.startsWith('buildbot-dart') ||
      isInt(version)) {
    return '';
  }
  return 'staging';
}
