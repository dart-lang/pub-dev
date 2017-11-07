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
  final bool isDevelopmentEnvironment;
  final AssetsManager assets;

  AppengineContext(this.isDevelopmentEnvironment, this.applicationID,
      this.version, this.module, this.instance, Uri pubServeUrl)
      : partition = '',
        assets = new AssetsManager(pubServeUrl, isDevelopmentEnvironment);

  String get fullQualifiedApplicationId => '$partition~$applicationID';
}
