// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library package_config.discovery_test;

import "dart:async";
import "dart:io";
import "package:test/test.dart";
import "package:package_config/packages.dart";
import "package:package_config/discovery.dart";
import "package:path/path.dart" as path;

const packagesFile = """
# A comment
foo:file:///dart/packages/foo/
bar:http://example.com/dart/packages/bar/
baz:packages/baz/
""";

void validatePackagesFile(Packages resolver, Uri location) {
  expect(resolver, isNotNull);
  expect(resolver.resolve(pkg("foo", "bar/baz")),
      equals(Uri.parse("file:///dart/packages/foo/bar/baz")));
  expect(resolver.resolve(pkg("bar", "baz/qux")),
      equals(Uri.parse("http://example.com/dart/packages/bar/baz/qux")));
  expect(resolver.resolve(pkg("baz", "qux/foo")),
      equals(location.resolve("packages/baz/qux/foo")));
  expect(resolver.packages, unorderedEquals(["foo", "bar", "baz"]));
}

void validatePackagesDir(Packages resolver, Uri location) {
  // Expect three packages: foo, bar and baz
  expect(resolver, isNotNull);
  expect(resolver.resolve(pkg("foo", "bar/baz")),
      equals(location.resolve("packages/foo/bar/baz")));
  expect(resolver.resolve(pkg("bar", "baz/qux")),
      equals(location.resolve("packages/bar/baz/qux")));
  expect(resolver.resolve(pkg("baz", "qux/foo")),
      equals(location.resolve("packages/baz/qux/foo")));
  if (location.scheme == "file") {
    expect(resolver.packages, unorderedEquals(["foo", "bar", "baz"]));
  } else {
    expect(() => resolver.packages, throwsUnsupportedError);
  }
}

Uri pkg(String packageName, String packagePath) {
  var path;
  if (packagePath.startsWith('/')) {
    path = "$packageName$packagePath";
  } else {
    path = "$packageName/$packagePath";
  }
  return new Uri(scheme: "package", path: path);
}

main() {
  generalTest(".packages", {
    ".packages": packagesFile,
    "script.dart": "main(){}",
    "packages": {"shouldNotBeFound": {}}
  }, (Uri location) async {
    Packages resolver;
    resolver = await findPackages(location);
    validatePackagesFile(resolver, location);
    resolver = await findPackages(location.resolve("script.dart"));
    validatePackagesFile(resolver, location);
    var specificDiscovery = (location.scheme == "file")
        ? findPackagesFromFile
        : findPackagesFromNonFile;
    resolver = await specificDiscovery(location);
    validatePackagesFile(resolver, location);
    resolver = await specificDiscovery(location.resolve("script.dart"));
    validatePackagesFile(resolver, location);
  });

  generalTest("packages/", {
    "packages": {"foo": {}, "bar": {}, "baz": {}},
    "script.dart": "main(){}"
  }, (Uri location) async {
    Packages resolver;
    bool isFile = (location.scheme == "file");
    resolver = await findPackages(location);
    validatePackagesDir(resolver, location);
    resolver = await findPackages(location.resolve("script.dart"));
    validatePackagesDir(resolver, location);
    var specificDiscovery =
        isFile ? findPackagesFromFile : findPackagesFromNonFile;
    resolver = await specificDiscovery(location);
    validatePackagesDir(resolver, location);
    resolver = await specificDiscovery(location.resolve("script.dart"));
    validatePackagesDir(resolver, location);
  });

  generalTest("underscore packages", {
    "packages": {"_foo": {}}
  }, (Uri location) async {
    Packages resolver = await findPackages(location);
    expect(resolver.resolve(pkg("_foo", "foo.dart")),
        equals(location.resolve("packages/_foo/foo.dart")));
  });

  fileTest(".packages recursive", {
    ".packages": packagesFile,
    "subdir": {"script.dart": "main(){}"}
  }, (Uri location) async {
    Packages resolver;
    resolver = await findPackages(location.resolve("subdir/"));
    validatePackagesFile(resolver, location);
    resolver = await findPackages(location.resolve("subdir/script.dart"));
    validatePackagesFile(resolver, location);
    resolver = await findPackagesFromFile(location.resolve("subdir/"));
    validatePackagesFile(resolver, location);
    resolver =
        await findPackagesFromFile(location.resolve("subdir/script.dart"));
    validatePackagesFile(resolver, location);
  });

  httpTest(".packages not recursive", {
    ".packages": packagesFile,
    "subdir": {"script.dart": "main(){}"}
  }, (Uri location) async {
    Packages resolver;
    var subdir = location.resolve("subdir/");
    resolver = await findPackages(subdir);
    validatePackagesDir(resolver, subdir);
    resolver = await findPackages(subdir.resolve("script.dart"));
    validatePackagesDir(resolver, subdir);
    resolver = await findPackagesFromNonFile(subdir);
    validatePackagesDir(resolver, subdir);
    resolver = await findPackagesFromNonFile(subdir.resolve("script.dart"));
    validatePackagesDir(resolver, subdir);
  });

  fileTest("no packages", {"script.dart": "main(){}"}, (Uri location) async {
    // A file: location with no .packages or packages returns
    // Packages.noPackages.
    Packages resolver;
    resolver = await findPackages(location);
    expect(resolver, same(Packages.noPackages));
    resolver = await findPackages(location.resolve("script.dart"));
    expect(resolver, same(Packages.noPackages));
    resolver = findPackagesFromFile(location);
    expect(resolver, same(Packages.noPackages));
    resolver = findPackagesFromFile(location.resolve("script.dart"));
    expect(resolver, same(Packages.noPackages));
  });

  httpTest("no packages", {"script.dart": "main(){}"}, (Uri location) async {
    // A non-file: location with no .packages or packages/:
    // Assumes a packages dir exists, and resolves relative to that.
    Packages resolver;
    resolver = await findPackages(location);
    validatePackagesDir(resolver, location);
    resolver = await findPackages(location.resolve("script.dart"));
    validatePackagesDir(resolver, location);
    resolver = await findPackagesFromNonFile(location);
    validatePackagesDir(resolver, location);
    resolver = await findPackagesFromNonFile(location.resolve("script.dart"));
    validatePackagesDir(resolver, location);
  });

  test(".packages w/ loader", () async {
    Uri location = Uri.parse("krutch://example.com/path/");
    Future<List<int>> loader(Uri file) async {
      if (file.path.endsWith(".packages")) {
        return packagesFile.codeUnits;
      }
      throw "not found";
    }

    // A non-file: location with no .packages or packages/:
    // Assumes a packages dir exists, and resolves relative to that.
    Packages resolver;
    resolver = await findPackages(location, loader: loader);
    validatePackagesFile(resolver, location);
    resolver =
        await findPackages(location.resolve("script.dart"), loader: loader);
    validatePackagesFile(resolver, location);
    resolver = await findPackagesFromNonFile(location, loader: loader);
    validatePackagesFile(resolver, location);
    resolver = await findPackagesFromNonFile(location.resolve("script.dart"),
        loader: loader);
    validatePackagesFile(resolver, location);
  });

  test("no packages w/ loader", () async {
    Uri location = Uri.parse("krutch://example.com/path/");
    Future<List<int>> loader(Uri file) async {
      throw "not found";
    }

    // A non-file: location with no .packages or packages/:
    // Assumes a packages dir exists, and resolves relative to that.
    Packages resolver;
    resolver = await findPackages(location, loader: loader);
    validatePackagesDir(resolver, location);
    resolver =
        await findPackages(location.resolve("script.dart"), loader: loader);
    validatePackagesDir(resolver, location);
    resolver = await findPackagesFromNonFile(location, loader: loader);
    validatePackagesDir(resolver, location);
    resolver = await findPackagesFromNonFile(location.resolve("script.dart"),
        loader: loader);
    validatePackagesDir(resolver, location);
  });

  generalTest("loadPackagesFile", {".packages": packagesFile},
      (Uri directory) async {
    Uri file = directory.resolve(".packages");
    Packages resolver = await loadPackagesFile(file);
    validatePackagesFile(resolver, file);
  });

  generalTest(
      "loadPackagesFile non-default name", {"pheldagriff": packagesFile},
      (Uri directory) async {
    Uri file = directory.resolve("pheldagriff");
    Packages resolver = await loadPackagesFile(file);
    validatePackagesFile(resolver, file);
  });

  test("loadPackagesFile w/ loader", () async {
    Future<List<int>> loader(Uri uri) async => packagesFile.codeUnits;
    Uri file = Uri.parse("krutz://example.com/.packages");
    Packages resolver = await loadPackagesFile(file, loader: loader);
    validatePackagesFile(resolver, file);
  });

  generalTest("loadPackagesFile not found", {}, (Uri directory) async {
    Uri file = directory.resolve(".packages");
    expect(
        loadPackagesFile(file),
        throwsA(anyOf(new isInstanceOf<FileSystemException>(),
            new isInstanceOf<HttpException>())));
  });

  generalTest("loadPackagesFile syntax error", {".packages": "syntax error"},
      (Uri directory) async {
    Uri file = directory.resolve(".packages");
    expect(loadPackagesFile(file), throwsFormatException);
  });

  generalTest("getPackagesDir", {
    "packages": {"foo": {}, "bar": {}, "baz": {}}
  }, (Uri directory) async {
    Uri packages = directory.resolve("packages/");
    Packages resolver = getPackagesDirectory(packages);
    Uri resolved = resolver.resolve(pkg("foo", "flip/flop"));
    expect(resolved, packages.resolve("foo/flip/flop"));
  });
}

/// Create a directory structure from [description] and run [fileTest].
///
/// Description is a map, each key is a file entry. If the value is a map,
/// it's a sub-dir, otherwise it's a file and the value is the content
/// as a string.
void fileTest(String name, Map description, Future fileTest(Uri directory)) {
  group("file-test", () {
    Directory tempDir = Directory.systemTemp.createTempSync("file-test");
    setUp(() {
      _createFiles(tempDir, description);
    });
    tearDown(() {
      tempDir.deleteSync(recursive: true);
    });
    test(name, () => fileTest(new Uri.file(path.join(tempDir.path, "."))));
  });
}

/// HTTP-server the directory structure from [description] and run [htpTest].
///
/// Description is a map, each key is a file entry. If the value is a map,
/// it's a sub-dir, otherwise it's a file and the value is the content
/// as a string.
void httpTest(String name, Map description, Future httpTest(Uri directory)) {
  group("http-test", () {
    var serverSub;
    var uri;
    setUp(() {
      return HttpServer.bind(InternetAddress.LOOPBACK_IP_V4, 0).then((server) {
        uri = new Uri(
            scheme: "http", host: "127.0.0.1", port: server.port, path: "/");
        serverSub = server.listen((HttpRequest request) {
          // No error handling.
          var path = request.uri.path;
          if (path.startsWith('/')) path = path.substring(1);
          if (path.endsWith('/')) path = path.substring(0, path.length - 1);
          var parts = path.split('/');
          var fileOrDir = description;
          for (int i = 0; i < parts.length; i++) {
            fileOrDir = fileOrDir[parts[i]];
            if (fileOrDir == null) {
              request.response.statusCode = 404;
              request.response.close();
              return;
            }
          }
          request.response.write(fileOrDir);
          request.response.close();
        });
      });
    });
    tearDown(() => serverSub.cancel());
    test(name, () => httpTest(uri));
  });
}

void generalTest(String name, Map description, Future action(Uri location)) {
  fileTest(name, description, action);
  httpTest(name, description, action);
}

void _createFiles(Directory target, Map description) {
  description.forEach((name, content) {
    if (content is Map) {
      Directory subDir = new Directory(path.join(target.path, name));
      subDir.createSync();
      _createFiles(subDir, content);
    } else {
      File file = new File(path.join(target.path, name));
      file.writeAsStringSync(content, flush: true);
    }
  });
}
