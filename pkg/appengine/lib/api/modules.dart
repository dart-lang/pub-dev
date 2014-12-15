// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library appengine.api.modules;

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;

abstract class ModulesService {
  /**
   * Returns the current running module name.
   */
  String get currentModule;

  /**
   * Returns the current running module version.
   */
  String get currentVersion;

  /**
   * Returns the current running module instance.
   */
  String get currentInstance;

  /**
   * Completes with the default version for module [module].
   */
  Future<String> defaultVersion(String module);

  /**
   * Completes with a list of all modules.
   */
  Future<List<String>> modules();

  /**
   * Completes with a list of all versions for module [module].
   */
  Future<List<String>> versions(String module);

  /**
   * Completes with a hostname, that can be used to contact a given part of an
   * application.
   *
   * Without any arguments, the result is the hostname for the
   * default module and default version.
   *
   * If [module] is specified, the result is the hostname for the
   * specified module and the default version.
   *
   * If [module] and [version] is specified, the result is the hostname for the
   * specified module and the specified version.
   *
   * Finally if [instance] is also specified, the result is the hostname for
   * contacting a specific running instance for the specified [module] and
   * [version].
   *
   * For applications served from the appspot.com domain, some of the dots
   * used to separate the different parts of the hostname will be replaced
   * by `-dot-`. This is to support application access using HTTPS, and is
   * required as Google is no longer issuing SSL certificates for
   * double-wildcard domains hosted at appspot.com (i.e. *.*.appspot.com).
   */
  Future<String> hostname([String module, String version, String instance]);
}

/**
 * Register a new [ModulesService] object.
 *
 * Calling this outside of a service scope or calling it more than once inside
 * the same service scope will result in an error.
 *
 * See the `package:gcloud/service_scope.dart` library for more information.
 */
void registerModulesService(ModulesService service) {
  ss.register(#_appengine.modules, service);
}

/**
 * The modules service.
 *
 * Request handlers will be run inside a service scope which contains the
 * modules service.
 */
ModulesService get modulesService => ss.lookup(#_appengine.modules);
