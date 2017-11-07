// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:test/test.dart';

import 'package:package_resolver/package_resolver.dart';

void main() {
  var resolver;
  setUp(() {
    resolver = new SyncPackageResolver.config({
      "foo": Uri.parse("file:///foo/bar/"),
      "bar": Uri.parse("http://dartlang.org/bar")
    }, uri: "file:///myapp/.packages");
  });

  group("constructor", () {
    test("with a URI object", () {
      var resolver = new SyncPackageResolver.config({},
          uri: Uri.parse("file:///myapp/.packages"));
      expect(resolver.packageConfigUri,
          equals(Uri.parse("file:///myapp/.packages")));
    });

    test("with an invalid URI type", () {
      expect(() => new SyncPackageResolver.config({}, uri: 12),
          throwsArgumentError);
    });
  });

  test("exposes the config map", () {
    expect(resolver.packageConfigMap, equals({
      "foo": Uri.parse("file:///foo/bar/"),
      "bar": Uri.parse("http://dartlang.org/bar/")
    }));
  });

  test("exposes the config URI if passed", () {
    expect(resolver.packageConfigUri,
        equals(Uri.parse("file:///myapp/.packages")));
  });

  test("exposes a data: config URI if none is passed", () {
    resolver = new SyncPackageResolver.config(resolver.packageConfigMap);
    expect(resolver.packageConfigUri, equals(Uri.parse(
        "data:;charset=utf-8,"
        "foo:file:///foo/bar/%0A"
        "bar:http://dartlang.org/bar/%0A")));
  });

  test("exposes a null root", () {
    expect(resolver.packageRoot, isNull);
  });

  test("processArgument uses --packages", () {
    expect(resolver.processArgument,
        equals("--packages=file:///myapp/.packages"));
  });

  group("resolveUri", () {
    test("with a matching package", () {
      expect(resolver.resolveUri("package:foo/bang/qux.dart"),
          equals(Uri.parse("file:///foo/bar/bang/qux.dart")));
      expect(resolver.resolveUri("package:bar/bang/qux.dart"),
          equals(Uri.parse("http://dartlang.org/bar/bang/qux.dart")));
    });

    test("with a matching package with no path", () {
      expect(resolver.resolveUri("package:foo"), isNull);
    });

    test("with a matching package with an empty path", () {
      expect(resolver.resolveUri("package:bar/"),
          equals(Uri.parse("http://dartlang.org/bar/")));
    });

    test("with a URI object", () {
      expect(resolver.resolveUri(Uri.parse("package:foo/bang/qux.dart")),
          equals(Uri.parse("file:///foo/bar/bang/qux.dart")));
    });

    test("with a non-matching package", () {
      expect(resolver.resolveUri("package:zap/bang/qux.dart"), isNull);
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
    test("with a matching package and no path", () {
      expect(resolver.urlFor("foo"), equals(Uri.parse("file:///foo/bar/")));
      expect(resolver.urlFor("bar"),
          equals(Uri.parse("http://dartlang.org/bar/")));
    });

    test("with a matching package and a path", () {
      expect(resolver.urlFor("foo", "bang/qux.dart"),
          equals(Uri.parse("file:///foo/bar/bang/qux.dart")));
      expect(resolver.urlFor("bar", "bang/qux.dart"),
          equals(Uri.parse("http://dartlang.org/bar/bang/qux.dart")));
    });

    test("with a non-matching package and no path", () {
      expect(resolver.urlFor("zap"), isNull);
    });
  });

  group("packageUriFor", () {
    test("converts matching URIs to package:", () {
      expect(resolver.packageUriFor("file:///foo/bar/bang/qux.dart"),
          equals(Uri.parse("package:foo/bang/qux.dart")));
      expect(resolver.packageUriFor("http://dartlang.org/bar/bang/qux.dart"),
          equals(Uri.parse("package:bar/bang/qux.dart")));
    });

    test("converts URIs with no paths", () {
      expect(resolver.packageUriFor("file:///foo/bar"),
          equals(Uri.parse("package:foo/")));
      expect(resolver.packageUriFor("http://dartlang.org/bar/"),
          equals(Uri.parse("package:bar/")));
    });

    test("with a URI object", () {
      expect(resolver.packageUriFor(Uri.parse("file:///foo/bar/bang/qux.dart")),
          equals(Uri.parse("package:foo/bang/qux.dart")));
    });

    test("with an invalid argument type", () {
      expect(() => resolver.packageUriFor(12), throwsArgumentError);
    });
  });

  group("packagePath", () {
    setUp(() {
      resolver = new SyncPackageResolver.config({
        "foo": p.toUri(p.join(p.current, 'lib')),
        "bar": Uri.parse("http://dartlang.org/bar")
      });
    });

    test("with a matching package", () {
      expect(resolver.packagePath("foo"), equals(p.current));
    });

    test("with a package with a non-file scheme", () {
      expect(resolver.packagePath("bar"), isNull);
    });

    test("with a non-matching", () {
      expect(resolver.packagePath("baz"), isNull);
    });
  });

  group("loadConfig", () {
    var server;
    var sandbox;
    setUp(() async {
      sandbox = (await Directory.systemTemp.createTemp("package_resolver_test"))
          .path;
    });

    tearDown(() async {
      if (server != null) await server.close();
      await new Directory(sandbox).delete(recursive: true);
    });

    test("with an http: URI", () async {
      server = await shelf_io.serve((request) {
        return new shelf.Response.ok(
            "foo:file:///foo/bar/\n"
            "bar:http://dartlang.org/bar/");
      }, 'localhost', 0);

      var resolver = await SyncPackageResolver.loadConfig(
          "http://localhost:${server.port}");

      expect(resolver.packageConfigMap, equals({
        "foo": Uri.parse("file:///foo/bar/"),
        "bar": Uri.parse("http://dartlang.org/bar/")
      }));
      expect(resolver.packageConfigUri,
          equals(Uri.parse("http://localhost:${server.port}")));
    });

    test("with a file: URI", () async {
      var packagesPath = p.join(sandbox, ".packages");
      new File(packagesPath).writeAsStringSync(
          "foo:file:///foo/bar/\n"
          "bar:http://dartlang.org/bar/");

      var resolver =
          await SyncPackageResolver.loadConfig(p.toUri(packagesPath));

      expect(resolver.packageConfigMap, equals({
        "foo": Uri.parse("file:///foo/bar/"),
        "bar": Uri.parse("http://dartlang.org/bar/")
      }));
      expect(resolver.packageConfigUri, equals(p.toUri(packagesPath)));
    });

    test("with a data: URI", () async {
      var data = Uri.parse(
          "data:;charset=utf-8,"
          "foo:file:///foo/bar/%0A"
          "bar:http://dartlang.org/bar/%0A");
      var resolver = await SyncPackageResolver.loadConfig(data);

      expect(resolver.packageConfigMap, equals({
        "foo": Uri.parse("file:///foo/bar/"),
        "bar": Uri.parse("http://dartlang.org/bar/")
      }));
      expect(resolver.packageConfigUri, equals(data));
    });

    test("with a package: URI", () async {
      var resolver = await SyncPackageResolver.loadConfig(
          "package:package_resolver/src/test_package_config");

      expect(resolver.packageConfigMap, equals({
        "foo": Uri.parse("file:///foo/bar/"),
        "bar": Uri.parse("http://dartlang.org/bar/")
      }));
      expect(resolver.packageConfigUri, equals(Uri.parse(
          "package:package_resolver/src/test_package_config")));
    });

    test("with an unsupported scheme", () {
      expect(SyncPackageResolver.loadConfig("asdf:foo/bar"),
          throwsUnsupportedError);
    });
  });
}
