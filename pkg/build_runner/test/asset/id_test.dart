// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('vm')
import 'package:test/test.dart';

import 'package:build/build.dart';

// Forked from `barback/test/asset_id_test.dart`.
void main() {
  group("constructor", () {
    test("normalizes the path", () {
      var id = new AssetId("app", r"path/././/to/drop/..//asset.txt");
      expect(id.path, equals("path/to/asset.txt"));
    });

    test("normalizes backslashes to slashes in the path", () {
      var id = new AssetId("app", r"path\to/asset.txt");
      expect(id.path, equals("path/to/asset.txt"));
    });
  });

  group("parse", () {
    test("parses the package and path", () {
      var id = new AssetId.parse("package|path/to/asset.txt");
      expect(id.package, equals("package"));
      expect(id.path, equals("path/to/asset.txt"));
    });

    test("throws if there are multiple '|'", () {
      expect(() => new AssetId.parse("app|path|wtf"), throwsFormatException);
    });

    test("throws if the package name is empty '|'", () {
      expect(() => new AssetId.parse("|asset.txt"), throwsFormatException);
    });

    test("throws if the path is empty '|'", () {
      expect(() => new AssetId.parse("app|"), throwsFormatException);
    });

    test("normalizes the path", () {
      var id = new AssetId.parse(r"app|path/././/to/drop/..//asset.txt");
      expect(id.path, equals("path/to/asset.txt"));
    });

    test("normalizes backslashes to slashes in the path", () {
      var id = new AssetId.parse(r"app|path\to/asset.txt");
      expect(id.path, equals("path/to/asset.txt"));
    });
  });

  test("equals another ID with the same package and path", () {
    expect(new AssetId.parse("foo|asset.txt"),
        equals(new AssetId.parse("foo|asset.txt")));

    expect(new AssetId.parse("foo|asset.txt"),
        isNot(equals(new AssetId.parse("bar|asset.txt"))));

    expect(new AssetId.parse("foo|asset.txt"),
        isNot(equals(new AssetId.parse("bar|other.txt"))));
  });

  test("identical assets are treated as the same in a Map/Set", () {
    var id1 = new AssetId('a', 'web/a.txt');
    var id2 = new AssetId('a', 'web/a.txt');

    expect({id1: true}.containsKey(id2), isTrue);
    expect([id1].toSet(), contains(id2));
  });
}
