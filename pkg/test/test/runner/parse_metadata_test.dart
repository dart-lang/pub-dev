// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn("vm")
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:test/src/backend/platform_selector.dart';
import 'package:test/src/backend/test_platform.dart';
import 'package:test/src/runner/parse_metadata.dart';
import 'package:test/src/util/io.dart';

String _sandbox;
String _path;

void main() {
  setUp(() {
    _sandbox = createTempDir();
    _path = p.join(_sandbox, "test.dart");
  });

  tearDown(() {
    new Directory(_sandbox).deleteSync(recursive: true);
  });

  test("returns empty metadata for an empty file", () {
    new File(_path).writeAsStringSync("");
    var metadata = parseMetadata(_path, new Set());
    expect(metadata.testOn, equals(PlatformSelector.all));
    expect(metadata.timeout.scaleFactor, equals(1));
  });

  test("ignores irrelevant annotations", () {
    new File(_path).writeAsStringSync("@Fblthp\n@Fblthp.foo\nlibrary foo;");
    var metadata = parseMetadata(_path, new Set());
    expect(metadata.testOn, equals(PlatformSelector.all));
  });

  test("parses a prefixed annotation", () {
    new File(_path).writeAsStringSync("@foo.TestOn('vm')\n"
        "import 'package:test/test.dart' as foo;");
    var metadata = parseMetadata(_path, new Set());
    expect(metadata.testOn.evaluate(TestPlatform.vm), isTrue);
    expect(metadata.testOn.evaluate(TestPlatform.chrome), isFalse);
  });

  group("@TestOn:", () {
    test("parses a valid annotation", () {
      new File(_path).writeAsStringSync("@TestOn('vm')\nlibrary foo;");
      var metadata = parseMetadata(_path, new Set());
      expect(metadata.testOn.evaluate(TestPlatform.vm), isTrue);
      expect(metadata.testOn.evaluate(TestPlatform.chrome), isFalse);
    });

    test("ignores a constructor named TestOn", () {
      new File(_path).writeAsStringSync("@foo.TestOn('foo')\nlibrary foo;");
      var metadata = parseMetadata(_path, new Set());
      expect(metadata.testOn, equals(PlatformSelector.all));
    });

    group("throws an error for", () {
      test("a named constructor", () {
        new File(_path).writeAsStringSync("@TestOn.name('foo')\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("no argument list", () {
        new File(_path).writeAsStringSync("@TestOn\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("an empty argument list", () {
        new File(_path).writeAsStringSync("@TestOn()\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("a named argument", () {
        new File(_path)
            .writeAsStringSync("@TestOn(expression: 'foo')\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("multiple arguments", () {
        new File(_path)
            .writeAsStringSync("@TestOn('foo', 'bar')\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("a non-string argument", () {
        new File(_path).writeAsStringSync("@TestOn(123)\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("multiple @TestOns", () {
        new File(_path)
            .writeAsStringSync("@TestOn('foo')\n@TestOn('bar')\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });
    });
  });

  group("@Timeout:", () {
    test("parses a valid duration annotation", () {
      new File(_path).writeAsStringSync("""
@Timeout(const Duration(
    hours: 1,
    minutes: 2,
    seconds: 3,
    milliseconds: 4,
    microseconds: 5))

library foo;
""");
      var metadata = parseMetadata(_path, new Set());
      expect(
          metadata.timeout.duration,
          equals(new Duration(
              hours: 1,
              minutes: 2,
              seconds: 3,
              milliseconds: 4,
              microseconds: 5)));
    });

    test("parses a valid int factor annotation", () {
      new File(_path).writeAsStringSync("""
@Timeout.factor(1)

library foo;
""");
      var metadata = parseMetadata(_path, new Set());
      expect(metadata.timeout.scaleFactor, equals(1));
    });

    test("parses a valid double factor annotation", () {
      new File(_path).writeAsStringSync("""
@Timeout.factor(0.5)

library foo;
""");
      var metadata = parseMetadata(_path, new Set());
      expect(metadata.timeout.scaleFactor, equals(0.5));
    });

    test("parses a valid Timeout.none annotation", () {
      new File(_path).writeAsStringSync("""
@Timeout.none

library foo;
""");
      var metadata = parseMetadata(_path, new Set());
      expect(metadata.timeout, same(Timeout.none));
    });

    test("ignores a constructor named Timeout", () {
      new File(_path).writeAsStringSync("@foo.Timeout('foo')\nlibrary foo;");
      var metadata = parseMetadata(_path, new Set());
      expect(metadata.timeout.scaleFactor, equals(1));
    });

    group("throws an error for", () {
      test("an unknown named constructor", () {
        new File(_path).writeAsStringSync("@Timeout.name('foo')\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("no argument list", () {
        new File(_path).writeAsStringSync("@Timeout\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("an empty argument list", () {
        new File(_path).writeAsStringSync("@Timeout()\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("an argument list for Timeout.none", () {
        new File(_path).writeAsStringSync("@Timeout.none()\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("a named argument", () {
        new File(_path).writeAsStringSync(
            "@Timeout(duration: const Duration(seconds: 1))\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("multiple arguments", () {
        new File(_path)
            .writeAsStringSync("@Timeout.factor(1, 2)\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("a non-Duration argument", () {
        new File(_path).writeAsStringSync("@Timeout(10)\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("a non-num argument", () {
        new File(_path)
            .writeAsStringSync("@Timeout.factor('foo')\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("multiple @Timeouts", () {
        new File(_path).writeAsStringSync(
            "@Timeout.factor(1)\n@Timeout.factor(2)\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      group("a Duration with", () {
        test("a non-const constructor", () {
          new File(_path)
              .writeAsStringSync("@Timeout(new Duration(1))\nlibrary foo;");
          expect(() => parseMetadata(_path, new Set()), throwsFormatException);
        });

        test("a named constructor", () {
          new File(_path).writeAsStringSync(
              "@Timeout(const Duration.name(seconds: 1))\nlibrary foo;");
          expect(() => parseMetadata(_path, new Set()), throwsFormatException);
        });

        test("a positional argument", () {
          new File(_path)
              .writeAsStringSync("@Timeout(const Duration(1))\nlibrary foo;");
          expect(() => parseMetadata(_path, new Set()), throwsFormatException);
        });

        test("an unknown named argument", () {
          new File(_path).writeAsStringSync(
              "@Timeout(const Duration(name: 1))\nlibrary foo;");
          expect(() => parseMetadata(_path, new Set()), throwsFormatException);
        });

        test("a duplicate named argument", () {
          new File(_path).writeAsStringSync(
              "@Timeout(const Duration(seconds: 1, seconds: 1))\nlibrary foo;");
          expect(() => parseMetadata(_path, new Set()), throwsFormatException);
        });
      });
    });
  });

  group("@Skip:", () {
    test("parses a valid annotation", () {
      new File(_path).writeAsStringSync("@Skip()\nlibrary foo;");
      var metadata = parseMetadata(_path, new Set());
      expect(metadata.skip, isTrue);
      expect(metadata.skipReason, isNull);
    });

    test("parses a valid annotation with a reason", () {
      new File(_path).writeAsStringSync("@Skip('reason')\nlibrary foo;");
      var metadata = parseMetadata(_path, new Set());
      expect(metadata.skip, isTrue);
      expect(metadata.skipReason, equals('reason'));
    });

    test("ignores a constructor named Skip", () {
      new File(_path).writeAsStringSync("@foo.Skip('foo')\nlibrary foo;");
      var metadata = parseMetadata(_path, new Set());
      expect(metadata.skip, isFalse);
    });

    group("throws an error for", () {
      test("a named constructor", () {
        new File(_path).writeAsStringSync("@Skip.name('foo')\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("no argument list", () {
        new File(_path).writeAsStringSync("@Skip\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("a named argument", () {
        new File(_path).writeAsStringSync("@Skip(reason: 'foo')\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("multiple arguments", () {
        new File(_path).writeAsStringSync("@Skip('foo', 'bar')\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("a non-string argument", () {
        new File(_path).writeAsStringSync("@Skip(123)\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("multiple @Skips", () {
        new File(_path)
            .writeAsStringSync("@Skip('foo')\n@Skip('bar')\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });
    });
  });

  group("@Tags:", () {
    test("parses a valid annotation", () {
      new File(_path).writeAsStringSync("@Tags(const ['a'])\nlibrary foo;");
      var metadata = parseMetadata(_path, new Set());
      expect(metadata.tags, equals(["a"]));
    });

    test("ignores a constructor named Tags", () {
      new File(_path).writeAsStringSync("@foo.Tags(const ['a'])\nlibrary foo;");
      var metadata = parseMetadata(_path, new Set());
      expect(metadata.tags, isEmpty);
    });

    group("throws an error for", () {
      test("a named constructor", () {
        new File(_path)
            .writeAsStringSync("@Tags.name(const ['a'])\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("no argument list", () {
        new File(_path).writeAsStringSync("@Tags\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("a named argument", () {
        new File(_path).writeAsStringSync("@Tags(tags: ['a'])\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("multiple arguments", () {
        new File(_path)
            .writeAsStringSync("@Tags(const ['a'], ['b'])\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("a non-list argument", () {
        new File(_path).writeAsStringSync("@Tags('a')\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("multiple @Tags", () {
        new File(_path).writeAsStringSync(
            "@Tags(const ['a'])\n@Tags(const ['b'])\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });
    });
  });

  group("@OnPlatform:", () {
    test("parses a valid annotation", () {
      new File(_path).writeAsStringSync("""
@OnPlatform(const {
  'chrome': const Timeout.factor(2),
  'vm': const [const Skip(), const Timeout.factor(3)]
})
library foo;""");
      var metadata = parseMetadata(_path, new Set());

      var key = metadata.onPlatform.keys.first;
      expect(key.evaluate(TestPlatform.chrome), isTrue);
      expect(key.evaluate(TestPlatform.vm), isFalse);
      var value = metadata.onPlatform.values.first;
      expect(value.timeout.scaleFactor, equals(2));

      key = metadata.onPlatform.keys.last;
      expect(key.evaluate(TestPlatform.vm), isTrue);
      expect(key.evaluate(TestPlatform.chrome), isFalse);
      value = metadata.onPlatform.values.last;
      expect(value.skip, isTrue);
      expect(value.timeout.scaleFactor, equals(3));
    });

    test("ignores a constructor named OnPlatform", () {
      new File(_path).writeAsStringSync("@foo.OnPlatform('foo')\nlibrary foo;");
      var metadata = parseMetadata(_path, new Set());
      expect(metadata.testOn, equals(PlatformSelector.all));
    });

    group("throws an error for", () {
      test("a named constructor", () {
        new File(_path)
            .writeAsStringSync("@OnPlatform.name(const {})\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("no argument list", () {
        new File(_path).writeAsStringSync("@OnPlatform\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("an empty argument list", () {
        new File(_path).writeAsStringSync("@OnPlatform()\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("a named argument", () {
        new File(_path)
            .writeAsStringSync("@OnPlatform(map: const {})\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("multiple arguments", () {
        new File(_path)
            .writeAsStringSync("@OnPlatform(const {}, const {})\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("a non-map argument", () {
        new File(_path)
            .writeAsStringSync("@OnPlatform(const Skip())\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("a non-const map", () {
        new File(_path).writeAsStringSync("@OnPlatform({})\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("a map with a non-String key", () {
        new File(_path).writeAsStringSync(
            "@OnPlatform(const {1: const Skip()})\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("a map with a unparseable key", () {
        new File(_path).writeAsStringSync(
            "@OnPlatform(const {'invalid': const Skip()})\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("a map with an invalid value", () {
        new File(_path).writeAsStringSync(
            "@OnPlatform(const {'vm': const TestOn('vm')})\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("a map with an invalid value in a list", () {
        new File(_path).writeAsStringSync(
            "@OnPlatform(const {'vm': [const TestOn('vm')]})\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });

      test("multiple @OnPlatforms", () {
        new File(_path).writeAsStringSync(
            "@OnPlatform(const {})\n@OnPlatform(const {})\nlibrary foo;");
        expect(() => parseMetadata(_path, new Set()), throwsFormatException);
      });
    });
  });
}
