// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:appengine/appengine.dart';
import 'package:gcloud/datastore.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart';
import 'package:gcloud/src/datastore_impl.dart';
import 'package:gcloud/storage.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:path/path.dart' as path;
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'package:pub_server/shelf_pubserver.dart';

import 'package:pub_dartlang_org/backend.dart';
import 'package:pub_dartlang_org/handlers.dart';
import 'package:pub_dartlang_org/package_memcache.dart';
import 'package:pub_dartlang_org/templates.dart';
import 'package:pub_dartlang_org/upload_signer_service.dart';

import 'configuration.dart';
import 'server_common.dart';

void main() {
  useLoggingPackageAdaptor();

  withAppEngineServices(() async {
    return fork(() async {
      DatastoreDB savedDb;
      if (Platform.isMacOS) {
        savedDb = await _initializeApiaryDatastore();
      }
      final shelf.Handler apiHandler = await setupServices(activeConfiguration);

      AppEngineRequestHandler requestHandler = (ioRequest) async {
        if (context.isProductionEnvironment &&
            ioRequest.requestedUri.scheme != 'https') {
          final secureUri = ioRequest.requestedUri.replace(scheme: 'https');
          ioRequest.response
            ..redirect(secureUri)
            ..close();
        } else {
          try {
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
          } catch (error, stack) {
            logger.severe('Request handler failed', error, stack);
          }
        }
      };
      if (Platform.isMacOS) {
        final AppEngineRequestHandler origHandler = requestHandler;
        requestHandler = (ioRequest) {
          fork(() {
            registerDbService(savedDb);
            origHandler(ioRequest);
          });
        };
      }
      await runAppEngine(requestHandler);
    });
  });
}

Future<shelf.Handler> setupServices(Configuration configuration) async {
  registerTemplateService(
      new TemplateService(templateDirectory: TemplateLocation));

  final bucket = storageService.bucket(configuration.packageBucketName);
  final tarballStorage = new TarballStorage(storageService, bucket, null);
  registerTarballStorage(tarballStorage);

  initOAuth2Service();

  await initSearchService();

  final cache = new AppEnginePackageMemcache(memcacheService, '');
  initBackend(cache: cache);

  UploadSignerService uploadSigner;
  if (configuration.hasCredentials) {
    final credentials = configuration.credentials;
    uploadSigner = new ServiceAccountBasedUploadSigner(credentials);
  } else {
    final authClient = await auth.clientViaMetadataServer();
    registerScopeExitCallback(authClient.close);
    final email = await obtainServiceAccountEmail();
    uploadSigner =
        new IamBasedUploadSigner(configuration.projectId, email, authClient);
  }
  registerUploadSigner(uploadSigner);

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
    return new shelf.Request(request.method, changedUri,
        protocolVersion: request.protocolVersion,
        headers: request.headers,
        body: request.read(),
        encoding: request.encoding,
        context: request.context);
  }
}

Future<DatastoreDB> _initializeApiaryDatastore() async {
  final projectId = Platform.environment['GCLOUD_PROJECT'];
  final gcloudKeyVar = Platform.environment['GCLOUD_KEY'];
  final serviceAccount = new auth.ServiceAccountCredentials.fromJson(
      new File(gcloudKeyVar).readAsStringSync());

  final authClient =
      await auth.clientViaServiceAccount(serviceAccount, DatastoreImpl.SCOPES);
  registerScopeExitCallback(authClient.close);

  final datastore = new DatastoreImpl(authClient, projectId);
  registerDatastoreService(datastore);

  final db = new DatastoreDB(datastore);
  registerDbService(db);

  return db;
}
