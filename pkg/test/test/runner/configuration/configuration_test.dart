// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@TestOn("vm")
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'package:test/src/runner/configuration.dart';
import 'package:test/src/runner/configuration/reporters.dart';
import 'package:test/src/util/io.dart';

void main() {
  group("merge", () {
    group("for most fields", () {
      test("if neither is defined, preserves the default", () {
        var merged = new Configuration().merge(new Configuration());
        expect(merged.help, isFalse);
        expect(merged.version, isFalse);
        expect(merged.pauseAfterLoad, isFalse);
        expect(merged.color, equals(canUseSpecialChars));
        expect(merged.configurationPath, equals('dart_test.yaml'));
        expect(merged.dart2jsPath, equals(p.join(sdkDir, 'bin', 'dart2js')));
        expect(merged.reporter, equals(defaultReporter));
        expect(merged.pubServeUrl, isNull);
        expect(merged.shardIndex, isNull);
        expect(merged.totalShards, isNull);
        expect(merged.paths, equals(["test"]));
      });

      test("if only the old configuration's is defined, uses it", () {
        var merged = new Configuration(
            help: true,
            version: true,
            pauseAfterLoad: true,
            color: true,
            configurationPath: "special_test.yaml",
            dart2jsPath: "/tmp/dart2js",
            reporter: "json",
            pubServePort: 1234,
            shardIndex: 3,
            totalShards: 10,
            paths: ["bar"]).merge(new Configuration());

        expect(merged.help, isTrue);
        expect(merged.version, isTrue);
        expect(merged.pauseAfterLoad, isTrue);
        expect(merged.color, isTrue);
        expect(merged.configurationPath, equals("special_test.yaml"));
        expect(merged.dart2jsPath, equals("/tmp/dart2js"));
        expect(merged.reporter, equals("json"));
        expect(merged.pubServeUrl.port, equals(1234));
        expect(merged.shardIndex, equals(3));
        expect(merged.totalShards, equals(10));
        expect(merged.paths, equals(["bar"]));
      });

      test("if only the new configuration's is defined, uses it", () {
        var merged = new Configuration().merge(new Configuration(
            help: true,
            version: true,
            pauseAfterLoad: true,
            color: true,
            configurationPath: "special_test.yaml",
            dart2jsPath: "/tmp/dart2js",
            reporter: "json",
            pubServePort: 1234,
            shardIndex: 3,
            totalShards: 10,
            paths: ["bar"]));

        expect(merged.help, isTrue);
        expect(merged.version, isTrue);
        expect(merged.pauseAfterLoad, isTrue);
        expect(merged.color, isTrue);
        expect(merged.configurationPath, equals("special_test.yaml"));
        expect(merged.dart2jsPath, equals("/tmp/dart2js"));
        expect(merged.reporter, equals("json"));
        expect(merged.pubServeUrl.port, equals(1234));
        expect(merged.shardIndex, equals(3));
        expect(merged.totalShards, equals(10));
        expect(merged.paths, equals(["bar"]));
      });

      test(
          "if the two configurations conflict, uses the new configuration's "
          "values", () {
        var older = new Configuration(
            help: true,
            version: false,
            pauseAfterLoad: true,
            color: false,
            configurationPath: "special_test.yaml",
            dart2jsPath: "/tmp/dart2js",
            reporter: "json",
            pubServePort: 1234,
            shardIndex: 2,
            totalShards: 4,
            paths: ["bar"]);
        var newer = new Configuration(
            help: false,
            version: true,
            pauseAfterLoad: false,
            color: true,
            configurationPath: "test_special.yaml",
            dart2jsPath: "../dart2js",
            reporter: "compact",
            pubServePort: 5678,
            shardIndex: 3,
            totalShards: 10,
            paths: ["blech"]);
        var merged = older.merge(newer);

        expect(merged.help, isFalse);
        expect(merged.version, isTrue);
        expect(merged.pauseAfterLoad, isFalse);
        expect(merged.color, isTrue);
        expect(merged.configurationPath, equals("test_special.yaml"));
        expect(merged.dart2jsPath, equals("../dart2js"));
        expect(merged.reporter, equals("compact"));
        expect(merged.pubServeUrl.port, equals(5678));
        expect(merged.shardIndex, equals(3));
        expect(merged.totalShards, equals(10));
        expect(merged.paths, equals(["blech"]));
      });
    });

    group("for chosenPresets", () {
      test("if neither is defined, preserves the default", () {
        var merged = new Configuration().merge(new Configuration());
        expect(merged.chosenPresets, isEmpty);
      });

      test("if only the old configuration's is defined, uses it", () {
        var merged = new Configuration(chosenPresets: ["baz", "bang"])
            .merge(new Configuration());
        expect(merged.chosenPresets, equals(["baz", "bang"]));
      });

      test("if only the new configuration's is defined, uses it", () {
        var merged = new Configuration()
            .merge(new Configuration(chosenPresets: ["baz", "bang"]));
        expect(merged.chosenPresets, equals(["baz", "bang"]));
      });

      test("if both are defined, unions them", () {
        var merged = new Configuration(chosenPresets: ["baz", "bang"])
            .merge(new Configuration(chosenPresets: ["qux"]));
        expect(merged.chosenPresets, equals(["baz", "bang", "qux"]));
      });
    });

    group("for presets", () {
      test("merges each nested configuration", () {
        var merged = new Configuration(presets: {
          "bang": new Configuration(pauseAfterLoad: true),
          "qux": new Configuration(color: true)
        }).merge(new Configuration(presets: {
          "qux": new Configuration(color: false),
          "zap": new Configuration(help: true)
        }));

        expect(merged.presets["bang"].pauseAfterLoad, isTrue);
        expect(merged.presets["qux"].color, isFalse);
        expect(merged.presets["zap"].help, isTrue);
      });

      test("automatically resolves a matching chosen preset", () {
        var configuration = new Configuration(
            presets: {"foo": new Configuration(color: true)},
            chosenPresets: ["foo"]);
        expect(configuration.presets, isEmpty);
        expect(configuration.chosenPresets, equals(["foo"]));
        expect(configuration.knownPresets, equals(["foo"]));
        expect(configuration.color, isTrue);
      });

      test("resolves a chosen presets in order", () {
        var configuration = new Configuration(presets: {
          "foo": new Configuration(color: true),
          "bar": new Configuration(color: false)
        }, chosenPresets: [
          "foo",
          "bar"
        ]);
        expect(configuration.presets, isEmpty);
        expect(configuration.chosenPresets, equals(["foo", "bar"]));
        expect(configuration.knownPresets, unorderedEquals(["foo", "bar"]));
        expect(configuration.color, isFalse);

        configuration = new Configuration(presets: {
          "foo": new Configuration(color: true),
          "bar": new Configuration(color: false)
        }, chosenPresets: [
          "bar",
          "foo"
        ]);
        expect(configuration.presets, isEmpty);
        expect(configuration.chosenPresets, equals(["bar", "foo"]));
        expect(configuration.knownPresets, unorderedEquals(["foo", "bar"]));
        expect(configuration.color, isTrue);
      });

      test("ignores inapplicable chosen presets", () {
        var configuration =
            new Configuration(presets: {}, chosenPresets: ["baz"]);
        expect(configuration.presets, isEmpty);
        expect(configuration.chosenPresets, equals(["baz"]));
        expect(configuration.knownPresets, equals(isEmpty));
      });

      test("resolves presets through merging", () {
        var configuration =
            new Configuration(presets: {"foo": new Configuration(color: true)})
                .merge(new Configuration(chosenPresets: ["foo"]));

        expect(configuration.presets, isEmpty);
        expect(configuration.chosenPresets, equals(["foo"]));
        expect(configuration.knownPresets, equals(["foo"]));
        expect(configuration.color, isTrue);
      });

      test("preserves known presets through merging", () {
        var configuration = new Configuration(
            presets: {"foo": new Configuration(color: true)},
            chosenPresets: ["foo"]).merge(new Configuration());

        expect(configuration.presets, isEmpty);
        expect(configuration.chosenPresets, equals(["foo"]));
        expect(configuration.knownPresets, equals(["foo"]));
        expect(configuration.color, isTrue);
      });
    });
  });
}
