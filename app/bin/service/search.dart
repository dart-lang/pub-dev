// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:appengine/appengine.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'package:pub_dartlang_org/shared/configuration.dart';
import 'package:pub_dartlang_org/shared/service_utils.dart';

import 'package:pub_dartlang_org/search/handlers.dart';
import 'package:pub_dartlang_org/search/index_ducene.dart';
import 'package:pub_dartlang_org/search/updater.dart';

void main() {
  useLoggingPackageAdaptor();

  withAppEngineServices(() async {
    return withCorrectDatastore(() async {
      registerPackageIndex(new DucenePackageIndex());
      if (envConfig.duceneDir == null) {
        // Don't push too much info into the in-memory index.
        new PackageIndexUpdater(packageIndex).update(limit: 300);
      } else {
        // TODO: move the indexing into a different isolate.
        new PackageIndexUpdater(packageIndex).startPolling();
      }

      await runAppEngine((HttpRequest request) =>
          shelf_io.handleRequest(request, searchServiceHandler));
    });
  });
}
