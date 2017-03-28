// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:async';

import 'package:appengine/appengine.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:pub_dartlang_org/keys.dart';
import 'package:pub_dartlang_org/upload_signer_service.dart';

import 'configuration.dart';
import 'server_common.dart';

withProdServices(Future fun()) async {
  if (!Platform.environment.containsKey('GCLOUD_PROJECT') ||
      !Platform.environment.containsKey('GCLOUD_KEY')) {
    throw 'Missing GCLOUD_* environments for package:appengine';
  }
  return withAppEngineServices(() {
    return ss.fork(() async {
      final credentials = new auth.ServiceAccountCredentials(
          activeConfiguration.serviceAccountEmail,
          new auth.ClientId('', ''),
          await cloudStorageKeyFromDB());
      final authClient =
          await auth.clientViaServiceAccount(credentials, SCOPES);
      ss.registerScopeExitCallback(authClient.close);
      initStorage(activeConfiguration.projectId, authClient);

      registerUploadSigner(new UploadSignerService(
          activeConfiguration.credentials.email,
          credentials.privateRSAKey));
      initBackend();

      return fun();
    });
  });
}
