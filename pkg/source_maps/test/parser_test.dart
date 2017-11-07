// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library test.parser_test;

import 'dart:convert';
import 'package:test/test.dart';
import 'package:source_maps/source_maps.dart';
import 'package:source_span/source_span.dart';
import 'common.dart';

const Map<String, dynamic> MAP_WITH_NO_SOURCE_LOCATION = const {
  'version': 3,
  'sourceRoot': '',
  'sources': const ['input.dart'],
  'names': const [],
  'mappings': 'A',
  'file': 'output.dart'
};

const Map<String, dynamic> MAP_WITH_SOURCE_LOCATION = const {
  'version': 3,
  'sourceRoot': '',
  'sources': const ['input.dart'],
  'names': const [],
  'mappings': 'AAAA',
  'file': 'output.dart'
};

const Map<String, dynamic> MAP_WITH_SOURCE_LOCATION_AND_NAME = const {
  'version': 3,
  'sourceRoot': '',
  'sources': const ['input.dart'],
  'names': const ['var'],
  'mappings': 'AAAAA',
  'file': 'output.dart'
};

const Map<String, dynamic> MAP_WITH_SOURCE_LOCATION_AND_NAME_1 = const {
  'version': 3,
  'sourceRoot': 'pkg/',
  'sources': const ['input1.dart'],
  'names': const ['var1'],
  'mappings': 'AAAAA',
  'file': 'output.dart'
};

const Map<String, dynamic> MAP_WITH_SOURCE_LOCATION_AND_NAME_2 = const {
  'version': 3,
  'sourceRoot': 'pkg/',
  'sources': const ['input2.dart'],
  'names': const ['var2'],
  'mappings': 'AAAAA',
  'file': 'output2.dart'
};

const Map<String, dynamic> MAP_WITH_SOURCE_LOCATION_AND_NAME_3 = const {
  'version': 3,
  'sourceRoot': 'pkg/',
  'sources': const ['input3.dart'],
  'names': const ['var3'],
  'mappings': 'AAAAA',
  'file': '3/output.dart'
};

const List SOURCE_MAP_BUNDLE = const [
  MAP_WITH_SOURCE_LOCATION_AND_NAME_1,
  MAP_WITH_SOURCE_LOCATION_AND_NAME_2,
  MAP_WITH_SOURCE_LOCATION_AND_NAME_3,
];

main() {
  test('parse', () {
    var mapping = parseJson(EXPECTED_MAP);
    check(outputVar1, mapping, inputVar1, false);
    check(outputVar2, mapping, inputVar2, false);
    check(outputFunction, mapping, inputFunction, false);
    check(outputExpr, mapping, inputExpr, false);
  });

  test('parse + json', () {
    var mapping = parse(JSON.encode(EXPECTED_MAP));
    check(outputVar1, mapping, inputVar1, false);
    check(outputVar2, mapping, inputVar2, false);
    check(outputFunction, mapping, inputFunction, false);
    check(outputExpr, mapping, inputExpr, false);
  });

  test('parse with file', () {
    var mapping = parseJson(EXPECTED_MAP);
    check(outputVar1, mapping, inputVar1, true);
    check(outputVar2, mapping, inputVar2, true);
    check(outputFunction, mapping, inputFunction, true);
    check(outputExpr, mapping, inputExpr, true);
  });

  test('parse with no source location', () {
    SingleMapping map = parse(JSON.encode(MAP_WITH_NO_SOURCE_LOCATION));
    expect(map.lines.length, 1);
    expect(map.lines.first.entries.length, 1);
    TargetEntry entry = map.lines.first.entries.first;

    expect(entry.column, 0);
    expect(entry.sourceUrlId, null);
    expect(entry.sourceColumn, null);
    expect(entry.sourceLine, null);
    expect(entry.sourceNameId, null);
  });

  test('parse with source location and no name', () {
    SingleMapping map = parse(JSON.encode(MAP_WITH_SOURCE_LOCATION));
    expect(map.lines.length, 1);
    expect(map.lines.first.entries.length, 1);
    TargetEntry entry = map.lines.first.entries.first;

    expect(entry.column, 0);
    expect(entry.sourceUrlId, 0);
    expect(entry.sourceColumn, 0);
    expect(entry.sourceLine, 0);
    expect(entry.sourceNameId, null);
  });

  test('parse with source location and name', () {
    SingleMapping map = parse(JSON.encode(MAP_WITH_SOURCE_LOCATION_AND_NAME));
    expect(map.lines.length, 1);
    expect(map.lines.first.entries.length, 1);
    TargetEntry entry = map.lines.first.entries.first;

    expect(entry.sourceUrlId, 0);
    expect(entry.sourceUrlId, 0);
    expect(entry.sourceColumn, 0);
    expect(entry.sourceLine, 0);
    expect(entry.sourceNameId, 0);
  });

  test('parse with source root', () {
    var inputMap = new Map.from(MAP_WITH_SOURCE_LOCATION);
    inputMap['sourceRoot'] = '/pkg/';
    var mapping = parseJson(inputMap);
    expect(mapping.spanFor(0, 0).sourceUrl, Uri.parse("/pkg/input.dart"));
    expect(
        mapping
            .spanForLocation(
                new SourceLocation(0, sourceUrl: Uri.parse("ignored.dart")))
            .sourceUrl,
        Uri.parse("/pkg/input.dart"));

    var newSourceRoot = '/new/';

    mapping.sourceRoot = newSourceRoot;
    inputMap["sourceRoot"] = newSourceRoot;

    expect(mapping.toJson(), equals(inputMap));
  });

  test('parse with map URL', () {
    var inputMap = new Map.from(MAP_WITH_SOURCE_LOCATION);
    inputMap['sourceRoot'] = 'pkg/';
    var mapping = parseJson(inputMap, mapUrl: "file:///path/to/map");
    expect(mapping.spanFor(0, 0).sourceUrl,
        Uri.parse("file:///path/to/pkg/input.dart"));
  });

  group('parse with bundle', () {
    var mapping =
        parseJsonExtended(SOURCE_MAP_BUNDLE, mapUrl: "file:///path/to/map");

    test('simple', () {
      expect(
          mapping
              .spanForLocation(new SourceLocation(0,
                  sourceUrl: new Uri.file('/path/to/output.dart')))
              .sourceUrl,
          Uri.parse("file:///path/to/pkg/input1.dart"));
      expect(
          mapping
              .spanForLocation(new SourceLocation(0,
                  sourceUrl: new Uri.file('/path/to/output2.dart')))
              .sourceUrl,
          Uri.parse("file:///path/to/pkg/input2.dart"));
      expect(
          mapping
              .spanForLocation(new SourceLocation(0,
                  sourceUrl: new Uri.file('/path/to/3/output.dart')))
              .sourceUrl,
          Uri.parse("file:///path/to/pkg/input3.dart"));

      expect(
          mapping.spanFor(0, 0, uri: "file:///path/to/output.dart").sourceUrl,
          Uri.parse("file:///path/to/pkg/input1.dart"));
      expect(
          mapping.spanFor(0, 0, uri: "file:///path/to/output2.dart").sourceUrl,
          Uri.parse("file:///path/to/pkg/input2.dart"));
      expect(
          mapping.spanFor(0, 0, uri: "file:///path/to/3/output.dart").sourceUrl,
          Uri.parse("file:///path/to/pkg/input3.dart"));
    });

    test('package uris', () {
      expect(
          mapping
              .spanForLocation(new SourceLocation(0,
                  sourceUrl: Uri.parse('package:1/output.dart')))
              .sourceUrl,
          Uri.parse("file:///path/to/pkg/input1.dart"));
      expect(
          mapping
              .spanForLocation(new SourceLocation(0,
                  sourceUrl: Uri.parse('package:2/output2.dart')))
              .sourceUrl,
          Uri.parse("file:///path/to/pkg/input2.dart"));
      expect(
          mapping
              .spanForLocation(new SourceLocation(0,
                  sourceUrl: Uri.parse('package:3/output.dart')))
              .sourceUrl,
          Uri.parse("file:///path/to/pkg/input3.dart"));

      expect(mapping.spanFor(0, 0, uri: "package:1/output.dart").sourceUrl,
          Uri.parse("file:///path/to/pkg/input1.dart"));
      expect(mapping.spanFor(0, 0, uri: "package:2/output2.dart").sourceUrl,
          Uri.parse("file:///path/to/pkg/input2.dart"));
      expect(mapping.spanFor(0, 0, uri: "package:3/output.dart").sourceUrl,
          Uri.parse("file:///path/to/pkg/input3.dart"));
    });

    test('unmapped path', () {
      var span = mapping.spanFor(0, 0, uri: "unmapped_output.dart");
      expect(span.sourceUrl, Uri.parse("unmapped_output.dart"));
      expect(span.start.line, equals(0));
      expect(span.start.column, equals(0));

      span = mapping.spanFor(10, 5, uri: "unmapped_output.dart");
      expect(span.sourceUrl, Uri.parse("unmapped_output.dart"));
      expect(span.start.line, equals(10));
      expect(span.start.column, equals(5));
    });

    test('missing path', () {
      expect(() => mapping.spanFor(0, 0), throws);
    });

    test('incomplete paths', () {
      expect(mapping.spanFor(0, 0, uri: "output.dart").sourceUrl,
          Uri.parse("file:///path/to/pkg/input1.dart"));
      expect(mapping.spanFor(0, 0, uri: "output2.dart").sourceUrl,
          Uri.parse("file:///path/to/pkg/input2.dart"));
      expect(mapping.spanFor(0, 0, uri: "3/output.dart").sourceUrl,
          Uri.parse("file:///path/to/pkg/input3.dart"));
    });

    test('parseExtended', () {
      var mapping = parseExtended(JSON.encode(SOURCE_MAP_BUNDLE),
          mapUrl: "file:///path/to/map");

      expect(mapping.spanFor(0, 0, uri: "output.dart").sourceUrl,
          Uri.parse("file:///path/to/pkg/input1.dart"));
      expect(mapping.spanFor(0, 0, uri: "output2.dart").sourceUrl,
          Uri.parse("file:///path/to/pkg/input2.dart"));
      expect(mapping.spanFor(0, 0, uri: "3/output.dart").sourceUrl,
          Uri.parse("file:///path/to/pkg/input3.dart"));
    });

    test('build bundle incrementally', () {
      var mapping = new MappingBundle();

      mapping.addMapping(parseJson(MAP_WITH_SOURCE_LOCATION_AND_NAME_1,
          mapUrl: "file:///path/to/map"));
      expect(mapping.spanFor(0, 0, uri: "output.dart").sourceUrl,
          Uri.parse("file:///path/to/pkg/input1.dart"));

      expect(mapping.containsMapping("output2.dart"), isFalse);
      mapping.addMapping(parseJson(MAP_WITH_SOURCE_LOCATION_AND_NAME_2,
          mapUrl: "file:///path/to/map"));
      expect(mapping.containsMapping("output2.dart"), isTrue);
      expect(mapping.spanFor(0, 0, uri: "output2.dart").sourceUrl,
          Uri.parse("file:///path/to/pkg/input2.dart"));

      expect(mapping.containsMapping("3/output.dart"), isFalse);
      mapping.addMapping(parseJson(MAP_WITH_SOURCE_LOCATION_AND_NAME_3,
          mapUrl: "file:///path/to/map"));
      expect(mapping.containsMapping("3/output.dart"), isTrue);
      expect(mapping.spanFor(0, 0, uri: "3/output.dart").sourceUrl,
          Uri.parse("file:///path/to/pkg/input3.dart"));
    });

    // Test that the source map can handle cases where the uri passed in is
    // not from the expected host but it is still unambiguous which source
    // map should be used.
    test('different paths', () {
      expect(
          mapping
              .spanForLocation(new SourceLocation(0,
                  sourceUrl: Uri.parse('http://localhost/output.dart')))
              .sourceUrl,
          Uri.parse("file:///path/to/pkg/input1.dart"));
      expect(
          mapping
              .spanForLocation(new SourceLocation(0,
                  sourceUrl: Uri.parse('http://localhost/output2.dart')))
              .sourceUrl,
          Uri.parse("file:///path/to/pkg/input2.dart"));
      expect(
          mapping
              .spanForLocation(new SourceLocation(0,
                  sourceUrl: Uri.parse('http://localhost/3/output.dart')))
              .sourceUrl,
          Uri.parse("file:///path/to/pkg/input3.dart"));

      expect(
          mapping.spanFor(0, 0, uri: "http://localhost/output.dart").sourceUrl,
          Uri.parse("file:///path/to/pkg/input1.dart"));
      expect(
          mapping.spanFor(0, 0, uri: "http://localhost/output2.dart").sourceUrl,
          Uri.parse("file:///path/to/pkg/input2.dart"));
      expect(
          mapping
              .spanFor(0, 0, uri: "http://localhost/3/output.dart")
              .sourceUrl,
          Uri.parse("file:///path/to/pkg/input3.dart"));
    });
  });

  test('parse and re-emit', () {
    for (var expected in [
      EXPECTED_MAP,
      MAP_WITH_NO_SOURCE_LOCATION,
      MAP_WITH_SOURCE_LOCATION,
      MAP_WITH_SOURCE_LOCATION_AND_NAME
    ]) {
      var mapping = parseJson(expected);
      expect(mapping.toJson(), equals(expected));

      mapping = parseJsonExtended(expected);
      expect(mapping.toJson(), equals(expected));
    }
    // Invalid for this case
    expect(() => parseJson(SOURCE_MAP_BUNDLE as dynamic), throws);

    var mapping = parseJsonExtended(SOURCE_MAP_BUNDLE);
    expect(mapping.toJson(), equals(SOURCE_MAP_BUNDLE));
  });
}
