// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:async';

import 'package:gcloud/service_scope.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'package:pub_dartlang_org/handlers.dart';
import 'package:pub_dartlang_org/templates.dart';
import 'package:pub_dartlang_org/upload_signer_service.dart';

import 'server_common.dart';

/// The location of the service account key.
final KeyLocation = Platform.script.resolve('../../key.json').toFilePath();

/// Template directory location
final TemplateLocation = Platform.script.resolve('../views').toFilePath();

/// Template directory location
final StaticsLocation = Platform.script.resolve('../../static').toFilePath();

/// The service account credentials used for making API calls.
final Credentials = new auth.ServiceAccountCredentials.fromJson(
    new File(KeyLocation).readAsStringSync());

void main() {
  // Change this `namespace` variable to change the namespace used.
  final String namespace = '';

  Logger.root.onRecord.listen((LogRecord record) {
    print('[${record.time}] ${record.level} ${record.loggerName}: '
          '${record.message}');
    if (record.error != null) print('Error: ${record.error}');
    if (record.stackTrace != null) print('${record.stackTrace}');
  });

  fork(() async {
    var authClient = await auth.clientViaServiceAccount(Credentials, SCOPES);
    registerScopeExitCallback(authClient.close);
    registerTemplateService(
        new TemplateService(templateDirectory: TemplateLocation));

    initApiaryStorage(authClient);
    initApiaryDatastore(authClient);
    initOAuth2Service();
    await initSearchService();

    return withChangedNamespaces(() {
      initBackend();

      registerUploadSigner(new UploadSignerService(
          Credentials.email, Credentials.privateRSAKey));

      var apiHandler = initPubServer();

      shelf_io.serve((request) async {
        return fork(() async {
          var response = staticHandler(request);
          if (response != null) return response;

          await registerLoggedInUserIfPossible(request);
          logger.info('Handling request: ${request.requestedUri} '
                      '(Using namespace "$namespace")');
          var result = new Future.sync(() => appHandler(request, apiHandler));
          return result.catchError((error, stack) {
            logger.severe('Request handler failed', error, stack);
            return new shelf.Response.internalServerError();
          }).whenComplete(() {
            logger.info('Request handler done.');
          });
        });
      }, 'localhost', 8383);

      // NOTE: shelf_io.serve() doesn't have a future when the HTTP server is
      // done. We therefore never complete for now.
      return new Completer().future;
    }, TestProjectPackageBucket, namespace: namespace);
  });
}

staticHandler(shelf.Request request) {
  var urlPath = request.requestedUri.path;

  if (urlPath.startsWith('/static/')) {
    urlPath = urlPath.substring('/static/'.length);
    var assetPath = path.normalize(path.join(StaticsLocation, urlPath));

    // We make sure that after normalization we're still inside the static/
    // directory
    if (assetPath.startsWith(StaticsLocation)) {
      var assetFile = new File(assetPath);
      if (assetFile.existsSync()) {
        var data = new Stream.fromIterable([assetFile.readAsBytesSync()]);
        var mimetype = 'octet/binary';
        if (assetPath.endsWith('.css')) mimetype = 'text/css';
        if (assetPath.endsWith('.js')) mimetype = 'application/javascript';
        if (assetPath.endsWith('.png')) mimetype = 'image/png';
        return new shelf.Response.ok(
            data, headers: {'content-type' : mimetype});
      }
    }
    return new shelf.Response.notFound(null);
  }
}
