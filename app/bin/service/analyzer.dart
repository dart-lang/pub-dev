// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:appengine/appengine.dart';

void main() {
  useLoggingPackageAdaptor();

  withAppEngineServices(() async {
    await runAppEngine((HttpRequest ioRequest) async {
      // TODO: implement API handlers
      final HttpResponse response = ioRequest.response;
      response.statusCode = 200;
      await response.close();
    });
  });
  // TODO: periodic polling for analyzer tasks
}
