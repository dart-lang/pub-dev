// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:appengine/appengine.dart';
import 'package:gcloud/service_scope.dart';
import 'package:gcloud/storage.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'package:pub_dartlang_org/appengine_repository.dart';
import 'package:pub_dartlang_org/handlers.dart';
import 'package:pub_dartlang_org/templates.dart';
import 'package:pub_dartlang_org/upload_signer_service.dart';

import 'server_common.dart';

final Credentials = new auth.ServiceAccountCredentials.fromJson(
    new File('/project/key.json').readAsStringSync());

/// The service account email address used for accessing cloud storage.
final String ProductionServiceAccountEmail =
    "818368855108@developer.gserviceaccount.com";

void main() {
  useLoggingPackageAdaptor();

  withAppEngineServices(() async {
    var authClient = await auth.clientViaServiceAccount(Credentials, SCOPES);
    registerScopeExitCallback(authClient.close);
    registerTemplateService(new TemplateService());

    return fork(() async {
      initApiaryStorage(authClient);
      await initSearchService();

      var apiHandler = initPubServer();
      var storageServiceCopy = storageService;

      registerUploadSigner(await uploadSignerServiceViaApiKeyFromDb(
          ProductionServiceAccountEmail));

      await runAppEngine((request) {
        if (context.services.users.currentUser != null) {
          registerLoggedInUser(context.services.users.currentUser.email);
        }

        // Here we fork the current service scope and override
        // storage to be what we setup above.
        return fork(() {
          registerStorageService(storageServiceCopy);

          var namespace = getCurrentNamespace();
          return withChangedNamespaces(() {
            return shelf_io.handleRequest(request, (shelf.Request request) {
              logger.info('Handling request: ${request.requestedUri} '
                          '(Using namespace $namespace)');
              return appHandler(request, apiHandler).catchError((error, stack) {
                logger.severe('Request handler failed', error, stack);
                return new shelf.Response.internalServerError();
              }).whenComplete(() {
                logger.info('Request handler done.');
              });
            });
          }, namespace: namespace);
        }).catchError((error, stack) {
          logger.severe('Request handler failed', error, stack);
        });
      });
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
