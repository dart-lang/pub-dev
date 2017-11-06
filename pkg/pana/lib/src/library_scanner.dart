// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/file_system/file_system.dart' hide File;
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer/source/package_map_resolver.dart';
import 'package:analyzer/source/pub_package_map_provider.dart';
import 'package:analyzer/src/dart/sdk/sdk.dart' show FolderBasedDartSdk;
import 'package:analyzer/src/generated/engine.dart';
import 'package:analyzer/src/generated/java_io.dart';
import 'package:analyzer/src/generated/source.dart';
import 'package:analyzer/src/generated/source_io.dart';
import 'package:path/path.dart' as p;

import 'logging.dart';
import 'sdk_env.dart';
import 'utils.dart';

class LibraryOverride {
  final String uri;
  final String dependency;
  final String overrideTo;

  LibraryOverride(this.uri, this.dependency, this.overrideTo);
  LibraryOverride.webSafeIO(this.uri)
      : dependency = 'dart:io',
        overrideTo = 'dart-pana:web_safe_io';
}

class LibraryScanner {
  final String packageName;
  final String _packagePath;
  final UriResolver _packageResolver;
  final AnalysisContext _context;
  final List<LibraryOverride> _overrides;
  final _cachedLibs = new HashMap<String, List<String>>();
  final _cachedTransitiveLibs = new HashMap<String, List<String>>();

  LibraryScanner._(this.packageName, this._packagePath, this._packageResolver,
      this._context, this._overrides);

  factory LibraryScanner(
      PubEnvironment pubEnv, String packagePath, bool useFlutter,
      {List<LibraryOverride> overrides}) {
    // TODO: fail more clearly if this...fails
    var sdkPath = pubEnv.dartSdk.sdkDir;

    var resourceProvider = PhysicalResourceProvider.INSTANCE;
    var sdk = new FolderBasedDartSdk(
        resourceProvider, resourceProvider.getFolder(sdkPath));

    var dotPackagesPath = p.join(packagePath, '.packages');
    if (!FileSystemEntity.isFileSync(dotPackagesPath)) {
      throw new StateError('A package configuration file was not found at the '
          'expectetd location.\n$dotPackagesPath');
    }

    // TODO: figure out why non-flutter pub list doesn't work the same way as the default
    RunPubList runPubList;
    if (useFlutter) {
      runPubList = (Folder folder) =>
          pubEnv.listPackageDirsSync(folder.path, useFlutter);
    }

    var pubPackageMapProvider = new PubPackageMapProvider(
        PhysicalResourceProvider.INSTANCE, sdk, runPubList);
    var packageMapInfo = pubPackageMapProvider.computePackageMap(
        PhysicalResourceProvider.INSTANCE.getResource(packagePath) as Folder);

    var packageMap = packageMapInfo.packageMap;
    if (packageMap == null) {
      throw new StateError('An error occurred getting the package map '
          'for the file at `$dotPackagesPath`.');
    }

    String package;
    var packageNames = <String>[];
    packageMap.forEach((k, v) {
      if (package != null) {
        return;
      }

      assert(package == null);

      // if there is an exact match to the lib directory, use that
      if (v.any((f) => p.equals(p.join(packagePath, 'lib'), f.path))) {
        package = k;
        return;
      }

      if (v.any((f) => p.isWithin(packagePath, f.path))) {
        packageNames.add(k);
      }
    });

    if (package == null) {
      if (packageNames.length == 1) {
        package = packageNames.single;
        log.warning("Weird: `$package` at `${packageMap[package]}`.");
      } else {
        throw new StateError(
            "Could not determine package name for package at `$packagePath` "
            "- found ${packageNames.toSet().join(', ')}");
      }
    }

    UriResolver packageResolver = new PackageMapUriResolver(
        PhysicalResourceProvider.INSTANCE, packageMap);

    var resolvers = [
      new DartUriResolver(sdk),
      new ResourceUriResolver(PhysicalResourceProvider.INSTANCE),
      packageResolver,
    ];

    AnalysisEngine.instance.processRequiredPlugins();

    var options = new AnalysisOptionsImpl()..analyzeFunctionBodies = false;

    var context = AnalysisEngine.instance.createAnalysisContext()
      ..analysisOptions = options
      ..sourceFactory = new SourceFactory(resolvers);

    return new LibraryScanner._(
        package, packagePath, packageResolver, context, overrides);
  }

  Future<Map<String, List<String>>> scanDirectLibs() => _scanPackage();

  Future<Map<String, List<String>>> scanTransitiveLibs() async {
    var results = new SplayTreeMap<String, List<String>>();
    var direct = await _scanPackage();
    for (var key in direct.keys) {
      results[key] = await _scanTransitiveLibs(key, [key]);
    }
    return results;
  }

  Future<List<String>> _scanTransitiveLibs(
      String uri, List<String> stack) async {
    if (!_cachedTransitiveLibs.containsKey(uri)) {
      final processed = new Set<String>();
      final todo = new Set<String>.from([uri]);
      while (todo.isNotEmpty) {
        final lib = todo.first;
        todo.remove(lib);
        if (processed.contains(lib)) continue;
        processed.add(lib);
        if (!lib.startsWith('package:')) {
          // nothing to do
          continue;
        }
        // short-circuit when re-entrant call is detected
        if (stack.contains(lib)) {
          todo.addAll(await _scanUri(lib));
        } else {
          final newStack = new List<String>.from(stack)..add(lib);
          processed.addAll(await _scanTransitiveLibs(lib, newStack));
        }
      }
      _applyOverrides(uri, processed);
      processed.remove(uri);
      _cachedTransitiveLibs[uri] = processed.toList()..sort();
    }
    return _cachedTransitiveLibs[uri];
  }

  /// [AnalysisEngine] caches analyzed fragments, and we need to clear those
  /// after we have analyzed a package.
  void clearCaches() {
    AnalysisEngine.instance.clearCaches();
  }

  Future<Map<String, List<String>>> scanDependencyGraph() async {
    var items = await scanTransitiveLibs();

    var graph = new SplayTreeMap<String, List<String>>();

    var todo = new LinkedHashSet<String>.from(items.keys);
    while (todo.isNotEmpty) {
      var first = todo.first;
      todo.remove(first);

      if (first.startsWith('dart:')) {
        continue;
      }

      graph.putIfAbsent(first, () {
        var cache = _cachedLibs[first];
        todo.addAll(cache);
        return cache;
      });
    }

    return graph;
  }

  Future<List<String>> _scanUri(String libUri) async {
    if (_cachedLibs.containsKey(libUri)) {
      return _cachedLibs[libUri];
    }
    var uri = Uri.parse(libUri);
    var package = uri.pathSegments.first;

    var source = _packageResolver.resolveAbsolute(uri);
    if (source == null) {
      throw "Could not resolve package URI for $uri";
    }

    var fullPath = source.fullName;
    var relativePath = p.join('lib', libUri.substring(libUri.indexOf('/') + 1));
    if (fullPath.endsWith('/$relativePath')) {
      var packageDir =
          fullPath.substring(0, fullPath.length - relativePath.length - 1);
      var libs = _parseLibs(package, packageDir, relativePath);
      _cachedLibs[libUri] = libs;
      return libs;
    } else {
      return [];
    }
  }

  Future<Map<String, List<String>>> _scanPackage() async {
    var results = new SplayTreeMap<String, List<String>>();
    await for (var relativePath
        in listFiles(_packagePath, endsWith: '.dart').where((path) {
      if (p.isWithin('bin', path)) {
        return true;
      }

      // Include all Dart files in lib – except for implementation files.
      if (p.isWithin('lib', path) && !p.isWithin('lib/src', path)) {
        return true;
      }

      return false;
    })) {
      var uri = toPackageUri(packageName, relativePath);
      results[uri] = _cachedLibs.putIfAbsent(
          uri, () => _parseLibs(packageName, _packagePath, relativePath));
    }
    return results;
  }

  List<String> _parseLibs(
      String package, String packageDir, String relativePath) {
    var fullPath = p.join(packageDir, relativePath);
    var lib = _getLibraryElement(fullPath);
    if (lib == null) return [];
    var refs = new SplayTreeSet<String>();
    lib.importedLibraries.forEach((le) {
      refs.add(_normalizeLibRef(le.librarySource.uri, package, packageDir));
    });
    lib.exportedLibraries.forEach((le) {
      refs.add(_normalizeLibRef(le.librarySource.uri, package, packageDir));
    });

    var pkgUri = toPackageUri(package, relativePath);
    _applyOverrides(pkgUri, refs);

    refs.remove('dart:core');
    return new List<String>.unmodifiable(refs);
  }

  void _applyOverrides(String pkgUri, Set<String> set) {
    if (_overrides != null) {
      for (var override in _overrides) {
        if (override.uri == pkgUri) {
          if (set.remove(override.dependency) && override.overrideTo != null) {
            set.add(override.overrideTo);
          }
        }
      }
    }
  }

  LibraryElement _getLibraryElement(String path) {
    Source source = new FileBasedSource(new JavaFile(path));
    if (_context.computeKindOf(source) == SourceKind.LIBRARY) {
      return _context.computeLibraryElement(source);
    }
    return null;
  }
}

String _normalizeLibRef(Uri uri, String package, String packageDir) {
  if (uri.isScheme('file')) {
    var relativePath = p.relative(p.fromUri(uri), from: packageDir);
    return toPackageUri(package, relativePath);
  } else if (uri.isScheme('package') || uri.isScheme('dart')) {
    return uri.toString();
  }

  throw "not supported - $uri";
}
