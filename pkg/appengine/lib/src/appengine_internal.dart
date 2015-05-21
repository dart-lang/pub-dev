// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library appengine.internal;

import 'dart:async';
import 'dart:io';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:gcloud/storage.dart' as storage;
import 'package:gcloud/db.dart' as db;
import 'package:gcloud/datastore.dart' as datastore;
import 'package:gcloud/http.dart' as gcloud_http;
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

import '../api/logging.dart' as logging;
import '../api/modules.dart' as modules;
import '../api/memcache.dart' as memcache;
import '../api/users.dart' as users;

import 'protobuf_api/rpc/rpc_service.dart';
import 'protobuf_api/rpc/rpc_service_remote_api.dart';

import 'appengine_context.dart';
import 'client_context.dart';
import 'server/server.dart';
import 'server/context_registry.dart';
import 'server/logging_package_adaptor.dart';

bool _loggingPackageEnabled = false;

Future<ContextRegistry> initializeAppEngine() {
  RPCService initializeRPC() {
    var apiHostString = Platform.environment['API_HOST'];
    var apiPortString = Platform.environment['API_PORT'];

    if (apiHostString == null) apiHostString = 'appengine.googleapis.com';
    var apiPort = apiPortString != null ? int.parse(apiPortString) : 10001;

    return new RPCServiceRemoteApi(apiHostString, apiPort);
  }

  AppengineContext getDockerContext() {
    var env = Platform.environment;

    String applicationID = env['GAE_LONG_APP_ID'];
    String module = env['GAE_MODULE_NAME'];
    String version = env['GAE_MODULE_VERSION'];
    String instance = env['GAE_MODULE_INSTANCE'];
    String partition = env['GAE_PARTITION'];
    String pubServeUrlString = env['DART_PUB_SERVE'];

    // TODO: [instance] is currently only passed by devappserver when starting
    // docker container but not by real deployment.
    if (applicationID == null || module == null || version == null ||
        /*instance == null || */partition == null) {
      throw new StateError('Expected docker environment variables not found.');
    }

    Uri pubServeUrl = pubServeUrlString != null
                    ? Uri.parse(pubServeUrlString)
                    : null;

    return new AppengineContext(
        partition, applicationID, version, module, instance, pubServeUrl);
  }

  Future<storage.Storage> getStorage(AppengineContext context) {
    if (context.isDevelopmentEnvironment) {
      // When running locally the service account path is passed through
      // an environment variable.
      var serviceAccount = Platform.environment['STORAGE_SERVICE_ACCOUNT_FILE'];
      if (serviceAccount != null) {
        return new File(serviceAccount).readAsString().then((keyJson) {
          var creds = new auth.ServiceAccountCredentials.fromJson(keyJson);
          return auth.clientViaServiceAccount(creds, storage.Storage.SCOPES)
              .then((client) {
                gcloud_http.registerAuthClientService(client, close: true);
                return new storage.Storage(client, context.applicationID);
              });
        });
      } else {
        return new Future.value();
      }
    } else {
      return auth.clientViaMetadataServer().then((client) {
        gcloud_http.registerAuthClientService(client, close: true);
        return new storage.Storage(client, context.applicationID);
      });
    }
  }

  var context = getDockerContext();
  var rpcService = initializeRPC();

  return getStorage(context).then((storage) {
    var contextRegistry = new ContextRegistry(rpcService, storage, context);
    return contextRegistry;
  });
}

void initializeContext(Services services) {
  db.registerDbService(services.db);
  datastore.registerDatastoreService(services.db.datastore);
  storage.registerStorageService(services.storage);
  logging.registerLoggingService(services.logging);
  modules.registerModulesService(services.modules);
  memcache.registerMemcacheService(services.memcache);
}

void initializeRequestSpecificServices(Services services) {
  logging.registerLoggingService(services.logging);
  users.registerUserService(services.users);
}

Future withAppEngineServicesInternal(Future callback(contextRegistry)) {
  return ss.fork(() {
    return initializeAppEngine().then((ContextRegistry contextRegistry) {
      var backgroundServices = contextRegistry.newBackgroundServices();
      initializeContext(backgroundServices);
      return callback(contextRegistry);
    });
  });
}

Future withAppEngineServices(Future callback()) {
  return withAppEngineServicesInternal((_) => callback());
}

Future runAppEngine(void handler(request, context), void onError(e, s)) {
  return withAppEngineServicesInternal((ContextRegistry contextRegistry) {
    var appengineServer = new AppEngineHttpServer(contextRegistry);
    appengineServer.run((request, context) {
      ss.fork(() {
        initializeRequestSpecificServices(context.services);
        handler(request, context);
        return request.response.done;
      }, onError: (error, stack) {
        var context = contextRegistry.lookup(request);
        if (context != null) {
          try {
            context.services.logging.error(
                'Uncaught error in request handler: $error\n$stack');
          } catch (e) {
            print('Error while logging uncaught error: $e');
          }
        } else {
          // TODO: We could log on the background ticket here.
          print('Unable to log error, since response has already been sent.');
        }
        onError('Uncaught error in request handler zone: $error', stack);

        // In many cases errors happen during request processing or response
        // preparation. In such cases we want to close the connection, since
        // user code might not be able to.
        try {
          request.response.statusCode = HttpStatus.INTERNAL_SERVER_ERROR;
        } on StateError catch (_) {}
          request.response.close().catchError((closeError, closeErrorStack) {
            onError('Forcefully closing response, due to error in request '
                    'handler zone, resulted in an error: $closeError',
                    closeErrorStack);
        });
      });
    });
    return appengineServer.done;
  });
}

void useLoggingPackageAdaptor() {
  if (_loggingPackageEnabled) return;
  _loggingPackageEnabled = true;
  setupAppEngineLogging();
}
