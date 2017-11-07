import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:mirrors';

import 'package:args/args.dart';
import 'package:collection/collection.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parseFragment;
import 'package:markdown/markdown.dart' show markdownToHtml, ExtensionSet;
import 'package:path/path.dart' as p;

// Locate the "tool" directory. Use mirrors so that this works with the test
// package, which loads this suite into an isolate.
String get _currentDir => p
    .dirname((reflect(main) as ClosureMirror).function.location.sourceUri.path);

Future main(List<String> args) async {
  final parser = new ArgParser()
    ..addOption('section',
        help: 'Restrict tests to one section, provided after the option.')
    ..addFlag('raw',
        defaultsTo: false, help: 'raw JSON format', negatable: false)
    ..addFlag('update-files',
        defaultsTo: false,
        help: 'Update stats files in $_currentDir',
        negatable: false)
    ..addFlag('verbose',
        defaultsTo: false, help: 'verbose output', negatable: false)
    ..addOption('flavor',
        allowed: ['common_mark', 'gfm'], defaultsTo: 'common_mark')
    ..addFlag('help', defaultsTo: false, negatable: false);

  ArgResults options;

  try {
    options = parser.parse(args);
  } on FormatException catch (e) {
    stderr.writeln(e);
    print(parser.usage);
    exitCode = 64; // unix standard improper usage
    return;
  }

  if (options['help']) {
    print(parser.usage);
    return;
  }

  var specifiedSection = options['section'] as String;
  var raw = options['raw'] as bool;
  var verbose = options['verbose'] as bool;
  var updateFiles = options['update-files'] as bool;

  if (updateFiles && (raw || verbose || (specifiedSection != null))) {
    stderr.writeln('The `update-files` flag must be used by itself');
    print(parser.usage);
    exitCode = 64; // unix standard improper usage
    return;
  }

  final testPrefix = options['flavor'];

  ExtensionSet extensionSet;
  if (testPrefix == 'gfm') {
    extensionSet = ExtensionSet.gitHub;
  }

  var sections = _loadCommonMarkSections(testPrefix);

  var scores = new SplayTreeMap<String, SplayTreeMap<int, CompareLevel>>(
      compareAsciiLowerCaseNatural);

  sections.forEach((section, examples) {
    if (specifiedSection != null && section != specifiedSection) {
      return;
    }
    for (var e in examples) {
      var nestedMap = scores.putIfAbsent(
          section, () => new SplayTreeMap<int, CompareLevel>());

      nestedMap[e.example] =
          _compareResult(e, verbose, extensionSet: extensionSet);
    }
  });

  if (raw || updateFiles) {
    await _printRaw(testPrefix, scores, updateFiles);
  }

  if (!raw || updateFiles) {
    await _printFriendly(testPrefix, scores, updateFiles);
  }
}

CompareLevel _compareResult(CommonMarkTestCase expected, bool verboseFail,
    {ExtensionSet extensionSet}) {
  String output;
  try {
    output = markdownToHtml(expected.markdown, extensionSet: extensionSet);
  } catch (err, stackTrace) {
    if (verboseFail) {
      printVerboseFailure(
          'ERROR', expected, expected.html, 'Thrown: $err\n$stackTrace');
    }

    return CompareLevel.error;
  }

  if (expected.html == output) {
    return CompareLevel.strict;
  }

  var expectedParsed = parseFragment(expected.html);
  var actual = parseFragment(output);

  var looseMatch = _compareHtml(expectedParsed.children, actual.children);

  if (!looseMatch && verboseFail) {
    printVerboseFailure(
        'FAIL', expected, expectedParsed.outerHtml, actual.outerHtml);
  }

  return looseMatch ? CompareLevel.loose : CompareLevel.fail;
}

String indent(String s) => s.splitMapJoin('\n', onNonMatch: (n) => '    $n');

void printVerboseFailure(
    String message, CommonMarkTestCase test, String expected, String actual) {
  print('$message: http://spec.commonmark.org/0.27/#example-${test.example}');
  print('input:');
  print(indent(test.markdown));
  print('expected:');
  print(indent(expected));
  print('actual:');
  print(indent(actual));
  print('-----------------------');
}

enum CompareLevel { strict, loose, fail, error }

Object _convert(obj) {
  if (obj is CompareLevel) {
    switch (obj) {
      case CompareLevel.strict:
        return 'strict';
      case CompareLevel.error:
        return 'error';
      case CompareLevel.fail:
        return 'fail';
      case CompareLevel.loose:
        return 'loose';
      default:
        throw new ArgumentError("`$obj` is unknown.");
    }
  }
  if (obj is Map) {
    var map = {};
    obj.forEach((k, v) {
      var newKey = k.toString();
      map[newKey] = v;
    });
    return map;
  }
  return obj;
}

Future _printRaw(String testPrefix, Map scores, bool updateFiles) async {
  IOSink sink;
  if (updateFiles) {
    var path = p.join(_currentDir, '${testPrefix}_stats.json');
    print('Updating $path');
    var file = new File(path);
    sink = file.openWrite();
  } else {
    sink = stdout;
  }

  var encoder = const JsonEncoder.withIndent(' ', _convert);
  try {
    sink.writeln(encoder.convert(scores));
  } on JsonUnsupportedObjectError catch (e) {
    stderr.writeln(e.cause);
    stderr.writeln(e.unsupportedObject.runtimeType);
    rethrow;
  }

  await sink.flush();
  await sink.close();
}

Future _printFriendly(
    String testPrefix,
    SplayTreeMap<String, SplayTreeMap<int, CompareLevel>> scores,
    bool updateFiles) async {
  const countWidth = 4;

  var totalValid = 0;
  var totalExamples = 0;

  IOSink sink;
  if (updateFiles) {
    var path = p.join(_currentDir, '${testPrefix}_stats.txt');
    print('Updating $path');
    var file = new File(path);
    sink = file.openWrite();
  } else {
    sink = stdout;
  }

  scores.forEach((section, Map<int, CompareLevel> map) {
    var total = map.values.length;
    totalExamples += total;

    var sectionStrictCount =
        map.values.where((val) => val == CompareLevel.strict).length;

    var sectionLooseCount =
        map.values.where((val) => val == CompareLevel.loose).length;

    var sectionValidCount = sectionStrictCount + sectionLooseCount;

    totalValid += sectionValidCount;

    var pct = (100 * sectionValidCount / total).toStringAsFixed(1).padLeft(5);

    sink.writeln('${sectionValidCount.toString().padLeft(countWidth)} '
        'of ${total.toString().padLeft(countWidth)} '
        '– ${pct}%  $section');
  });

  var pct = (100 * totalValid / totalExamples).toStringAsFixed(1).padLeft(5);

  sink.writeln('${totalValid.toString().padLeft(countWidth)} '
      'of ${totalExamples.toString().padLeft(countWidth)} '
      '– ${pct}%  TOTAL');

  await sink.flush();
  await sink.close();
}

/// Compare two DOM trees for equality.
bool _compareHtml(
    List<Element> expectedElements, List<Element> actualElements) {
  if (expectedElements.length != actualElements.length) {
    return false;
  }

  for (var childNum = 0; childNum < expectedElements.length; childNum++) {
    var expected = expectedElements[childNum];
    var actual = actualElements[childNum];

    if (expected.runtimeType != actual.runtimeType) {
      return false;
    }

    if (expected.localName != actual.localName) {
      return false;
    }

    if (expected.attributes.length != actual.attributes.length) {
      return false;
    }

    var expectedAttrKeys = expected.attributes.keys.toList();
    expectedAttrKeys.sort();

    var actualAttrKeys = actual.attributes.keys.toList();
    actualAttrKeys.sort();

    for (var attrNum = 0; attrNum < actualAttrKeys.length; attrNum++) {
      var expectedAttrKey = expectedAttrKeys[attrNum];
      var actualAttrKey = actualAttrKeys[attrNum];

      if (expectedAttrKey != actualAttrKey) {
        return false;
      }

      if (expected.attributes[expectedAttrKey] !=
          actual.attributes[actualAttrKey]) {
        return false;
      }
    }

    var childrenEqual = _compareHtml(expected.children, actual.children);

    if (!childrenEqual) {
      return false;
    }
  }

  return true;
}

Map<String, List<CommonMarkTestCase>> _loadCommonMarkSections(
    String testPrefix) {
  var testFile = new File(p.join(_currentDir, '${testPrefix}_tests.json'));
  var testsJson = testFile.readAsStringSync();

  var testArray = JSON.decode(testsJson) as List<Map<String, dynamic>>;

  var sections = new Map<String, List<CommonMarkTestCase>>();

  for (var exampleMap in testArray) {
    var exampleTest = new CommonMarkTestCase.fromJson(exampleMap);

    var sectionList =
        sections.putIfAbsent(exampleTest.section, () => <CommonMarkTestCase>[]);

    sectionList.add(exampleTest);
  }

  return sections;
}

class CommonMarkTestCase {
  final String markdown;
  final String section;
  final int example;
  final String html;
  final int startLine;
  final int endLine;

  CommonMarkTestCase(this.example, this.section, this.startLine, this.endLine,
      this.markdown, this.html);

  factory CommonMarkTestCase.fromJson(Map<String, dynamic> json) {
    return new CommonMarkTestCase(json['example'], json['section'],
        json['start_line'], json['end_line'], json['markdown'], json['html']);
  }
}
