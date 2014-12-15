// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library appengine.api.memcache;

import 'package:gcloud/service_scope.dart' as ss;
import 'package:memcache/memcache.dart';

/**
 * Register a new [Memcache] object.
 *
 * Calling this outside of a service scope or calling it more than once inside
 * the same service scope will result in an error.
 *
 * See the `package:gcloud/service_scope.dart` library for more information.
 */
void registerMemcacheService(Memcache service) {
  ss.register(#_appengine.memcache, service);
}

/**
 * The memcache service.
 *
 * Request handlers will be run inside a service scope which contains the
 * memcache service.
 */
Memcache get memcacheService => ss.lookup(#_appengine.memcache);
