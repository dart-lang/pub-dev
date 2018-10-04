// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.server_common;

import 'dart:async';
import 'dart:io';

import 'package:appengine/appengine.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart';
import 'package:http/http.dart' as http;

import '../shared/configuration.dart';
import '../shared/package_memcache.dart';

import 'backend.dart';
import 'search_service.dart';
import 'upload_signer_service.dart';

final String templatePath = Platform.script.resolve('../views').toFilePath();

void initSearchService() {
  registerSearchService(new SearchService());
  registerScopeExitCallback(searchService.close);
}

void initBackend(
    {UIPackageCache cache, FinishedUploadCallback finishCallback}) {
  registerBackend(new Backend(dbService, tarballStorage,
      cache: cache, finishCallback: finishCallback));
}

Future<String> obtainServiceAccountEmail() async {
  final http.Response response = await http.get(
      'http://metadata/computeMetadata/'
      'v1/instance/service-accounts/default/email',
      headers: const {'Metadata-Flavor': 'Google'});
  return response.body.trim();
}

Future withProdServices(Future fun()) {
  return withAppEngineServices(() {
    if (!envConfig.hasGcloudKey) {
      throw new Exception(
          'Missing GCLOUD_* environments for package:appengine');
    }
    registerUploadSigner(
        new ServiceAccountBasedUploadSigner(activeConfiguration.credentials));
    initBackend();
    return fun();
  });
}
