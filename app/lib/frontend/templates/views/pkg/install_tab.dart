// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/search/tags.dart';

import '../../../../package/models.dart';
import '../../../dom/dom.dart' as d;

d.Node installTabNode({
  required PackageVersion version,
  required List<String>? tags,
  required bool isDevDependency,
}) {
  final packageName = version.package;
  List<_ImportExample> importExamples;
  if (version.libraries!.contains('$packageName.dart')) {
    importExamples = <_ImportExample>[
      _ImportExample(packageName, '$packageName.dart'),
    ];
  } else {
    importExamples = version.libraries!
        .map((library) => _ImportExample(packageName, library))
        .toList();
  }

  final executables = version.pubspec!.executables?.keys.toList();
  executables?.sort();
  final hasExecutables = executables != null && executables.isNotEmpty;
  final useAsLibrary = !hasExecutables || importExamples.isNotEmpty;

  return d.fragment([
    if (hasExecutables) _useAsExecutable(version.package, executables),
    if (useAsLibrary) _useAsLibrary(version, tags, isDevDependency),
    if (importExamples.isNotEmpty) _useAsImport(importExamples),
  ]);
}

d.Node _useAsExecutable(String package, List<String> executables) {
  return d.fragment([
    d.h2(text: 'Use this package as an executable'),
    d.h3(text: 'Install it'),
    d.p(text: 'You can install the package from the command line:'),
    d.codeSnippet(
      language: 'shell',
      textToCopy: 'dart pub global activate $package',
      child: d.strong(text: 'dart pub global activate $package'),
    ),
    d.h3(text: 'Use it'),
    d.p(text: 'The package has the following executables:'),
    d.codeSnippet(
      language: 'shell',
      children: executables.map(
        (e) => d.fragment([
          d.text(r'$ '),
          d.strong(text: e),
          d.text('\n'),
        ]),
      ),
    ),
  ]);
}

d.Node _useAsLibrary(
  PackageVersion version,
  List<String>? tags,
  bool isDevDependency,
) {
  final isFlutterPackage = version.pubspec!.usesFlutter;
  final bool usePubGet = !isFlutterPackage ||
      tags == null ||
      tags.isEmpty ||
      tags.contains(SdkTag.sdkDart);
  final bool useFlutterPackagesGet =
      isFlutterPackage || (tags != null && tags.contains(SdkTag.sdkFlutter));
  final pubAddCommand =
      'pub add ${version.package}${isDevDependency ? ' --dev' : ''}';
  final exampleDepKey = isDevDependency ? 'dev_dependencies' : 'dependencies';
  final showEditorSupport = usePubGet || useFlutterPackagesGet;
  final flutterOnly = useFlutterPackagesGet && !usePubGet;

  return d.fragment([
    d.h2(text: 'Use this package as a library'),
    d.h3(text: 'Depend on it'),
    d.p(text: 'Run this command:'),
    if (usePubGet) _pubAddNode('Dart', 'dart $pubAddCommand'),
    if (useFlutterPackagesGet) _pubAddNode('Flutter', 'flutter $pubAddCommand'),
    d.p(children: [
      d.text('This will add a line like this to your package\'s '
          'pubspec.yaml (and run an implicit '),
      d.code(text: '${flutterOnly ? 'flutter' : 'dart'} pub get'),
      d.text('):'),
    ]),
    d.codeSnippet(
      language: 'yaml',
      children: [
        d.text('$exampleDepKey:\n  '),
        d.strong(text: '${version.package}: ^${version.version}'),
      ],
    ),
    if (showEditorSupport)
      d.p(children: [
        d.text('Alternatively, your editor might support '),
        if (!flutterOnly) d.code(text: 'dart pub get'),
        if (!flutterOnly && useFlutterPackagesGet) d.text(' or '),
        if (useFlutterPackagesGet) d.code(text: 'flutter pub get'),
        d.text('. Check the docs for your editor to learn more.'),
      ]),
  ]);
}

d.Node _pubAddNode(String sdkLabel, String command) {
  return d.fragment([
    d.p(text: 'With $sdkLabel:'),
    d.codeSnippet(
      language: 'shell',
      textToCopy: command,
      text: ' \$ $command',
    ),
  ]);
}

class _ImportExample {
  final String package;
  final String library;
  _ImportExample(this.package, this.library);
}

d.Node _useAsImport(List<_ImportExample> importExamples) {
  return d.fragment([
    d.h3(text: 'Import it'),
    d.p(text: 'Now in your Dart code, you can use:'),
    d.codeSnippet(
      language: 'dart',
      text: importExamples
          .map((e) => 'import \'package:${e.package}/${e.library}\';')
          .join('\n'),
    ),
  ]);
}
