// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_package_reader/pub_package_reader.dart';

const _knownTemplateDescriptions = <String>{
  // ex-stagehand templates, check latest versions in dart-lang/sdk's
  // pkg/dartdev/lib/src/templates/ directory:
  'a command-line application',
  'a sample command-line application',
  'a simple command-line application',
  'a starting point for dart libraries or applications',
  'a package containing shared dart libraries',
  'a web server built using the shelf package',
  'a server app using package:shelf',
  'a web app that uses angulardart components',
  'a web app that uses only core dart libraries',
  'an absolute bare-bones web app',
  'a simple stagexl web app',
  // Flutter templates, check latest version in flutter/flutter's
  // packages/flutter_tools/lib/src/commands/create.dart directory:
  'a new flutter project',
  'a new flutter module project',
  'a new flutter package project',
  'a new flutter plugin project',
  'a new flutter ffi plugin project',
};

const _knownTemplateReadmes = <String>{
  'todo: put a short description of the package here',
  'todo: list what your package can do',
  'todo: list prerequisites and provide or point to information on how to start using the package',
  'todo: include short and useful examples for package users',
  'todo: tell users more about the package',
};

/// Validates the `description` field in the `pubspec.yaml`.
Iterable<ArchiveIssue> validateKnownTemplateDescription(
    String description) sync* {
  final lower = description.toLowerCase();
  for (final text in _knownTemplateDescriptions) {
    final firstIndex = lower.indexOf(text);
    if (firstIndex >= 0) {
      final origText =
          description.substring(firstIndex, firstIndex + text.length);
      yield ArchiveIssue(
          '`description` contains a generic text fragment coming from package templates (`$origText`).\n'
          'Please follow the guides to describe your package:\n'
          'https://dart.dev/tools/pub/pubspec#description');
      break;
    }
  }
}

/// Validates that `README.md` at [path] inside the package archive with [content] does
/// not contain a `TODO` instruction from a known template.
Iterable<ArchiveIssue> validateKnownTemplateReadme(
    String? path, String? content) sync* {
  if (path == null || content == null) {
    return;
  }
  final lower = content.toLowerCase();
  for (final text in _knownTemplateReadmes) {
    final firstIndex = lower.indexOf(text);
    if (firstIndex >= 0) {
      final origText = content.substring(firstIndex, firstIndex + text.length);
      yield ArchiveIssue(
          '`$path` contains a generic text fragment coming from package templates (`$origText`).\n'
          'Please follow the guides to write great package pages:\n'
          'https://dart.dev/guides/libraries/writing-package-pages');
      break;
    }
  }
}
