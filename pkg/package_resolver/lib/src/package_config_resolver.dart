// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:package_config/packages_file.dart' as packages_file;
import 'package:path/path.dart' as p;

import 'async_package_resolver.dart';
import 'package_resolver.dart';
import 'sync_package_resolver.dart';
import 'utils.dart';

/// A package resolution strategy based on a package config map.
class PackageConfigResolver implements SyncPackageResolver {
  final packageRoot = null;

  final Map<String, Uri> packageConfigMap;

  Uri get packageConfigUri {
    if (_uri != null) return _uri;

    var buffer = new StringBuffer();
    packages_file.write(buffer, packageConfigMap, comment: "");
    _uri = new UriData.fromString(buffer.toString(),
            parameters: {"charset": "utf-8"})
        .uri;
    return _uri;
  }
  Uri _uri;

  PackageResolver get asAsync => new AsyncPackageResolver(this);

  String get processArgument => "--packages=$packageConfigUri";

  PackageConfigResolver(Map<String, Uri> packageConfigMap, {uri})
      : packageConfigMap = _normalizeMap(packageConfigMap),
        _uri = uri == null ? null : asUri(uri, "uri");

  /// Normalizes the URIs in [map] to ensure that they all end in a trailing
  /// slash.
  static Map<String, Uri> _normalizeMap(Map<String, Uri> map) =>
      new UnmodifiableMapView(
          mapMap(map, value: (_, uri) => ensureTrailingSlash(uri)));

  Uri resolveUri(packageUri) {
    var uri = asPackageUri(packageUri, "packageUri");

    var baseUri = packageConfigMap[uri.pathSegments.first];
    if (baseUri == null) return null;

    var segments = baseUri.pathSegments.toList()
      ..removeLast(); // Remove the trailing slash.

    // Following [Isolate.resolvePackageUri], "package:foo" resolves to null.
    if (uri.pathSegments.length == 1) return null;

    segments.addAll(uri.pathSegments.skip(1));
    return baseUri.replace(pathSegments: segments);        
  }

  Uri urlFor(String package, [String path]) {
    var baseUri = packageConfigMap[package];
    if (baseUri == null) return null;
    if (path == null) return baseUri;
    return baseUri.resolve(path);
  }

  Uri packageUriFor(url) {
    url = asUri(url, "url").toString();

    // Make sure isWithin works if [url] is exactly the base.
    var nested = p.url.join(url, "_");
    for (var package in packageConfigMap.keys) {
      var base = packageConfigMap[package].toString();
      if (!p.url.isWithin(base, nested)) continue;

      var relative = p.url.relative(url, from: base);
      if (relative == '.') relative = '';
      return Uri.parse("package:$package/$relative");
    }

    return null;
  }

  String packagePath(String package) {
    var lib = packageConfigMap[package];
    if (lib == null) return null;
    if (lib.scheme != 'file') return null;
    return p.dirname(p.fromUri(lib));
  }
}
