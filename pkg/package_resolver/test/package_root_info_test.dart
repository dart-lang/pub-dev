// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'package:package_resolver/package_resolver.dart';

void main() {
  var resolver;
  setUp(() {
    resolver = new SyncPackageResolver.root("file:///foo/bar");
  });

  group("constructor", () {
    test("with a URI object", () {
      var resolver =
          new SyncPackageResolver.root(Uri.parse("file:///foo/bar/"));
      expect(resolver.packageRoot, equals(Uri.parse("file:///foo/bar/")));
    });

    test("with a URI without a path component", () {
      var resolver =
          new SyncPackageResolver.root(Uri.parse("http://localhost:1234"));
      expect(resolver.packageRoot, equals(Uri.parse("http://localhost:1234/")));
    });

    test("with an invalid URI type", () {
      expect(() => new SyncPackageResolver.root(12), throwsArgumentError);
    });
  });

  test("exposes a null config map", () {
    expect(resolver.packageConfigMap, isNull);
  });

  test("exposes a null config URI", () {
    expect(resolver.packageConfigUri, isNull);
  });

  test("exposes the root root", () {
    expect(resolver.packageRoot, equals(Uri.parse("file:///foo/bar/")));
  });

  test("processArgument uses --package-root", () {
    expect(resolver.processArgument, equals("--package-root=file:///foo/bar/"));
  });

  group("resolveUri", () {
    test("with a package", () {
      expect(resolver.resolveUri("package:baz/bang/qux.dart"),
          equals(Uri.parse("file:///foo/bar/baz/bang/qux.dart")));
    });

    test("with a package with no path", () {
      expect(resolver.resolveUri("package:baz"), isNull);
    });

    test("with a package with an empty path", () {
      expect(resolver.resolveUri("package:baz/"),
          equals(Uri.parse("file:///foo/bar/baz/")));
    });

    test("with a URI object", () {
      expect(resolver.resolveUri(Uri.parse("package:baz/bang/qux.dart")),
          equals(Uri.parse("file:///foo/bar/baz/bang/qux.dart")));
    });

    test("with an invalid argument type", () {
      expect(() => resolver.resolveUri(12), throwsArgumentError);
    });

    test("with a non-package URI", () {
      expect(() => resolver.resolveUri("file:///zip/zap"),
          throwsFormatException);
    });

    test("with an invalid package URI", () {
      expect(() => resolver.resolveUri("package:"), throwsFormatException);
    });
  });

  group("urlFor", () {
    test("with no path", () {
      expect(resolver.urlFor("baz"), equals(Uri.parse("file:///foo/bar/baz/")));
    });

    test("with a path", () {
      expect(resolver.urlFor("baz", "bang/qux.dart"),
          equals(Uri.parse("file:///foo/bar/baz/bang/qux.dart")));
    });
  });

  group("packageUriFor", () {
    test("converts a matching URI to a package:", () {
      expect(resolver.packageUriFor("file:///foo/bar/bang/qux.dart"),
          equals(Uri.parse("package:bang/qux.dart")));
    });

    test("converts a matching URI with no path", () {
      expect(resolver.packageUriFor("file:///foo/bar/baz"),
          equals(Uri.parse("package:baz/")));
      expect(resolver.packageUriFor("file:///foo/bar/baz/"),
          equals(Uri.parse("package:baz/")));
    });

    test("with a URI object", () {
      expect(resolver.packageUriFor(Uri.parse("file:///foo/bar/bang/qux.dart")),
          equals(Uri.parse("package:bang/qux.dart")));
    });

    test("with an invalid argument type", () {
      expect(() => resolver.packageUriFor(12), throwsArgumentError);
    });
  });

  group("packagePath", () {
    var sandbox;
    setUp(() async {
      sandbox = (await Directory.systemTemp.createTemp("package_resolver_test"))
          .path;
    });

    tearDown(() async {
      await new Directory(sandbox).delete(recursive: true);
    });

    test("with a file: scheme", () async {
      var packageLib = p.join(sandbox, "foo/lib");
      await new Directory(packageLib).create(recursive: true);

      var packagesDir = p.join(sandbox, "packages");
      var fooLink = p.join(packagesDir, "foo");
      await new Link(fooLink).create(packageLib, recursive: true);

      var packagesLink = p.join(sandbox, "foo/packages");
      await new Link(packagesLink).create(packagesDir);

      var resolver = new SyncPackageResolver.root(p.toUri(packagesLink));

      expect(resolver.packagePath("foo"), equals(p.join(sandbox, "foo")));
      expect(resolver.packagePath("bar"), isNull);
    });

    test("without a file: scheme", () {
      var resolver = new SyncPackageResolver.root("http://dartlang.org/bar");
      expect(resolver.packagePath("foo"), isNull);
    });
  });
}
