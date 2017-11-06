// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:package_resolver/package_resolver.dart';

void main() {
  var resolver;
  setUp(() {
    resolver = SyncPackageResolver.none;
  });

  test("exposes everything as null", () {
    expect(resolver.packageConfigMap, isNull);
    expect(resolver.packageConfigUri, isNull);
    expect(resolver.packageRoot, isNull);
    expect(resolver.processArgument, isNull);
    expect(resolver.resolveUri("package:foo/bar.dart"), isNull);
    expect(resolver.urlFor("foo"), isNull);
    expect(resolver.urlFor("foo", "bar.dart"), isNull);
    expect(resolver.packageUriFor("file:///foo/bar.dart"), isNull);
    expect(resolver.packagePath("foo"), isNull);
  });

  group("resolveUri", () {
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

  test("packageUriFor with an invalid argument type", () {
    expect(() => resolver.packageUriFor(12), throwsArgumentError);
  });
}
