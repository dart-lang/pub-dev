// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:grinder/grinder.dart';
import "package:node_preamble/preamble.dart" as preamble;
import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart' as yaml;

/// Matches the version line in dart_style's pubspec.
final _versionPattern = new RegExp(r"^version: .*$", multiLine: true);

main(List<String> args) => grind(args);

@DefaultTask()
@Task()
validate() async {
  // Test it.
  await new TestRunner().testAsync();

  // Make sure it's warning clean.
  Analyzer.analyze("bin/format.dart", fatalWarnings: true);

  // Format it.
  Dart.run("bin/format.dart", arguments: ["-w", "."]);
}

@Task('Publish to npm')
npm() {
  var out = 'dist';

  var pubspec = yaml.loadYaml(getFile("pubspec.yaml").readAsStringSync());
  var homepage = pubspec["homepage"];
  var fileName = 'index.js';

  // Generate modified dart2js output suitable to run on node.
  var tempFile = new File('${Directory.systemTemp.path}/temp.js');

  Dart2js.compile(new File('tool/node_format_service.dart'),
      outFile: tempFile, categories: 'all');
  var dart2jsOutput = tempFile.readAsStringSync();
  new File('$out/$fileName').writeAsStringSync('''${preamble.getPreamble()}
self.exports = exports; // Temporary hack for Dart-JS Interop under node.
$dart2jsOutput''');

  new File('$out/package.json')
      .writeAsStringSync(const JsonEncoder.withIndent('  ').convert({
    "name": "dart-style",
    "version": pubspec["version"],
    "description": pubspec["description"],
    "main": fileName,
    "typings": "dart-style.d.ts",
    "scripts": {"test": "echo \"Error: no test specified\" && exit 1"},
    "repository": {"type": "git", "url": "git+$homepage"},
    "author": pubspec["author"],
    "license": "BSD",
    "bugs": {"url": "$homepage/issues"},
    "homepage": homepage
  }));
  run('npm', arguments: ['publish', out]);
}

/// Gets ready to publish a new version of the package.
///
/// To publish a version, you need to:
///
///   1. Make sure the version in the pubspec is a "-dev" number. This should
///      already be the case since you've already landed patches that change
///      the formatter and bumped to that as a consequence.
///
///   2. Run this task:
///
///         pub run grinder bump
///
///   3. Commit the change to a branch.
///
///   4. Send it out for review:
///
///         git cl upload
///
///   5. After the review is complete, land it:
///
///         git cl land
///
///   6. Tag the commit:
///
///         git tag -a "<version>" -m "<version>"
///         git push origin <version>
///
///   7. Publish the package:
///
///         pub lish
@Task()
@Depends(validate)
bump() async {
  // Read the version from the pubspec.
  var pubspecFile = getFile("pubspec.yaml");
  var pubspec = pubspecFile.readAsStringSync();
  var version = new Version.parse(yaml.loadYaml(pubspec)["version"]);

  // Require a "-dev" version since we don't otherwise know what to bump it to.
  if (!version.isPreRelease) throw "Cannot publish non-dev version $version.";

  // Don't allow versions like "1.2.3-dev+4" because it's not clear if the
  // user intended the "+4" to be discarded or not.
  if (version.build.isNotEmpty) throw "Cannot publish build version $version.";

  var bumped = new Version(version.major, version.minor, version.patch);

  // Update the version in the pubspec.
  pubspec = pubspec.replaceAll(_versionPattern, "version: $bumped");
  pubspecFile.writeAsStringSync(pubspec);

  // Update the version constant in bin/format.dart.
  var binFormatFile = getFile("bin/format.dart");
  var binFormat = binFormatFile.readAsStringSync().replaceAll(
      new RegExp(r'const version = "[^"]+";'), 'const version = "$bumped";');
  binFormatFile.writeAsStringSync(binFormat);
  log("Updated version to '$bumped'.");
}
