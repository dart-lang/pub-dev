// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/service_scope.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:pub_dartlang_org/upload_signer_service.dart';

import 'configuration.dart';
import 'server_common.dart';

withProdServices(String jsonKeyfile, fun(), {String namespace: ''}) {
  var prodConfigurationIO = new Configuration.dev_io(
      'dartlang-pub',
      'pub.dartlang.org',
      credentialsFile: jsonKeyfile);

  // We use this one for accessing gs://pub.dartlang.org since it's owned by a
  // different project (the key will be fetched from the DB).
  var prodConfiguration = new Configuration.prod();

  return fork(() async {
    var authClient = await auth.clientViaServiceAccount(
        prodConfigurationIO.credentials, SCOPES);
    registerScopeExitCallback(authClient.close);

    initApiaryDatastore(prodConfigurationIO.projectId, authClient);
    await initApiaryStorageViaDBKey(
        prodConfiguration.serviceAccountEmail,
        prodConfiguration.projectId);

    return withChangedNamespaces(() {
      registerUploadSigner(new UploadSignerService(
          prodConfigurationIO.credentials.email,
          prodConfigurationIO.credentials.privateRSAKey));
      initBackend();

      return fun();
    }, prodConfigurationIO.packageBucketName, namespace: namespace);
  });
}

