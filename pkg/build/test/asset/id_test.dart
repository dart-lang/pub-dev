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

  group("resolve", () {
    test("should parse a package: URI", () {
      var id = new AssetId.resolve(r"package:app/app.dart");
      expect(id, new AssetId("app", "lib/app.dart"));
    });

    test("should parse a package: URI with a long path", () {
      var id = new AssetId.resolve(r"package:app/src/some/path.dart");
      expect(id, new AssetId("app", "lib/src/some/path.dart"));
    });

    test("should parse an asset: URI", () {
      var id = new AssetId.resolve(r"asset:app/test/foo_test.dart");
      expect(id, new AssetId("app", "test/foo_test.dart"));
    });

    test("should throw for a file: URI", () {
      expect(() => new AssetId.resolve(r"file://localhost/etc/fstab1"),
          throwsUnsupportedError);
    });

    test("should throw for a dart: URI", () {
      expect(() => new AssetId.resolve(r"dart:collection"),
          throwsUnsupportedError);
    });

    test("should throw parsing a relative package URI without an origin", () {
      expect(() => new AssetId.resolve("some/relative/path.dart"),
          throwsArgumentError);
    });

    test("should parse a relative URI within the test/ folder", () {
      var id = new AssetId.resolve("common.dart",
          from: new AssetId("app", "test/some_test.dart"));
      expect(id, new AssetId("app", "test/common.dart"));
    });

    test("should parse a relative package URI", () {
      var id = new AssetId.resolve("some/relative/path.dart",
          from: new AssetId("app", "lib/app.dart"));
      expect(id, new AssetId("app", "lib/some/relative/path.dart"));
    });

    test("should parse a relative package URI pointing back", () {
      var id = new AssetId.resolve("../src/some/path.dart",
          from: new AssetId("app", "folder/folder.dart"));
      expect(id, new AssetId("app", "src/some/path.dart"));
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
    expect(new Set<AssetId>.from([id1]), contains(id2));
  });
}
