// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:http/http.dart' as http;

import 'current_isolate_resolver.dart';
import 'package_config_resolver.dart';
import 'package_root_resolver.dart';
import 'sync_package_resolver.dart';

/// A class that defines how to resolve `package:` URIs.
///
/// This includes the information necessary to resolve `package:` URIs using
/// either a package config or a package root. It can be used both as a standard
/// cross-package representation of the user's configuration, and as a means of
/// concretely locating packages and the assets they contain.
///
/// Unlike [SyncPackageResolver], this does not provide synchronous APIs. This
/// is necessary when dealing with the current Isolate's package resolution
/// strategy.
///
/// This class should not be implemented by user code.
abstract class PackageResolver {
  /// The map contained in the parsed package config.
  ///
  /// This maps package names to the base URIs for those packages. These are
  /// already resolved relative to [packageConfigUri], so if they're relative
  /// they should be considered relative to [Uri.base].
  ///
  /// [urlFor] should generally be used rather than looking up package URLs in
  /// this map, to ensure that code works with a package root as well as a
  /// package config.
  ///
  /// Note that for some implementations, loading the map may require IO
  /// operations that could fail.
  ///
  /// Completes to `null` when using a [packageRoot] for resolution, or when no
  /// package resolution is being used.
  Future<Map<String, Uri>> get packageConfigMap;

  /// The URI for the package config.
  ///
  /// This is the URI from which [packageConfigMap] was parsed, if that's
  /// available. Otherwise, it's a `data:` URI containing a serialized
  /// representation of [packageConfigMap]. This `data:` URI should be accepted
  /// by all Dart tools.
  ///
  /// Note that if this is a `data:` URI, it may not be safe to pass as a
  /// parameter to a Dart process due to length limits.
  ///
  /// Completes to `null` when using a [packageRoot] for resolution, or when no
  /// package resolution is being used.
  Future<Uri> get packageConfigUri;

  /// The base URL for resolving `package:` URLs.
  ///
  /// Completes to `null` when using a [packageConfigMap] for resolution, or
  /// when no package resolution is being used.
  Future<Uri> get packageRoot;

  /// Fetches the package resolution for [this] and returns an object that
  /// provides synchronous access.
  ///
  /// This may throw exceptions if loading or parsing the package map fails.
  Future<SyncPackageResolver> get asSync;

  /// Returns the argument to pass to a subprocess to get it to use this package
  /// resolution strategy when resolving `package:` URIs.
  ///
  /// This uses the `--package-root` or `--package` flags, which are the
  /// conventions supported by the Dart VM and dart2js.
  ///
  /// Note that if [packageConfigUri] is a `data:` URI, it may be too large to
  /// pass on the command line.
  ///
  /// Returns `null` if no package resolution is in use.
  Future<String> get processArgument;

  /// Returns package resolution strategy describing how the current isolate
  /// resolves `package:` URIs.
  static final PackageResolver current = new CurrentIsolateResolver();

  /// Returns a package resolution strategy that is unable to resolve any
  /// `package:` URIs.
  static final PackageResolver none = SyncPackageResolver.none.asAsync;

  /// Loads a package config file from [uri] and returns its package resolution
  /// strategy.
  ///
  /// This supports `file:`, `http:`, `data:` and `package:` URIs. It throws an
  /// [UnsupportedError] for any other schemes. If [client] is passed and an
  /// HTTP request is needed, it's used to make that request; otherwise, a
  /// default client is used.
  ///
  /// [uri] may be a [String] or a [Uri].
  static Future<PackageResolver> loadConfig(uri, {http.Client client}) async {
    var resolver = await SyncPackageResolver.loadConfig(uri, client: client);
    return resolver.asAsync;
  }

  /// Returns the package resolution strategy for the given [packageConfigMap].
  ///
  /// If passed, [uri] specifies the URI from which [packageConfigMap] was
  /// loaded. It may be a [String] or a [Uri].
  ///
  /// Whether or not [uri] is passed, [packageConfigMap] is expected to be
  /// fully-resolved. That is, any relative URIs in the original package config
  /// source should be resolved relative to its location.
  factory PackageResolver.config(Map<String, Uri> packageConfigMap, {uri}) =>
      new PackageConfigResolver(packageConfigMap, uri: uri).asAsync;

  /// Returns the package resolution strategy for the given [packageRoot], which
  /// may be a [String] or a [Uri].
  factory PackageResolver.root(packageRoot) =>
      new PackageRootResolver(packageRoot).asAsync;

  /// Resolves [packageUri] according to this package resolution strategy.
  ///
  /// [packageUri] may be a [String] or a [Uri]. This throws a [FormatException]
  /// if [packageUri] isn't a `package:` URI or doesn't have at least one path
  /// segment.
  ///
  /// If [packageUri] refers to a package that's not in the package spec, this
  /// returns `null`.
  Future<Uri> resolveUri(packageUri);

  /// Returns the resolved URL for [package] and [path].
  ///
  /// This is equivalent to `resolveUri("package:$package/")` or
  /// `resolveUri("package:$package/$path")`, depending on whether [path] was
  /// passed.
  ///
  /// If [package] refers to a package that's not in the package spec, this
  /// returns `null`.
  Future<Uri> urlFor(String package, [String path]);

  /// Returns the `package:` URI for [uri].
  ///
  /// If [uri] can't be referred to using a `package:` URI, returns `null`.
  ///
  /// [uri] may be a [String] or a [Uri].
  Future<Uri> packageUriFor(uri);

  /// Returns the path on the local filesystem to the root of [package], or
  /// `null` if the root cannot be found.
  ///
  /// **Note**: this assumes a pub-style package layout. In particular:
  ///
  /// * If a package root is being used, this assumes that it contains symlinks
  ///   to packages' lib/ directories.
  ///
  /// * If a package config is being used, this assumes that each entry points
  ///   to a package's lib/ directory.
  ///
  /// Returns `null` if the package root is not a `file:` URI, or if the package
  /// config entry for [package] is not a `file:` URI.
  Future<String> packagePath(String package);
}
