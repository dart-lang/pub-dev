// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:appengine/appengine.dart';
import 'package:gcloud/db.dart' as db;
import 'package:gcloud/service_scope.dart';
import 'package:gcloud/storage.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:pub_server/shelf_pubserver.dart';
import 'package:shelf/shelf.dart' as shelf;

import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/analyzer_memcache.dart';
import 'package:pub_dartlang_org/shared/configuration.dart';
import 'package:pub_dartlang_org/shared/deps_graph.dart';
import 'package:pub_dartlang_org/shared/package_memcache.dart';
import 'package:pub_dartlang_org/shared/popularity_storage.dart';
import 'package:pub_dartlang_org/shared/search_client.dart';
import 'package:pub_dartlang_org/shared/handler_helpers.dart';

import 'package:pub_dartlang_org/frontend/backend.dart';
import 'package:pub_dartlang_org/frontend/handlers.dart';
import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/search_memcache.dart';
import 'package:pub_dartlang_org/frontend/service_utils.dart';
import 'package:pub_dartlang_org/frontend/templates.dart';
import 'package:pub_dartlang_org/frontend/upload_signer_service.dart';

final Logger _logger = new Logger('pub');

void main() {
  useLoggingPackageAdaptor();

  withAppEngineServices(() async {
    final shelf.Handler apiHandler = await setupServices(activeConfiguration);

    await runAppEngine((HttpRequest ioRequest) async {
      if (context.isProductionEnvironment &&
          ioRequest.requestedUri.scheme != 'https') {
        final secureUri = ioRequest.requestedUri.replace(scheme: 'https');
        ioRequest.response
          ..redirect(secureUri)
          ..close();
      } else {
        try {
          return handleRequest(ioRequest, (shelf.Request request) async {
            _logger.info('Handling request: ${request.requestedUri}');
            await registerLoggedInUserIfPossible(request);
            try {
              final sanitizedRequest = sanitizeRequestedUri(request);
              return await appHandler(sanitizedRequest, apiHandler);
            } catch (error, s) {
              _logger.severe('Request handler failed', error, s);

              Map<String, String> debugHeaders;
              if (context.traceId != null) {
                debugHeaders = {'package-site-request-id': context.traceId};
              }

              return new shelf.Response.internalServerError(
                  body: 'Fatal package site error', headers: debugHeaders);
            } finally {
              _logger.info('Request handler done.');
            }
          });
        } catch (error, stack) {
          _logger.severe('Request handler failed', error, stack);
        }
      }
    });
  });
}

Future<shelf.Handler> setupServices(Configuration configuration) async {
  final Bucket popularityBucket =
      storageService.bucket(configuration.popularityDumpBucketName);
  registerPopularityStorage(
      new PopularityStorage(storageService, popularityBucket));
  await popularityStorage.init();

  registerAnalyzerMemcache(new AnalyzerMemcache(memcacheService));
  final AnalyzerClient analyzerClient =
      new AnalyzerClient(activeConfiguration.analyzerServicePrefix);
  registerAnalyzerClient(analyzerClient);
  registerScopeExitCallback(analyzerClient.close);

  final SearchClient searchClient = new SearchClient();
  registerSearchClient(searchClient);
  registerScopeExitCallback(searchClient.close);

  registerTemplateService(new TemplateService(templateDirectory: templatePath));

  final pkgBucket = storageService.bucket(configuration.packageBucketName);
  final tarballStorage = new TarballStorage(storageService, pkgBucket, null);
  registerTarballStorage(tarballStorage);

  initOAuth2Service();

  await initSearchService();

  // The future will complete once the initial database has been scanned and a
  // graph has been built.  It will nonetheless continue to monitor the database
  // in the background and maintains a global set of package dependencies.
  //
  // It can take up to 1 minute until this future completes.  Though normally we
  // don't have a new package upload within the first minute of deployment, so
  // for all practical purposes this future will be ready.
  final Future<PackageDependencyBuilder> depsGraphBuilderFuture =
      PackageDependencyBuilder.loadInitialGraphFromDb(db.dbService);

  Future uploadFinished(PackageVersion pv) async {
    final depsGraphBuilder = await depsGraphBuilderFuture;

    // Even though the deps graph builder would pick up the new [pv] eventually,
    // we'll add it explicitly here right after the upload to ensure the graph
    // is up-to-date.
    depsGraphBuilder.addPackageVersion(pv);

    // Notify analyzer services about a new version, and *DO NOT* do the
    // same with search service.  The later will get notified after analyzer
    // ran the first analysis on the new version.
    //
    // Note: We provide the analyzer service with a list of packages which need
    // re-analysis.
    final Set<String> dependentPackages =
        depsGraphBuilder.affectedPackages(pv.package);

    // Since there can be many [dependentPackages], we'll not wait for the
    // notification to be done.
    analyzerClient.triggerAnalysis(pv.package, pv.version, dependentPackages);

    // TODO: enable notification of dartdoc service
  }

  final cache = new AppEnginePackageMemcache(memcacheService);
  initBackend(cache: cache, finishCallback: uploadFinished);
  registerSearchMemcache(new SearchMemcache(memcacheService));

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
