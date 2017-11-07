// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library plugin.src.plugin_impl;

import 'dart:collection';

import 'package:plugin/manager.dart';
import 'package:plugin/plugin.dart';

/**
 * A concrete implementation of an [ExtensionManager].
 */
class ExtensionManagerImpl implements ExtensionManager {
  /**
   * A table mapping the id's of extension points to the corresponding
   * extension points.
   */
  Map<String, ExtensionPointImpl> extensionPoints =
      new HashMap<String, ExtensionPointImpl>();

  @override
  void processPlugins(List<Plugin> plugins) {
    for (Plugin plugin in plugins) {
      plugin.registerExtensionPoints(registerExtensionPoint);
    }
    for (Plugin plugin in plugins) {
      plugin.registerExtensions(registerExtension);
    }
  }

  /**
   * Register an [extension] to the extension point with the given unique
   * [identifier].
   */
  void registerExtension(String identifier, Object extension) {
    ExtensionPointImpl extensionPoint = extensionPoints[identifier];
    if (extensionPoint == null) {
      throw new ExtensionError(
          'There is no extension point with the id "$identifier"');
    }
    extensionPoint.add(extension);
  }

  /**
   * Register the given [extensionPoint].
   */
  void registerExtensionPoint(ExtensionPoint extensionPoint) {
    String uniqueIdentifier = extensionPoint.uniqueIdentifier;
    if (extensionPoints.containsKey(uniqueIdentifier)) {
      throw new ExtensionError(
          'There is already an extension point with the id "$uniqueIdentifier"');
    }
    extensionPoints[uniqueIdentifier] = extensionPoint as ExtensionPointImpl;
  }
}

/**
 * A concrete representation of an extension point.
 */
class ExtensionPointImpl<E> implements ExtensionPoint<E> {
  @override
  final Plugin plugin;

  @override
  final String simpleIdentifier;

  /**
   * The function used to validate extensions to this extension point.
   */
  final ValidateExtension validateExtension;

  /**
   * The list of extensions to this extension point.
   */
  final List<E> _extensions = <E>[];

  /**
   * Initialize a newly create extension point to belong to the given [plugin]
   * and have the given [simpleIdentifier]. If [validateExtension] is non-`null`
   * it will be used to validate extensions associated with this extension
   * point.
   */
  ExtensionPointImpl(
      this.plugin, this.simpleIdentifier, this.validateExtension);

  /**
   * Return a list containing all of the extensions that have been registered
   * for this extension point.
   */
  List<E> get extensions => new UnmodifiableListView<E>(_extensions);

  /**
   * Return the identifier used to uniquely identify this extension point. The
   * unique identifier is the identifier for the plugin, followed by a period
   * (`.`), followed by the [simpleIdentifier] for the extension point.
   */
  String get uniqueIdentifier =>
      Plugin.buildUniqueIdentifier(plugin, simpleIdentifier);

  /**
   * Validate that the given [extension] is appropriate for this extension
   * point, and if it is then add it to the list of registered exceptions.
   */
  void add(Object extension) {
    if (validateExtension != null) {
      validateExtension(extension);
    }
    _extensions.add(extension as E);
  }
}
