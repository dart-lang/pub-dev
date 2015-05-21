// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library appengine.appengine_context;

import 'server/assets.dart';

class AppengineContext {
  final String applicationID;
  final String partition;
  final String version;
  final String module;
  final String instance;
  final AssetsManager assets;

  AppengineContext(String partition, this.applicationID, this.version,
                   this.module, this.instance, Uri pubServeUrl)
      : partition = partition,
        assets = new AssetsManager(pubServeUrl, partition == 'dev');

  bool get isDevelopmentEnvironment => partition == 'dev';

  String get fullQualifiedApplicationId => '$partition~$applicationID';

  String get backgroundTicket {
    var majorVersion = version.split('_')[0];
    var escapedApplicationID =
       applicationID.replaceAll(':', '_').replaceAll('.', '_');

    return '$escapedApplicationID/$module.$majorVersion.$instance';
  }
}
