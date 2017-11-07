// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:path/path.dart' as p;
import 'package:stack_trace/stack_trace.dart';
import 'package:test/test.dart';

import 'package:package_resolver/package_resolver.dart';
import 'package:package_resolver/src/utils.dart';

void main() {
  // It's important to test these, because they use PackageConfig.current and
  // they're used to verify the output of the inner isolate's
  // PackageConfig.current.
  test("_packageResolverLibUri is correct", () async {
    var libPath = p.fromUri(await _packageResolverLibUri);
    expect(new File(p.join(libPath, 'package_resolver.dart')).exists(),
        completion(isTrue));
  });

  test("_pathLibUri is correct", () async {
    var libPath = p.fromUri(await _pathLibUri);
    expect(new File(p.join(libPath, 'path.dart')).exists(), completion(isTrue));
  });

  group("with a package config", () {
    var resolver;
    setUp(() async {
      var map;
      var currentIsolateMap = await PackageResolver.current.packageConfigMap;
      if (currentIsolateMap != null) {
        map = new Map.from(currentIsolateMap);
      } else {
        // If the isolate running this test isn't using package config, create
        // one from scratch with the same resolution semantics.
        map = {};
        var root = p.fromUri(await PackageResolver.current.packageRoot);
        await for (var link in new Directory(root).list(followLinks: false)) {
          assert(link is Link);
          map[p.basename(link.path)] =
              ensureTrailingSlash(p.toUri((await link.resolveSymbolicLinks())));
        }
      }

      // Ensure that we have at least one URI that ends with "/" and one that
      // doesn't. Both of these cases need to be tested.
      expect(map["package_resolver"].path, endsWith("/"));
      map["path"] = Uri.parse(p.url.normalize(map["path"].toString()));
      expect(map["path"].path, isNot(endsWith("/")));

      resolver = new PackageResolver.config(map);
    });

    test("exposes the config map", () async {
      expect(await _spawn("""() async {
        var serializable = {};
        (await PackageResolver.current.packageConfigMap)
            .forEach((package, uri) {
          serializable[package] = uri.toString();
        });
        return serializable;
      }()""", resolver),
          containsPair("package_resolver", await _packageResolverLibUri));
    });

    test("exposes the config URI", () async {
      expect(
          await _spawn(
              "(await PackageResolver.current.packageConfigUri).toString()",
              resolver),
          equals((await resolver.packageConfigUri).toString()));
    });

    test("exposes a null package root", () async {
      expect(
          // Use "== null" because if it *is* a URI, it'll crash the isolate
          // when we try to send it over the port.
          await _spawn(
              "(await PackageResolver.current.packageRoot) == null", resolver),
          isTrue);
    });

    test("processArgument uses --packages", () async {
      expect(
          await _spawn("PackageResolver.current.processArgument", resolver),
          equals(await resolver.processArgument));
    });

    group("resolveUri", () {
      test("with a matching package", () async {
        expect(await _spawn("""() async {
          var uri = await PackageResolver.current.resolveUri(
              'package:package_resolver/foo/bar.dart');
          return uri.toString();
        }()""", resolver),
            equals(p.url.join(await _packageResolverLibUri, "foo/bar.dart")));

        expect(await _spawn("""() async {
          var uri = await PackageResolver.current.resolveUri(
              'package:path/foo/bar.dart');
          return uri.toString();
        }()""", resolver),
            equals(p.url.join(await _pathLibUri, "foo/bar.dart")));
      });

      test("with a matching package with no path", () async {
        expect(await _spawn("""() async {
          var uri = await PackageResolver.current.resolveUri(
              'package:package_resolver');
          return uri == null;
        }()""", resolver), isTrue);

        expect(await _spawn("""() async {
          var uri = await PackageResolver.current.resolveUri('package:path');
          return uri == null;
        }()""", resolver), isTrue);
      });

      test("with a matching package with an empty path",
          () async {
        expect(await _spawn("""() async {
          var uri = await PackageResolver.current.resolveUri(
              'package:package_resolver/');
          return uri.toString();
        }()""", resolver), (await _packageResolverLibUri).toString());

        expect(await _spawn("""() async {
          var uri = await PackageResolver.current.resolveUri('package:path/');
          return uri.toString();
        }()""", resolver), (await _pathLibUri).toString());
      });

      test("with a URI object", () async {
        expect(await _spawn("""() async {
          var uri = await PackageResolver.current.resolveUri(
              Uri.parse('package:package_resolver/foo/bar.dart'));
          return uri.toString();
        }()""", resolver),
            equals(p.url.join(await _packageResolverLibUri, 'foo/bar.dart')));
      });

      test("with a non-matching package", () async {
        expect(await _spawn("""() async {
          var uri = await PackageResolver.current.resolveUri(
              Uri.parse('package:not-a-package/foo/bar.dart'));
          return uri == null;
        }()""", resolver), isTrue);
      });

      test("with an invalid argument type", () async {
        expect(await _spawn("""() async {
          try {
            await PackageResolver.current.resolveUri(12);
            return false;
          } on ArgumentError catch (_) {
            return true;
          }
        }()""", resolver), isTrue);
      });

      test("with a non-package URI", () async {
        expect(await _spawn("""() async {
          try {
            await PackageResolver.current.resolveUri('file:///zip/zap');
            return false;
          } on FormatException catch (_) {
            return true;
          }
        }()""", resolver), isTrue);
      });

      test("with an invalid package URI", () async {
        expect(await _spawn("""() async {
          try {
            await PackageResolver.current.resolveUri("package:");
            return false;
          } on FormatException catch (_) {
            return true;
          }
        }()""", resolver), isTrue);
      });
    });
  });
}

Future<String> get _packageResolverLibUri => _urlForPackage('package_resolver');

Future<String> get _pathLibUri => _urlForPackage('path');

Future<String> _urlForPackage(String package) async {
  var uri = await PackageResolver.current.urlFor(package);
  if (await PackageResolver.current.packageConfigMap != null) {
    return uri.toString();
  }

  // If we're using a package root, we resolve the symlinks in the test code so
  // we need to resolve them here as well to ensure we're testing against the
  // same values.
  var resolved = new Directory(p.fromUri(uri)).resolveSymbolicLinksSync();
  return ensureTrailingSlash(p.toUri(resolved)).toString();
}

Future _spawn(String expression, PackageResolver packageResolver) async {
  var data = new UriData.fromString("""
    import 'dart:convert';
    import 'dart:isolate';

    import 'package:package_resolver/package_resolver.dart';

    main(_, SendPort message) async {
      message.send(await ($expression));
    }
  """, mimeType: "application/dart", parameters: {"charset": "utf-8"});

  var receivePort = new ReceivePort();
  var errorPort = new ReceivePort();
  try {
    var isolate = await Isolate.spawnUri(data.uri, [], receivePort.sendPort,
        packageRoot: await packageResolver.packageRoot,
        packageConfig: await packageResolver.packageConfigUri,
        paused: true);

    isolate.addErrorListener(errorPort.sendPort);
    errorPort.listen((message) {
      registerException(message[0],
          message[1] == null ? null : new Trace.parse(message[1]));
      errorPort.close();
      receivePort.close();
    });
    isolate.resume(isolate.pauseCapability);

    var value = await receivePort.first;
    isolate.kill();
    return value;
  } finally {
    errorPort.close();
    receivePort.close();
  }
}
