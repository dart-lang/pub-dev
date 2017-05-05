// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:appengine/appengine.dart';

import 'package:pub_dartlang_org/upload_signer_service.dart';

import 'configuration.dart';
import 'server_common.dart';

Future withProdServices(Future fun()) {
  return withAppEngineServices(() {
    if (!Platform.environment.containsKey('GCLOUD_PROJECT') ||
        !Platform.environment.containsKey('GCLOUD_KEY')) {
      throw 'Missing GCLOUD_* environments for package:appengine';
    }
    return withCorrectDatastore(() {
      registerUploadSigner(
          new ServiceAccountBasedUploadSigner(activeConfiguration.credentials));
      initBackend();
      return fun();
    });
  });
}
