// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn("vm")
import 'package:boolean_selector/boolean_selector.dart';
import 'package:test/test.dart';

import 'package:test/src/backend/platform_selector.dart';
import 'package:test/src/backend/test_platform.dart';
import 'package:test/src/runner/configuration/platform_selection.dart';
import 'package:test/src/runner/configuration/suite.dart';

void main() {
  group("merge", () {
    group("for most fields", () {
      test("if neither is defined, preserves the default", () {
        var merged = new SuiteConfiguration().merge(new SuiteConfiguration());
        expect(merged.jsTrace, isFalse);
        expect(merged.runSkipped, isFalse);
        expect(merged.precompiledPath, isNull);
        expect(merged.platforms, equals([TestPlatform.vm.identifier]));
      });

      test("if only the old configuration's is defined, uses it", () {
        var merged = new SuiteConfiguration(
            jsTrace: true,
            runSkipped: true,
            precompiledPath: "/tmp/js",
            platforms: [
              new PlatformSelection(TestPlatform.chrome.identifier)
            ]).merge(new SuiteConfiguration());

        expect(merged.jsTrace, isTrue);
        expect(merged.runSkipped, isTrue);
        expect(merged.precompiledPath, equals("/tmp/js"));
        expect(merged.platforms, equals([TestPlatform.chrome.identifier]));
      });

      test("if only the new configuration's is defined, uses it", () {
        var merged = new SuiteConfiguration().merge(new SuiteConfiguration(
            jsTrace: true,
            runSkipped: true,
            precompiledPath: "/tmp/js",
            platforms: [
              new PlatformSelection(TestPlatform.chrome.identifier)
            ]));

        expect(merged.jsTrace, isTrue);
        expect(merged.runSkipped, isTrue);
        expect(merged.precompiledPath, equals("/tmp/js"));
        expect(merged.platforms, equals([TestPlatform.chrome.identifier]));
      });

      test(
          "if the two configurations conflict, uses the new configuration's "
          "values", () {
        var older = new SuiteConfiguration(
            jsTrace: false,
            runSkipped: true,
            precompiledPath: "/tmp/js",
            platforms: [new PlatformSelection(TestPlatform.chrome.identifier)]);
        var newer = new SuiteConfiguration(
            jsTrace: true,
            runSkipped: false,
            precompiledPath: "../js",
            platforms: [
              new PlatformSelection(TestPlatform.dartium.identifier)
            ]);
        var merged = older.merge(newer);

        expect(merged.jsTrace, isTrue);
        expect(merged.runSkipped, isFalse);
        expect(merged.precompiledPath, equals("../js"));
        expect(merged.platforms, equals([TestPlatform.dartium.identifier]));
      });
    });

    group("for include and excludeTags", () {
      test("if neither is defined, preserves the default", () {
        var merged = new SuiteConfiguration().merge(new SuiteConfiguration());
        expect(merged.includeTags, equals(BooleanSelector.all));
        expect(merged.excludeTags, equals(BooleanSelector.none));
      });

      test("if only the old configuration's is defined, uses it", () {
        var merged = new SuiteConfiguration(
                includeTags: new BooleanSelector.parse("foo || bar"),
                excludeTags: new BooleanSelector.parse("baz || bang"))
            .merge(new SuiteConfiguration());

        expect(merged.includeTags,
            equals(new BooleanSelector.parse("foo || bar")));
        expect(merged.excludeTags,
            equals(new BooleanSelector.parse("baz || bang")));
      });

      test("if only the new configuration's is defined, uses it", () {
        var merged = new SuiteConfiguration().merge(new SuiteConfiguration(
            includeTags: new BooleanSelector.parse("foo || bar"),
            excludeTags: new BooleanSelector.parse("baz || bang")));

        expect(merged.includeTags,
            equals(new BooleanSelector.parse("foo || bar")));
        expect(merged.excludeTags,
            equals(new BooleanSelector.parse("baz || bang")));
      });

      test("if both are defined, unions or intersects them", () {
        var older = new SuiteConfiguration(
            includeTags: new BooleanSelector.parse("foo || bar"),
            excludeTags: new BooleanSelector.parse("baz || bang"));
        var newer = new SuiteConfiguration(
            includeTags: new BooleanSelector.parse("blip"),
            excludeTags: new BooleanSelector.parse("qux"));
        var merged = older.merge(newer);

        expect(merged.includeTags,
            equals(new BooleanSelector.parse("(foo || bar) && blip")));
        expect(merged.excludeTags,
            equals(new BooleanSelector.parse("(baz || bang) || qux")));
      });
    });

    group("for sets", () {
      test("if neither is defined, preserves the default", () {
        var merged = new SuiteConfiguration().merge(new SuiteConfiguration());
        expect(merged.patterns, isEmpty);
      });

      test("if only the old configuration's is defined, uses it", () {
        var merged = new SuiteConfiguration(patterns: ["beep", "boop"])
            .merge(new SuiteConfiguration());

        expect(merged.patterns, equals(["beep", "boop"]));
      });

      test("if only the new configuration's is defined, uses it", () {
        var merged = new SuiteConfiguration()
            .merge(new SuiteConfiguration(patterns: ["beep", "boop"]));

        expect(merged.patterns, equals(["beep", "boop"]));
      });

      test("if both are defined, unions them", () {
        var older = new SuiteConfiguration(patterns: ["beep", "boop"]);
        var newer = new SuiteConfiguration(patterns: ["bonk"]);
        var merged = older.merge(newer);

        expect(merged.patterns, unorderedEquals(["beep", "boop", "bonk"]));
      });
    });

    group("for dart2jsArgs", () {
      test("if neither is defined, preserves the default", () {
        var merged = new SuiteConfiguration().merge(new SuiteConfiguration());
        expect(merged.dart2jsArgs, isEmpty);
      });

      test("if only the old configuration's is defined, uses it", () {
        var merged = new SuiteConfiguration(dart2jsArgs: ["--foo", "--bar"])
            .merge(new SuiteConfiguration());
        expect(merged.dart2jsArgs, equals(["--foo", "--bar"]));
      });

      test("if only the new configuration's is defined, uses it", () {
        var merged = new SuiteConfiguration()
            .merge(new SuiteConfiguration(dart2jsArgs: ["--foo", "--bar"]));
        expect(merged.dart2jsArgs, equals(["--foo", "--bar"]));
      });

      test("if both are defined, concatenates them", () {
        var older = new SuiteConfiguration(dart2jsArgs: ["--foo", "--bar"]);
        var newer = new SuiteConfiguration(dart2jsArgs: ["--baz"]);
        var merged = older.merge(newer);
        expect(merged.dart2jsArgs, equals(["--foo", "--bar", "--baz"]));
      });
    });

    group("for config maps", () {
      test("merges each nested configuration", () {
        var merged = new SuiteConfiguration(tags: {
          new BooleanSelector.parse("foo"):
              new SuiteConfiguration(precompiledPath: "path/"),
          new BooleanSelector.parse("bar"):
              new SuiteConfiguration(jsTrace: true)
        }, onPlatform: {
          new PlatformSelector.parse("vm"):
              new SuiteConfiguration(precompiledPath: "path/"),
          new PlatformSelector.parse("chrome"):
              new SuiteConfiguration(jsTrace: true)
        }).merge(new SuiteConfiguration(tags: {
          new BooleanSelector.parse("bar"):
              new SuiteConfiguration(jsTrace: false),
          new BooleanSelector.parse("baz"):
              new SuiteConfiguration(runSkipped: true)
        }, onPlatform: {
          new PlatformSelector.parse("chrome"):
              new SuiteConfiguration(jsTrace: false),
          new PlatformSelector.parse("firefox"):
              new SuiteConfiguration(runSkipped: true)
        }));

        expect(merged.tags[new BooleanSelector.parse("foo")].precompiledPath,
            equals("path/"));
        expect(merged.tags[new BooleanSelector.parse("bar")].jsTrace, isFalse);
        expect(
            merged.tags[new BooleanSelector.parse("baz")].runSkipped, isTrue);

        expect(
            merged.onPlatform[new PlatformSelector.parse("vm")].precompiledPath,
            "path/");
        expect(merged.onPlatform[new PlatformSelector.parse("chrome")].jsTrace,
            isFalse);
        expect(
            merged.onPlatform[new PlatformSelector.parse("firefox")].runSkipped,
            isTrue);
      });
    });
  });
}
