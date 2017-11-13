// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.server_common;

import 'dart:async';
import 'dart:io';

import 'package:appengine/appengine.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart';
import 'package:gcloud/storage.dart';
import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart' as shelf;

import '../shared/configuration.dart';
import '../shared/package_memcache.dart';

import 'backend.dart';
import 'oauth2_service.dart';
import 'search_service.dart';
import 'upload_signer_service.dart';

final String templatePath = Platform.script.resolve('../views').toFilePath();

void initOAuth2Service() {
  // The oauth2 service is used for getting an email address from an oauth2
  // access token (which the pub client sends).
  final client = new http.Client();
  registerOAuth2Service(new OAuth2Service(client));
  registerScopeExitCallback(client.close);
}

void initStorage(String projectId, http.Client authClient) {
  registerStorageService(new Storage(authClient, projectId));
}

Future initSearchService() async {
  registerSearchService(new SearchService());
  registerScopeExitCallback(searchService.close);
}

Future initBackend(
    {UIPackageCache cache, FinishedUploadCallback finishCallback}) async {
  registerExistingPackageValidator(new ExistingPackageValidator(dbService));
  await existingPackageValidator.refresh();
  registerBackend(new Backend(dbService, tarballStorage,
      cache: cache, finishCallback: finishCallback));
}

/// Looks at [request] and if the 'Authorization' header was set tries to get
/// the user email address and registers it.
Future registerLoggedInUserIfPossible(shelf.Request request) async {
  final authorization = request.headers['authorization'];
  if (authorization != null) {
    final parts = authorization.split(' ');
    if (parts.length == 2 && parts.first.trim().toLowerCase() == 'bearer') {
      final accessToken = parts.last.trim();

      final email = await oauth2Service.lookup(accessToken);
      if (email != null) {
        registerLoggedInUser(email);
      }
    }
  }
}

Future<String> obtainServiceAccountEmail() async {
  final http.Response response = await http.get(
      'http://metadata/computeMetadata/'
      'v1/instance/service-accounts/default/email',
      headers: const {'Metadata-Flavor': 'Google'});
  return response.body.trim();
}

Future withProdServices(Future fun()) {
  return withAppEngineServices(() async {
    if (!envConfig.hasGcloudKey) {
      throw 'Missing GCLOUD_* environments for package:appengine';
    }
    registerUploadSigner(
        new ServiceAccountBasedUploadSigner(activeConfiguration.credentials));
    await initBackend();
    return fun();
  });
}
