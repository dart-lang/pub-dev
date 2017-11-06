// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:package_resolver/package_resolver.dart';
import 'package:source_map_stack_trace/source_map_stack_trace.dart' as mapper;
import 'package:source_maps/source_maps.dart';

/// A class for mapping JS stack traces to Dart stack traces using source maps.
class StackTraceMapper {
  /// The parsed source map.
  ///
  /// This is initialized lazily in `mapStackTrace()`.
  Mapping _mapping;

  /// The package resolution information passed to dart2js.
  final SyncPackageResolver _packageResolver;

  /// The URL of the SDK root from which dart2js loaded its sources.
  final Uri _sdkRoot;

  /// The contents of the source map.
  final String _mapContents;

  /// The URL of the source map.
  final Uri _mapUrl;

  StackTraceMapper(this._mapContents,
      {Uri mapUrl, SyncPackageResolver packageResolver, Uri sdkRoot})
      : _mapUrl = mapUrl,
        _packageResolver = packageResolver,
        _sdkRoot = sdkRoot;

  /// Converts [trace] into a Dart stack trace.
  StackTrace mapStackTrace(StackTrace trace) {
    _mapping ??= parseExtended(_mapContents, mapUrl: _mapUrl);
    return mapper.mapStackTrace(_mapping, trace,
        packageResolver: _packageResolver, sdkRoot: _sdkRoot);
  }

  /// Returns a Map representation which is suitable for JSON serialization.
  Map<String, dynamic> serialize() {
    return {
      'mapContents': _mapContents,
      'sdkRoot': _sdkRoot?.toString(),
      'packageConfigMap':
          _serializePackageConfigMap(_packageResolver.packageConfigMap),
      'packageRoot': _packageResolver.packageRoot?.toString(),
      'mapUrl': _mapUrl?.toString(),
    };
  }

  /// Returns a [StackTraceMapper] contained in the provided serialized
  /// representation.
  static StackTraceMapper deserialize(Map serialized) {
    if (serialized == null) return null;
    String packageRoot = serialized['packageRoot'] as String ?? '';
    return new StackTraceMapper(serialized['mapContents'],
        sdkRoot: Uri.parse(serialized['sdkRoot']),
        packageResolver: packageRoot.isNotEmpty
            ? new SyncPackageResolver.root(Uri.parse(serialized['packageRoot']))
            : new SyncPackageResolver.config(
                _deserializePackageConfigMap(serialized['packageConfigMap'])),
        mapUrl: Uri.parse(serialized['mapUrl']));
  }

  /// Converts a [packageConfigMap] into a format suitable for JSON
  /// serialization.
  static Map<String, String> _serializePackageConfigMap(
      Map<String, Uri> packageConfigMap) {
    if (packageConfigMap == null) return null;
    return mapMap(packageConfigMap, value: (_, value) => '$value');
  }

  /// Converts a serialized package config map into a format suitable for
  /// the [PackageResolver]
  static Map<String, Uri> _deserializePackageConfigMap(
      Map<String, String> serialized) {
    if (serialized == null) return null;
    return mapMap(serialized, value: (_, value) => Uri.parse(value));
  }
}
