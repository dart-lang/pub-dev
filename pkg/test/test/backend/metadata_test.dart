// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:boolean_selector/boolean_selector.dart';

import 'package:test/src/backend/metadata.dart';
import 'package:test/src/backend/platform_selector.dart';
import 'package:test/src/backend/test_platform.dart';
import 'package:test/src/frontend/skip.dart';
import 'package:test/src/frontend/timeout.dart';
import 'package:test/test.dart';

void main() {
  group("tags", () {
    test("parses an Iterable", () {
      expect(new Metadata.parse(tags: ["a", "b"]).tags,
          unorderedEquals(["a", "b"]));
    });

    test("parses a String", () {
      expect(new Metadata.parse(tags: "a").tags, unorderedEquals(["a"]));
    });

    test("parses null", () {
      expect(new Metadata.parse().tags, unorderedEquals([]));
    });

    test("parse refuses an invalid type", () {
      expect(() => new Metadata.parse(tags: 1), throwsArgumentError);
    });

    test("parse refuses an invalid type in a list", () {
      expect(() => new Metadata.parse(tags: [1]), throwsArgumentError);
    });

    test("merges tags by computing the union of the two tag sets", () {
      var merged =
          new Metadata(tags: ["a", "b"]).merge(new Metadata(tags: ["b", "c"]));
      expect(merged.tags, unorderedEquals(["a", "b", "c"]));
    });

    test("serializes and deserializes tags", () {
      var metadata = new Metadata(tags: ["a", "b"]).serialize();
      expect(
          new Metadata.deserialize(metadata).tags, unorderedEquals(['a', 'b']));
    });
  });

  group("constructor", () {
    test("returns the normal metadata if there's no forTag", () {
      var metadata = new Metadata(verboseTrace: true, tags: ['foo', 'bar']);
      expect(metadata.verboseTrace, isTrue);
      expect(metadata.tags, equals(['foo', 'bar']));
    });

    test("returns the normal metadata if there's no tags", () {
      var metadata = new Metadata(
          verboseTrace: true,
          forTag: {new BooleanSelector.parse('foo'): new Metadata(skip: true)});
      expect(metadata.verboseTrace, isTrue);
      expect(metadata.skip, isFalse);
      expect(metadata.forTag, contains(new BooleanSelector.parse('foo')));
      expect(metadata.forTag[new BooleanSelector.parse('foo')].skip, isTrue);
    });

    test("returns the normal metadata if forTag doesn't match tags", () {
      var metadata = new Metadata(
          verboseTrace: true,
          tags: ['bar', 'baz'],
          forTag: {new BooleanSelector.parse('foo'): new Metadata(skip: true)});

      expect(metadata.verboseTrace, isTrue);
      expect(metadata.skip, isFalse);
      expect(metadata.tags, unorderedEquals(['bar', 'baz']));
      expect(metadata.forTag, contains(new BooleanSelector.parse('foo')));
      expect(metadata.forTag[new BooleanSelector.parse('foo')].skip, isTrue);
    });

    test("resolves forTags that match tags", () {
      var metadata = new Metadata(verboseTrace: true, tags: [
        'foo',
        'bar',
        'baz'
      ], forTag: {
        new BooleanSelector.parse('foo'): new Metadata(skip: true),
        new BooleanSelector.parse('baz'): new Metadata(timeout: Timeout.none),
        new BooleanSelector.parse('qux'): new Metadata(skipReason: "blah")
      });

      expect(metadata.verboseTrace, isTrue);
      expect(metadata.skip, isTrue);
      expect(metadata.skipReason, isNull);
      expect(metadata.timeout, equals(Timeout.none));
      expect(metadata.tags, unorderedEquals(['foo', 'bar', 'baz']));
      expect(metadata.forTag.keys, equals([new BooleanSelector.parse('qux')]));
    });

    test("resolves forTags that adds a behavioral tag", () {
      var metadata = new Metadata(tags: [
        'foo'
      ], forTag: {
        new BooleanSelector.parse('baz'): new Metadata(skip: true),
        new BooleanSelector.parse('bar'):
            new Metadata(verboseTrace: true, tags: ['baz']),
        new BooleanSelector.parse('foo'): new Metadata(tags: ['bar'])
      });

      expect(metadata.verboseTrace, isTrue);
      expect(metadata.skip, isTrue);
      expect(metadata.tags, unorderedEquals(['foo', 'bar', 'baz']));
      expect(metadata.forTag, isEmpty);
    });

    test("resolves forTags that adds circular tags", () {
      var metadata = new Metadata(tags: [
        'foo'
      ], forTag: {
        new BooleanSelector.parse('foo'): new Metadata(tags: ['bar']),
        new BooleanSelector.parse('bar'): new Metadata(tags: ['baz']),
        new BooleanSelector.parse('baz'): new Metadata(tags: ['foo'])
      });

      expect(metadata.tags, unorderedEquals(['foo', 'bar', 'baz']));
      expect(metadata.forTag, isEmpty);
    });

    test("base metadata takes precedence over forTags", () {
      var metadata = new Metadata(verboseTrace: true, tags: [
        'foo'
      ], forTag: {
        new BooleanSelector.parse('foo'): new Metadata(verboseTrace: false)
      });

      expect(metadata.verboseTrace, isTrue);
    });
  });

  group("onPlatform", () {
    test("parses a valid map", () {
      var metadata = new Metadata.parse(onPlatform: {
        "chrome": new Timeout.factor(2),
        "vm": [new Skip(), new Timeout.factor(3)]
      });

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

    test("refuses an invalid value", () {
      expect(() {
        new Metadata.parse(onPlatform: {"chrome": new TestOn("chrome")});
      }, throwsArgumentError);
    });

    test("refuses an invalid value in a list", () {
      expect(() {
        new Metadata.parse(onPlatform: {
          "chrome": [new TestOn("chrome")]
        });
      }, throwsArgumentError);
    });

    test("refuses an invalid platform selector", () {
      expect(() {
        new Metadata.parse(onPlatform: {"vm &&": new Skip()});
      }, throwsFormatException);
    });

    test("refuses multiple Timeouts", () {
      expect(() {
        new Metadata.parse(onPlatform: {
          "chrome": [new Timeout.factor(2), new Timeout.factor(3)]
        });
      }, throwsArgumentError);
    });

    test("refuses multiple Skips", () {
      expect(() {
        new Metadata.parse(onPlatform: {
          "chrome": [new Skip(), new Skip()]
        });
      }, throwsArgumentError);
    });
  });

  group("validatePlatformSelectors", () {
    test("succeeds if onPlatform uses valid platforms", () {
      new Metadata.parse(onPlatform: {"vm || browser": new Skip()})
          .validatePlatformSelectors(new Set.from(["vm"]));
    });

    test("succeeds if testOn uses valid platforms", () {
      new Metadata.parse(testOn: "vm || browser")
          .validatePlatformSelectors(new Set.from(["vm"]));
    });

    test("fails if onPlatform uses an invalid platform", () {
      expect(() {
        new Metadata.parse(onPlatform: {"unknown": new Skip()})
            .validatePlatformSelectors(new Set.from(["vm"]));
      }, throwsFormatException);
    });

    test("fails if testOn uses an invalid platform", () {
      expect(() {
        new Metadata.parse(testOn: "unknown")
            .validatePlatformSelectors(new Set.from(["vm"]));
      }, throwsFormatException);
    });
  });

  group("change", () {
    test("preserves all fields if no parameters are passed", () {
      var metadata = new Metadata(
          testOn: new PlatformSelector.parse("linux"),
          timeout: new Timeout.factor(2),
          skip: true,
          skipReason: "just because",
          verboseTrace: true,
          tags: [
            "foo",
            "bar"
          ],
          onPlatform: {
            new PlatformSelector.parse("mac-os"): new Metadata(skip: false)
          },
          forTag: {
            new BooleanSelector.parse("slow"):
                new Metadata(timeout: new Timeout.factor(4))
          });
      expect(metadata.serialize(), equals(metadata.change().serialize()));
    });

    test("updates a changed field", () {
      var metadata = new Metadata(timeout: new Timeout.factor(2));
      expect(metadata.change(timeout: new Timeout.factor(3)).timeout,
          equals(new Timeout.factor(3)));
    });
  });
}
