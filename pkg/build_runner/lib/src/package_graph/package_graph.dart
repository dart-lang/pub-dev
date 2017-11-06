// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

/// A graph of the package dependencies for an application.
class PackageGraph {
  /// The root application package.
  final PackageNode root;

  /// All [PackageNode]s indexed by package name.
  final Map<String, PackageNode> allPackages;

  PackageGraph._(this.root, Map<String, PackageNode> allPackages)
      : allPackages = new Map.unmodifiable(allPackages);

  /// Creates a [PackageGraph] given the [root] [PackageNode].
  factory PackageGraph.fromRoot(PackageNode root) {
    final allPackages = <String, PackageNode>{root.name: root};

    void addDeps(PackageNode package) {
      for (var dep in package.dependencies) {
        if (allPackages.containsKey(dep.name)) continue;
        allPackages[dep.name] = dep;
        addDeps(dep);
      }
    }

    addDeps(root);

    return new PackageGraph._(root, allPackages);
  }

  /// Creates a [PackageGraph] for the package whose top level directory lives
  /// at [packagePath] (no trailing slash).
  factory PackageGraph.forPath(String packagePath) {
    /// Read in the pubspec file and parse it as yaml.
    var pubspec = new File(path.join(packagePath, 'pubspec.yaml'));
    if (!pubspec.existsSync()) {
      throw 'Unable to generate package graph, no `pubspec.yaml` found. '
          'This program must be ran from the root directory of your package.';
    }
    var rootYaml = loadYaml(pubspec.readAsStringSync()) as YamlMap;

    /// Read in the `.packages` file to get the locations of all packages.
    var packagesFile = new File(path.join(packagePath, '.packages'));
    if (!packagesFile.existsSync()) {
      throw 'Unable to generate package graph, no `.packages` found. '
          'This program must be ran from the root directory of your package.';
    }
    var packageLocations = <String, Uri>{};
    packagesFile.readAsLinesSync().skip(1).forEach((line) {
      var firstColon = line.indexOf(':');
      var name = line.substring(0, firstColon);
      assert(line.endsWith('lib/'));
      // Start after package_name:, and strip out trailing `lib` dir.
      var uriString = line.substring(firstColon + 1, line.length - 4);
      // Strip the trailing slash, if present.
      if (uriString.endsWith('/')) {
        uriString = uriString.substring(0, uriString.length - 1);
      }
      Uri uri;
      try {
        uri = Uri.parse(uriString);
      } on FormatException catch (_) {
        /// Some types of deps don't have a scheme, and just point to a relative
        /// path.
        uri = new Uri.file(uriString);
      }
      if (!uri.isAbsolute) {
        uri = new Uri.file(path.join(packagePath, uri.path));
      }
      packageLocations[name] = uri;
    });

    /// Create all [PackageNode]s for all deps.
    var nodes = <String, PackageNode>{};
    Map<String, dynamic> rootDeps;
    PackageNode addNodeAndDeps(YamlMap yaml, PackageDependencyType type,
        {bool isRoot: false}) {
      var name = yaml['name'] as String;
      assert(!nodes.containsKey(name));
      var node = new PackageNode(
          name, yaml['version'] as String, type, packageLocations[name]);
      nodes[name] = node;

      var deps = _depsFromYaml(yaml, isRoot: isRoot);
      if (isRoot) rootDeps = deps;
      deps.forEach((name, source) {
        var dep = nodes[name];
        if (dep == null) {
          var uri = packageLocations[name];
          if (uri == null) {
            throw 'No package found for $name.';
          }
          var pubspec = _pubspecForUri(uri);
          dep = addNodeAndDeps(pubspec, _dependencyType(rootDeps[name]));
        }
        node.dependencies.add(dep);
      });

      return node;
    }

    var root =
        addNodeAndDeps(rootYaml, PackageDependencyType.path, isRoot: true);
    return new PackageGraph._(root, nodes);
  }

  /// Creates a [PackageGraph] for the package in which you are currently
  /// running.
  factory PackageGraph.forThisPackage() => new PackageGraph.forPath('.');

  /// Shorthand to get a package by name.
  PackageNode operator [](String packageName) => allPackages[packageName];

  @override
  String toString() {
    var buffer = new StringBuffer();
    for (var package in allPackages.values) {
      buffer.writeln('$package');
    }
    return buffer.toString();
  }
}

/// A node in a [PackageGraph].
class PackageNode {
  /// The name of the package as listed in the pubspec.yaml
  final String name;

  /// The version of the package as listed in the pubspec.yaml
  final String version;

  /// The type of dependency being used to pull in this package.
  final PackageDependencyType dependencyType;

  /// All the packages that this package directly depends on.
  final List<PackageNode> dependencies = [];

  /// The location of the current version of this package.
  final Uri location;

  PackageNode(this.name, this.version, this.dependencyType, this.location);

  @override
  String toString() => '''
  $name:
    version: $version
    type: $dependencyType
    location: $location
    dependencies: [${dependencies.map((d) => d.name).join(', ')}]''';
}

/// The type of dependency being used. This dictates how the package should be
/// watched for changes.
enum PackageDependencyType { pub, github, path, hosted }

PackageDependencyType _dependencyType(source) {
  if (source is String || source == null) return PackageDependencyType.pub;

  assert(source is YamlMap);
  var map = source as YamlMap;

  for (var key in map.keys) {
    switch (key as String) {
      case 'git':
        return PackageDependencyType.github;
      case 'hosted':
        return PackageDependencyType.hosted;
      case 'path':
      case 'sdk': // Until Flutter supports another type, assume same as path.
        return PackageDependencyType.path;
    }
  }
  throw 'Unable to determine dependency type:\n$source';
}

/// Gets the deps from a yaml file, taking into account dependency_overrides.
Map<String, dynamic> _depsFromYaml(YamlMap yaml, {bool isRoot: false}) {
  var deps = new Map<String, dynamic>.from(yaml['dependencies'] as Map ?? {});
  if (isRoot) {
    deps.addAll(new Map.from(yaml['dev_dependencies'] as Map ?? {}));
    yaml['dependency_overrides']?.forEach((dep, source) {
      deps[dep as String] = source;
    });
  }
  return deps;
}

/// [uri] should point to the top level directory for the package.
YamlMap _pubspecForUri(Uri uri) {
  var pubspecPath = path.join(uri.toFilePath(), 'pubspec.yaml');
  var pubspec = new File(pubspecPath);
  if (!pubspec.existsSync()) {
    throw 'Unable to generate package graph, no `$pubspecPath` found.';
  }
  return loadYaml(pubspec.readAsStringSync()) as YamlMap;
}
