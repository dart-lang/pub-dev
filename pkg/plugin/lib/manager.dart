// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library plugin.manager;

import 'package:plugin/src/plugin_impl.dart';
import 'package:plugin/plugin.dart';

/**
 * An object that manages the extension points for the host application.
 */
abstract class ExtensionManager {
  /**
   * Initialize a newly created manager.
   */
  factory ExtensionManager() = ExtensionManagerImpl;

  /**
   * Process each of the given [plugins] by allowing them to register extension
   * points and extensions.
   *
   * An [ExtensionError] will be thrown if any of the plugins throws such an
   * exception while registering with this manager.
   */
  void processPlugins(List<Plugin> plugins);
}
