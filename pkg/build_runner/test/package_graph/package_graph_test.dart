// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('vm')
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

import 'package:build_runner/build_runner.dart';

void main() {
  PackageGraph graph;

  group('PackageGraph', () {
    group('forThisPackage ', () {
      setUp(() async {
        graph = new PackageGraph.forThisPackage();
      });

      test('root', () {
        expectPkg(graph.root, 'build_runner', isNotEmpty,
            PackageDependencyType.path, './');
      });
    });

    group('basic package ', () {
      var basicPkgPath = 'test/fixtures/basic_pkg';

      setUp(() async {
        graph = new PackageGraph.forPath(basicPkgPath);
      });

      test('allPackages', () {
        expect(graph.allPackages, {
          'a': graph['a'],
          'b': graph['b'],
          'c': graph['c'],
          'd': graph['d'],
          'basic_pkg': graph['basic_pkg'],
        });
      });

      test('root', () {
        expectPkg(graph.root, 'basic_pkg', '1.0.0', PackageDependencyType.path,
            basicPkgPath, [graph['a'], graph['b'], graph['c'], graph['d']]);
      });

      test('pub dependency', () {
        expectPkg(graph['a'], 'a', '2.0.0', PackageDependencyType.pub,
            '$basicPkgPath/pkg/a', [graph['b'], graph['c']]);
      });

      test('git dependency', () {
        expectPkg(graph['b'], 'b', '3.0.0', PackageDependencyType.github,
            '$basicPkgPath/pkg/b', [graph['c']]);
      });

      test('path dependency', () {
        expectPkg(graph['c'], 'c', '4.0.0', PackageDependencyType.path,
            '$basicPkgPath/pkg/c', [graph['basic_pkg']]);
      });

      test('hosted dependency', () {
        expectPkg(graph['d'], 'd', '5.0.0', PackageDependencyType.hosted,
            '$basicPkgPath/pkg/d', [graph['c']]);
      });
    });

    group('package with dev dependencies', () {
      var withDevDepsPkgPath = 'test/fixtures/with_dev_deps';

      setUp(() async {
        graph = new PackageGraph.forPath(withDevDepsPkgPath);
      });

      test('allPackages contains dev deps of root pkg, but not others', () {
        // Package `c` is a dev dep of package `a` so it shouldn't be present
        // while package `b` is a dev dep of the root package so it should be.
        expect(graph.allPackages, {
          'a': graph['a'],
          'b': graph['b'],
          'with_dev_deps': graph['with_dev_deps'],
        });
      });

      test('dev deps are contained in deps of root pkg, but not others', () {
        // Package `b` shows as a dep because this is the root package.
        expectPkg(
            graph.root,
            'with_dev_deps',
            '1.0.0',
            PackageDependencyType.path,
            withDevDepsPkgPath,
            [graph['a'], graph['b']]);

        // Package `c` does not appear because this is not the root package.
        expectPkg(graph['a'], 'a', '2.0.0', PackageDependencyType.pub,
            '$withDevDepsPkgPath/pkg/a', []);

        expectPkg(graph['b'], 'b', '3.0.0', PackageDependencyType.pub,
            '$withDevDepsPkgPath/pkg/b', []);

        expect(graph['c'], isNull);
      });
    });

    group('package with flutter dependencies', () {
      var withFlutterDeps = 'test/fixtures/flutter_pkg';

      setUp(() async {
        graph = new PackageGraph.forPath(withFlutterDeps);
      });

      test('allPackages resolved correctly with all packages', () {
        expect(graph.allPackages.keys, [
          'flutter_gallery',
          'intl',
          'string_scanner',
          'flutter',
          'collection',
          'flutter_gallery_assets',
          'flutter_test',
          'flutter_driver',
        ]);
      });
    });

    test('custom creation via fromRoot', () {
      var a = new PackageNode('a', '1.0.0', PackageDependencyType.path, null);
      var b = new PackageNode('b', '1.0.0', PackageDependencyType.pub, null);
      var c = new PackageNode('c', '1.0.0', PackageDependencyType.pub, null);
      var d = new PackageNode('d', '1.0.0', PackageDependencyType.pub, null);
      a.dependencies.addAll([b, d]);
      b.dependencies.add(c);
      var graph = new PackageGraph.fromRoot(a);
      expect(graph.root, a);
      expect(graph.allPackages, {'a': a, 'b': b, 'c': c, 'd': d});
    });

    test('missing pubspec throws on create', () {
      expect(
          () => new PackageGraph.forPath(
              path.join('test', 'fixtures', 'no_pubspec')),
          throwsA(anything));
    });

    test('missing .packages file throws on create', () {
      expect(
          () => new PackageGraph.forPath(
              path.join('test', 'fixtures', 'no_packages_file')),
          throwsA(anything));
    });
  });
}

void expectPkg(PackageNode node, String name, dynamic version,
    PackageDependencyType type, String location,
    [Iterable<PackageNode> dependencies]) {
  expect(node.name, name);
  expect(node.version, version);
  expect(node.dependencyType, type);
  expect(node.location.path, location);
  if (dependencies != null) {
    expect(node.dependencies, unorderedEquals(dependencies));
  }
}
