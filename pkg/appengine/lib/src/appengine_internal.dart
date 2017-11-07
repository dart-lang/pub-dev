// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library appengine.internal;

import 'dart:async';
import 'dart:io';

import 'package:gcloud/datastore.dart' as datastore;
import 'package:gcloud/db.dart' as db;
import 'package:gcloud/http.dart' as gcloud_http;
import 'package:gcloud/service_scope.dart' as ss;
import 'package:gcloud/storage.dart' as storage;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;
import 'package:memcache/memcache.dart' as memcache;
import 'package:memcache/memcache_raw.dart' as memcache_raw;
import 'package:path/path.dart' as p;

import 'errors.dart' as errors;
import 'logging.dart' as logging;
import 'memcache.dart' as memcache_interface;

import 'api_impl/nop_memcache_impl.dart' as nop_memcache_impl;
import 'api_impl/stderr_logging_impl.dart' as stderr_logging_impl;
import 'appengine_context.dart';
import 'client_context.dart';
import 'grpc_api_impl/auth_utils.dart' as auth_utils;
import 'grpc_api_impl/datastore_impl.dart' as grpc_datastore_impl;
import 'grpc_api_impl/grpc.dart' as grpc;
import 'grpc_api_impl/logging_impl.dart' as grpc_logging_impl;
import 'logging.dart';
import 'logging_impl.dart';
import 'server/context_registry.dart';
import 'server/logging_package_adaptor.dart';
import 'server/server.dart';

bool _loggingPackageEnabled = false;

/// Runs the given [callback] inside a new service scope and makes AppEngine
/// services available within that scope.
Future withAppEngineServices(Future callback()) =>
    _withAppEngineServicesInternal((_) => callback());

/// Runs the AppEngine http server and uses the given request [handler] to
/// handle incoming http requests.
///
/// The given request [handler] is run inside a new service scope and has all
/// AppEngine services available within that scope.
Future runAppEngine(void handler(HttpRequest request, ClientContext context),
    void onError(Object e, StackTrace s),
    {int port: 8080, bool shared: false}) {
  return _withAppEngineServicesInternal((ContextRegistry contextRegistry) {
    var appengineServer =
        new AppEngineHttpServer(contextRegistry, port: port, shared: shared);
    appengineServer.run((request, context) {
      ss.fork(() {
        logging.registerLoggingService(context.services.logging);
        handler(request, context);
        return request.response.done;
      }, onError: (error, stack) {
        var context = contextRegistry.lookup(request);
        if (context != null) {
          try {
            context.services.logging
                .error('Uncaught error in request handler: $error\n$stack');
          } catch (e) {
            print('Error while logging uncaught error: $e.'
                'Original error: $error\n$stack');
          }
        } else {
          print('Unable to log error, since response has already been sent'
              'Original error: $error\n$stack');
        }
        if (onError != null) {
          onError('Uncaught error in request handler zone: $error', stack);
        }

        // In many cases errors happen during request processing or response
        // preparation. In such cases we want to close the connection, since
        // user code might not be able to.
        try {
          request.response.statusCode = HttpStatus.INTERNAL_SERVER_ERROR;
        } on StateError catch (_) {}
        request.response.close().catchError((closeError, closeErrorStack) {
          final message = 'Forcefully closing response, due to error in request'
              ' handler zone, resulted in an error: $closeError';
          if (onError != null) {
            onError(message, closeErrorStack);
          } else {
            print('$message\n$closeErrorStack');
          }
        });
      });
    });
    return appengineServer.done;
  });
}

Future _withAppEngineServicesInternal(
    Future callback(ContextRegistry contextRegistry)) {
  return ss.fork(() async {
    ContextRegistry contextRegistry = await _initializeAppEngine();
    final bgServices = contextRegistry.newBackgroundServices();

    db.registerDbService(bgServices.db);
    datastore.registerDatastoreService(bgServices.db.datastore);
    storage.registerStorageService(bgServices.storage);
    logging.registerLoggingService(bgServices.logging);
    memcache_interface.registerMemcacheService(bgServices.memcache);

    return callback(contextRegistry);
  });
}

/// Sets up a `package:logging` adaptor to use AppEngine logging service.
///
/// The logging messages made via `package:logging` which are made inside a
/// request handler will end up grouped together in an AppEngine logging entry.
void useLoggingPackageAdaptor() {
  if (_loggingPackageEnabled) return;
  _loggingPackageEnabled = true;
  setupAppEngineLogging();
}

/// Uses various environment variables to initialize the appengine services and
/// returns a new [ContextRegistry] which is used for registering in-progress
/// http requests.
Future<ContextRegistry> _initializeAppEngine() async {
  var zoneId = await _getZoneInProduction();
  final isDevEnvironment = zoneId == null;
  zoneId ??= 'dev-machine';
  final bool isProdEnvironment = !isDevEnvironment;

  String _findEnvironmentVariable(String name,
      {bool onlyInProd: false, bool onlyInDev: false, bool needed: true}) {
    if (onlyInProd && !isProdEnvironment) return null;
    if (onlyInDev && !isDevEnvironment) return null;

    final value = Platform.environment[name];
    if (value == null && needed) {
      throw new StateError('Expected environment variable $name to be set!');
    }
    return value;
  }

  final projectId = _findEnvironmentVariable('GCLOUD_PROJECT', needed: true);

  // If we find the "GCLOUD_KEY" environment variable, we'll use it for
  // authentication otherwise the assumption is we're running in the cloud and
  // can use the metadata server.
  final gcloudKey =
      _findEnvironmentVariable('GCLOUD_KEY', onlyInDev: true, needed: true);

  // For local testing the gcloud sdk brings now a gRPC-ready datastore
  // emulator which will tell the user to use this environment variable.
  final dbEmulatorHost = _findEnvironmentVariable('DATASTORE_EMULATOR_HOST',
      onlyInDev: false, needed: false);

  final serviceId =
      _findEnvironmentVariable('GAE_SERVICE', onlyInProd: true, needed: true) ??
          'dummy-service';
  final versionId =
      _findEnvironmentVariable('GAE_VERSION', onlyInProd: true, needed: true) ??
          'dummy-version';
  final instance = _findEnvironmentVariable('GAE_INSTANCE',
          onlyInProd: true, needed: true) ??
      'dummy-instance';

  final String pubServeUrlString = Platform.environment['DART_PUB_SERVE'];
  final Uri pubServeUrl =
      pubServeUrlString != null ? Uri.parse(pubServeUrlString) : null;

  final context = new AppengineContext(
      isDevEnvironment, projectId, versionId, serviceId, instance, pubServeUrl);

  final serviceAccount = _obtainServiceAccountCredentials(gcloudKey);
  final loggerFactory =
      await _obtainLoggerFactory(context, serviceAccount, zoneId);
  final storageService =
      await _obtainStorageService(context.applicationID, serviceAccount);

  final memcacheService =
      await _obtainMemcacheInstance(loggerFactory.newBackgroundLogger());
  final dbService = await _obtainDatastoreService(
      context.applicationID, dbEmulatorHost, serviceAccount);

  return new ContextRegistry(
      loggerFactory, dbService, storageService, memcacheService, context);
}

/// Obtains a gRPC-based datastore implementation.
///
/// If [dbEmulatorHost] is not null it must have the form 'host:port' and
/// support http/2-based unencrypted gRPC.
///
/// Otherwise http2/-based encrypted gRPC will be used to Google's production
/// service.
///
/// The datastore emulator comes with the gcloud sdk and can be launched via:
///
///     $ gcloud beta emulators datastore start
///       ...
///       [datastore] If you are using a library that supports the
///                   DATASTORE_EMULATOR_HOST environment variable, run:
///       [datastore]
///       [datastore]   export DATASTORE_EMULATOR_HOST=localhost:8037
///       [datastore]
///       [datastore] Dev App Server is now running.
///       ...
///
/// The returned [db.DatastoreDB] will be usable within the current service
/// scope.
Future<db.DatastoreDB> _obtainDatastoreService(
    String projectId,
    String dbEmulatorHost,
    auth.ServiceAccountCredentials serviceAccount) async {
  String endpoint = 'https://datastore.googleapis.com';
  bool needAuthorization = true;
  if (dbEmulatorHost != null && dbEmulatorHost.contains(':')) {
    // The datastore emulator uses unencrypted http/2, we use therefore 'http'
    // for the uri scheme.
    endpoint = 'http://$dbEmulatorHost';
    needAuthorization = false;
  }
  final grpcClient = await _getGrpcClient(serviceAccount, endpoint,
      grpc_datastore_impl.OAuth2Scopes, needAuthorization);
  ss.registerScopeExitCallback(grpcClient.close);
  final rawDatastore =
      new grpc_datastore_impl.GrpcDatastoreImpl(grpcClient, projectId);
  return new db.DatastoreDB(rawDatastore, modelDB: new db.ModelDBImpl());
}

/// Attempts to find out if there is a memcached server running on localhost
/// with the default port (be it on compute engine or in local development).
///
/// If we were unable to locate a locally running memcached this function will
/// return a dummy NOP memcache instance.
///
/// The returned [memcache.Memcache] will be usable within the current service
/// scope.
Future<memcache.Memcache> _obtainMemcacheInstance(Logging logging) async {
  // These are the environment variables available within the AppEngine Flex
  // Docker container when Memcache support is enabled.
  //
  // NOTE: As of 2017-09-08 this is an alpha feature – functionality may change.
  const hostKey = 'GAE_MEMCACHE_HOST';
  const portKey = 'GAE_MEMCACHE_PORT';
  final hostVar = Platform.environment[hostKey];
  final hostPort = Platform.environment[portKey];

  if (hostVar != null && hostPort != null) {
    final portNumber = int.parse(hostPort);
    final instance = await _tryMemcacheInstance(hostVar, portNumber, logging);
    if (instance != null) {
      return instance;
    }
  }

  const int defaultMemcachedPort = 11211;
  final instance =
      await _tryMemcacheInstance('localhost', defaultMemcachedPort, logging);
  if (instance != null) {
    return instance;
  }

  logging.debug('Falling back to non-caching memcache implementation.');
  final nopMemcache = new nop_memcache_impl.NopMemcacheRpcImpl();
  return new memcache.Memcache.fromRaw(nopMemcache);
}

Future<memcache.Memcache> _tryMemcacheInstance(
    String host, int port, Logging logging) async {
  final nowMicros = new DateTime.now().microsecondsSinceEpoch;
  final String testKey = '__test_key_$nowMicros';
  final testValue = 'fobar-$nowMicros';

  logging.debug('Attempting to connect to memcache at $host:$port');
  var rawMemcache = new memcache_raw.BinaryMemcacheProtocol(host, port);
  try {
    final memcacheService = new memcache.Memcache.fromRaw(rawMemcache);

    // Do a store/read attempt (which will trigger the real tcp connection) and
    // ensure it caches a key. If everything is successful, we'll return the
    // instance.
    await memcacheService.set(testKey, testValue);
    if (await memcacheService.get(testKey) == testValue) {
      // The test was successful, so we'll cleanup & ensure to close the client
      // once we go out of the current service scope and return the instance.
      await memcacheService.remove(testKey);
      ss.registerScopeExitCallback(rawMemcache.close);
      logging.info('Connected to memcache at $host:$port');
      return memcacheService;
    }
  } catch (e, stack) {
    logging.warning('Could not connect to memcache instance at $host:$port\n'
        '$e\n$stack');
  }

  // We were unable to connect to a memcached server running on localhost, so
  // we'll fall back to a dummy NOP memcache instance.
  if (rawMemcache != null) {
    await rawMemcache.close();
  }

  return null;
}

/// Creates a storage service using the service account credentials (if given)
/// or using the metadata to obtain access credentials.
Future<storage.Storage> _obtainStorageService(
    String projectId, auth.ServiceAccountCredentials serviceAccount) async {
  final authClient =
      await _getAuthClient(serviceAccount, storage.Storage.SCOPES);
  return new storage.Storage(authClient, projectId);
}

/// Creates a closure function which can be used for
///
/// The underlying logging implementation will be usable within the current
/// service scope.
Future<LoggerFactory> _obtainLoggerFactory(AppengineContext context,
    auth.ServiceAccountCredentials serviceAccount, String zoneId) async {
  if (context.isDevelopmentEnvironment) {
    return new StderrLoggerFactory();
  } else {
    final sharedLoggingService = new grpc_logging_impl.SharedLoggingService(
        await _getGrpcClient(serviceAccount, 'https://logging.googleapis.com',
            grpc_logging_impl.OAuth2Scopes, true),
        context.applicationID,
        context.module,
        context.version,
        zoneId);
    ss.registerScopeExitCallback(sharedLoggingService.close);
    return new GrpcLoggerFactory(sharedLoggingService);
  }
}

/// Creates an authenticated http client using service account credentials for
/// authorization.
///
/// The returned [auth.AuthClient] will be usable within the current service
/// scope.
Future<auth.AuthClient> _getAuthClient(
    auth.ServiceAccountCredentials serviceAccount, List<String> scopes) async {
  auth.AuthClient client;
  if (serviceAccount != null) {
    client = await auth.clientViaServiceAccount(serviceAccount, scopes);
  } else {
    client = await auth.clientViaMetadataServer();
  }
  gcloud_http.registerAuthClientService(client, close: true);
  return client;
}

/// Creates a grpc client to the specified host using service account
/// credentials for authorization.
///
/// The returned [grpc.Client] will be usable within the current service scope.
Future<grpc.Client> _getGrpcClient(
    auth.ServiceAccountCredentials serviceAccount,
    String url,
    List<String> scopes,
    bool needAuthorization) async {
  var accessTokenProvider;
  if (needAuthorization) {
    if (serviceAccount != null) {
      accessTokenProvider =
          new auth_utils.ServiceAccountTokenProvider(serviceAccount, scopes);
    } else {
      accessTokenProvider = new auth_utils.MetadataAccessTokenProvider();
    }
  }
  final client = await grpc.connectToEndpoint(Uri.parse(url),
      accessTokenProvider: accessTokenProvider, timeout: 20);
  ss.registerScopeExitCallback(client.close);
  return client;
}

auth.ServiceAccountCredentials _obtainServiceAccountCredentials(
    String gcloudKey) {
  if (gcloudKey != null && gcloudKey != '') {
    try {
      final serviceAccountJson = new File(gcloudKey).readAsStringSync();
      return new auth.ServiceAccountCredentials.fromJson(serviceAccountJson);
    } catch (e) {
      throw new errors.AppEngineError(
          'There was problem using the GCLOUD_KEY "$gcloudKey". '
          'It might be an invalid service account key in json form.\n'
          '$e');
    }
  }
  return null;
}

Future<String> _getZoneInProduction() async {
  final client = new http.Client();
  try {
    var response = await client.get(
        'http://metadata.google.internal/computeMetadata/v1/instance/zone',
        headers: {'Metadata-Flavor': 'Google'});
    if (response.statusCode == HttpStatus.OK) {
      return p.split(response.body).last;
    }

    throw [
      "Reqeust for metadata returned something unexpected",
      response.statusCode,
      response.body
    ].join('\n');
  } on SocketException {
    // likely not on cloud
    return null;
  } catch (e) {
    stderr.writeln("Unexpected error when trying to access metadata");
    rethrow;
  } finally {
    client.close();
  }
}

/// Factory used for creating request-specific and background loggers.
///
/// The implementation sends log messages to the Stackdriver logging service via
/// gRPC.
class GrpcLoggerFactory implements LoggerFactory {
  final grpc_logging_impl.SharedLoggingService _shared;

  GrpcLoggerFactory(this._shared);

  LoggingImpl newRequestSpecificLogger(String method, String resource,
      String userAgent, String host, String ip) {
    return new grpc_logging_impl.GrpcRequestLoggingImpl(
        _shared, method, resource, userAgent, host, ip);
  }

  logging.Logging newBackgroundLogger() {
    return new grpc_logging_impl.GrpcBackgroundLoggingImpl(_shared);
  }
}

/// Factory used for creating request-specific and background loggers.
///
/// The implementation writes log messages to stderr.
class StderrLoggerFactory implements LoggerFactory {
  LoggingImpl newRequestSpecificLogger(String method, String resource,
      String userAgent, String host, String ip) {
    return new stderr_logging_impl.StderrRequestLoggingImpl(
        method, resource, userAgent, host, ip);
  }

  logging.Logging newBackgroundLogger() {
    return new stderr_logging_impl.StderrBackgroundLoggingImpl();
  }
}
