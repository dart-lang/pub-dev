// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'package:path/path.dart' as p;

/// Identifies an asset within a package.
class AssetId implements Comparable<AssetId> {
  /// The name of the package containing this asset.
  final String package;

  /// The path to the asset relative to the root directory of [package].
  ///
  /// Source (i.e. read from disk) and generated (i.e. the output of a
  /// `Builder`) assets all have paths. Even intermediate assets that are
  /// generated and then consumed by later transformations will still have a
  /// path used to identify it.
  ///
  /// Asset paths always use forward slashes as path separators, regardless of
  /// the host platform.
  final String path;

  /// The file extension of the asset, if it has one, including the ".".
  String get extension => p.extension(path);

  /// Creates a new [AssetId] at [path] within [package].
  ///
  /// The [path] will be normalized: any backslashes will be replaced with
  /// forward slashes (regardless of host OS) and "." and ".." will be removed
  /// where possible.
  AssetId(this.package, String path) : path = _normalizePath(path);

  /// Creates a new [AssetId] from an [uri] String.
  ///
  /// This gracefully handles `package:` or `asset:` URIs.
  ///
  /// Resolve a `package:` URI when creating an [AssetId] from an `import` or
  /// `export` directive pointing to a package's _lib_ directory:
  /// ```dart
  /// AssetId assetOfDirective(UriReferencedElement element) {
  ///   return new AssetId.resolve(element.uri);
  /// }
  /// ```
  ///
  /// When resolving a relative URI with no scheme, specifyg the origin asset
  /// ([from]) - otherwise an [ArgumentError] will be thrown.
  /// ```dart
  /// AssetId assetOfDirective(AssetId origin, UriReferencedElement element) {
  ///   return new AssetId.resolve(element.uri, from: origin);
  /// }
  /// ```
  ///
  /// `asset:` uris have the format '$package/$path', including the top level
  /// directory.
  factory AssetId.resolve(String uri, {AssetId from}) {
    final parsedUri = Uri.parse(uri);
    if (parsedUri.hasScheme) {
      if (parsedUri.scheme == 'package') {
        return new AssetId(parsedUri.pathSegments.first,
            p.join('lib', p.joinAll(parsedUri.pathSegments.skip(1))));
      } else if (parsedUri.scheme == 'asset') {
        return new AssetId(parsedUri.pathSegments.first,
            p.joinAll(parsedUri.pathSegments.skip(1)));
      }
      throw new UnsupportedError(
          'Cannot resolve $uri; only "package" and "asset" schemes supported');
    }
    if (from == null) {
      throw new ArgumentError.value(from, 'from',
          'An AssetId "from" must be specified to resolve a relative URI');
    }
    return new AssetId(
        p.normalize(from.package), p.join(p.dirname(from.path), uri));
  }

  /// Parses an [AssetId] string of the form "package|path/to/asset.txt".
  ///
  /// The [path] will be normalized: any backslashes will be replaced with
  /// forward slashes (regardless of host OS) and "." and ".." will be removed
  /// where possible.
  factory AssetId.parse(String description) {
    var parts = description.split("|");
    if (parts.length != 2) {
      throw new FormatException('Could not parse "$description".');
    }

    if (parts[0].isEmpty) {
      throw new FormatException(
          'Cannot have empty package name in "$description".');
    }

    if (parts[1].isEmpty) {
      throw new FormatException('Cannot have empty path in "$description".');
    }

    return new AssetId(parts[0], parts[1]);
  }

  /// A `package:` URI suitable for use directly with other systems if this
  /// asset is under it's package's `lib/` directory, else an `asset:` URI
  /// suitable for use within build tools.
  Uri get uri => _uri ??= path.startsWith('lib/')
      ? new Uri(
          scheme: 'package', path: '$package/${path.replaceFirst('lib/','')}')
      : new Uri(scheme: 'asset', path: '$package/$path');
  Uri _uri;

  /// Deserializes an [AssetId] from [data], which must be the result of
  /// calling [serialize] on an existing [AssetId].
  AssetId.deserialize(List data)
      : package = data[0] as String,
        path = data[1] as String;

  /// Returns `true` if [other] is an [AssetId] with the same package and path.
  @override
  bool operator ==(Object other) =>
      other is AssetId && package == other.package && path == other.path;

  @override
  int get hashCode => package.hashCode ^ path.hashCode;

  @override
  int compareTo(AssetId other) {
    var packageComp = package.compareTo(other.package);
    if (packageComp != 0) return packageComp;
    return path.compareTo(other.path);
  }

  /// Returns a new [AssetId] with the same [package] as this one and with the
  /// [path] extended to include [extension].
  AssetId addExtension(String extension) =>
      new AssetId(package, "$path$extension");

  /// Returns a new [AssetId] with the same [package] and [path] as this one
  /// but with file extension [newExtension].
  AssetId changeExtension(String newExtension) =>
      new AssetId(package, p.withoutExtension(path) + newExtension);

  @override
  String toString() => "$package|$path";

  /// Serializes this [AssetId] to an object that can be sent across isolates
  /// and passed to [AssetId.deserialize].
  Object serialize() => [package, path];
}

String _normalizePath(String path) {
  if (p.isAbsolute(path)) {
    throw new ArgumentError('Asset paths must be relative, but got "$path".');
  }

  // Normalize path separators so that they are always "/" in the AssetID.
  path = path.replaceAll(r"\", "/");

  // Collapse "." and "..".
  return p.posix.normalize(path);
}
