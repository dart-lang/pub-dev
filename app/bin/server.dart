// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:appengine/appengine.dart';
import 'package:gcloud/service_scope.dart';
import 'package:gcloud/storage.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:path/path.dart' as path;
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'package:pub_server/shelf_pubserver.dart';

import 'package:pub_dartlang_org/backend.dart';
import 'package:pub_dartlang_org/handlers.dart';
import 'package:pub_dartlang_org/keys.dart';
import 'package:pub_dartlang_org/package_memcache.dart';
import 'package:pub_dartlang_org/templates.dart';
import 'package:pub_dartlang_org/upload_signer_service.dart';

import 'configuration.dart';
import 'server_common.dart';

void main() {
  useLoggingPackageAdaptor();

  withAppEngineServices(() async {
    return fork(() async {
      final shelf.Handler apiHandler = await setupServices(activeConfiguration);
      final storageServiceCopy = storageService;

      await runAppEngine((ioRequest) async {
        if (context.isProductionEnvironment &&
            ioRequest.requestedUri.scheme != 'https') {
          final secureUri = ioRequest.requestedUri.replace(scheme: 'https');
          ioRequest.response
              ..redirect(secureUri)
              ..close();
        } else {
          try {
            // Here we fork the current service scope and override
            // storage to be what we setup above (because sometimes we need to
            // use a storage service from another GCE project).
            await fork(() {
              registerStorageService(storageServiceCopy);
              return shelf_io.handleRequest(ioRequest,
                                            (shelf.Request request) async {
                logger.info('Handling request: ${request.requestedUri}');
                await registerLoggedInUserIfPossible(request);
                try {
                  final sanitizedRequest = sanitizeRequestedUri(request);
                  return await appHandler(sanitizedRequest, apiHandler);
                } catch (error, s) {
                  logger.severe('Request handler failed', error, s);
                  return new shelf.Response.internalServerError();
                } finally {
                  logger.info('Request handler done.');
                }
              });
            });
          } catch (error, stack) {
            logger.severe('Request handler failed', error, stack);
          }
        }
      });
    });
  });
}

Future<shelf.Handler> setupServices(Configuration configuration) async {
  final savedStorageService = storageService;

  auth.ServiceAccountCredentials credentials;
  if (configuration.useDbKeys) {
    final pemFileString = await cloudStorageKeyFromDB();
    credentials = new auth.ServiceAccountCredentials(
        configuration.serviceAccountEmail,
        new auth.ClientId('', ''),
        pemFileString);
  } else if (configuration.hasCredentials) {
    credentials = configuration.credentials;
  }
  if (configuration.hasCredentials) {
    final authClient = await auth.clientViaServiceAccount(credentials, SCOPES);
    registerScopeExitCallback(authClient.close);
    initStorage(configuration.projectId, authClient);
  }

  registerTemplateService(
      new TemplateService(templateDirectory: TemplateLocation));


  // We generate a second [TarballStorage] used during the transition phase from
  //    gs://pub.dartlang.org  --->  gs://pub-packages.
  // TODO(kustermann): Remove this, once the transition is over.
  final newBucket = savedStorageService.bucket('pub-packages');
  final newTarballStorage = new TarballStorage(
      savedStorageService, newBucket, null);

  final bucket = storageService.bucket(configuration.packageBucketName);
  final tarballStorage = new TarballStorage(storageService, bucket, null);
  registerTarballStorage(tarballStorage);

  initOAuth2Service();

  await initSearchService();

  final cache = new AppEnginePackageMemcache(memcacheService, '');
  initBackend(newTarballStorage, cache: cache);

  if (configuration.useDbKeys) {
    registerUploadSigner(await uploadSignerServiceViaApiKeyFromDb(
       configuration.serviceAccountEmail));
  } else {
    registerUploadSigner(new UploadSignerService(
        configuration.credentials.email,
        configuration.credentials.privateRSAKey));
  }

  return new ShelfPubServer(backend.repository, cache: cache).requestHandler;
}

shelf.Request sanitizeRequestedUri(shelf.Request request) {
  final uri = request.requestedUri;
  final resource = uri.path;
  final normalizedResource = path.normalize(resource);

  if (resource == normalizedResource) {
    return request;
  } else {
    // With the new flex VMs we can get requests from the load balancer which
    // can contain [Uri]s with e.g. double slashes
    //
    //    -> e.g. https://pub.dartlang.org//api/packages/foo
    //
    // Setting PUB_HOSTED_URL to a URL with a slash at the end can cause this.
    // (The pub client will not remove it and instead directly try to request
    //  "GET //api/..." :-/ )
    final changedUri = uri.replace(path: normalizedResource);
    return new shelf.Request(
        request.method,
        changedUri,
        protocolVersion: request.protocolVersion,
        headers: request.headers,
        body: request.read(),
        encoding: request.encoding,
        context: request.context);
  }
}
