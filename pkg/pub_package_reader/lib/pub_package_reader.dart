// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:pub_semver/pub_semver.dart';

import 'src/file_names.dart';
import 'src/names.dart';
import 'src/tar_utils.dart';

// The maximum stored length of `README.md` and other user-provided file content
// that is stored separately in the database.
final _maxStoredLength = 128 * 1024;

/// A validation issue in the package archive.
class ArchiveIssue {
  /// An error message that will be displayed to the developer or pub client.
  final String message;

  ArchiveIssue(this.message);

  @override
  String toString() => message;
}

/// The observed / extracted information of a package archive.
class PackageSummary {
  final List<ArchiveIssue> issues;
  final String pubspecContent;
  final String readmePath;
  final String readmeContent;
  final String changelogPath;
  final String changelogContent;
  final String examplePath;
  final String exampleContent;
  final List<String> libraries;

  PackageSummary({
    this.issues,
    this.pubspecContent,
    this.readmePath,
    this.readmeContent,
    this.changelogPath,
    this.changelogContent,
    this.examplePath,
    this.exampleContent,
    this.libraries,
  });

  bool get hasIssues => issues != null && issues.isNotEmpty;
}

/// Observe the .tar.gz archive on [archivePath] and return the results.
Future<PackageSummary> summarizePackageArchive(String archivePath) async {
  final issues = <ArchiveIssue>[];
  final files = await listTarball(archivePath);

  // Searches in [files] for a file name [name] and compare in a
  // case-insensitive manner.
  //
  // Returns `null` if not found otherwise the correct filename.
  String searchForFile(Iterable<String> names) {
    for (String name in names) {
      final String nameLowercase = name.toLowerCase();
      for (String filename in files) {
        if (filename.toLowerCase() == nameLowercase) {
          return filename;
        }
      }
    }
    return null;
  }

  // processing pubspec.yaml
  if (!files.contains('pubspec.yaml')) {
    issues.add(ArchiveIssue('pubspec.yaml is missing.'));
    return PackageSummary(issues: issues);
  }

  final pubspecContent = await readTarballFile(archivePath, 'pubspec.yaml');
  // Large pubspec content should be rejected, as either a storage limit will be
  // limiting it, or it will slow down queries and processing for very little
  // reason.
  if (pubspecContent.length > 128 * 1024) {
    issues.add(ArchiveIssue('pubspec.yaml is too large.'));
  }
  Pubspec pubspec;
  try {
    pubspec = Pubspec.parse(pubspecContent);
  } catch (e) {
    pubspec = Pubspec.parse(pubspecContent, lenient: true);
    issues.add(ArchiveIssue('Error parsing pubspec.yaml: $e'));
  }

  // Check whether the files can be extracted on case-preserving file systems
  // (e.g. on Windows). We can't allow two files with the same case-insensitive
  // name.
  final lowerCaseFiles = <String, List<String>>{};
  for (String file in files) {
    final lower = file.toLowerCase();
    lowerCaseFiles.putIfAbsent(lower, () => <String>[]).add(file);
  }
  final fileNameCollisions =
      lowerCaseFiles.values.firstWhere((l) => l.length > 1, orElse: () => null);
  if (fileNameCollisions != null) {
    issues.add(ArchiveIssue(
        'Filename collision on case-preserving file systems: ${fileNameCollisions.join(' vs. ')}.'));
  }

  if (pubspec.name == null || pubspec.name.trim().isEmpty) {
    issues.add(ArchiveIssue('pubspec.yaml is missing `name`.'));
    return PackageSummary(issues: issues);
  }
  if (pubspec.version == null) {
    issues.add(ArchiveIssue('pubspec.yaml is missing `version`.'));
  }

  final package = pubspec.name;

  Future<String> extractContent(String contentPath) async {
    if (contentPath == null) return null;
    final content = await readTarballFile(archivePath, contentPath,
        maxLength: _maxStoredLength);
    if (content != null && content.trim().isEmpty) {
      return null;
    }
    return content;
  }

  String readmePath = searchForFile(readmeFileNames);
  final readmeContent = await extractContent(readmePath);
  if (readmeContent == null) {
    readmePath = null;
  }

  String changelogPath = searchForFile(changelogFileNames);
  final changelogContent = await extractContent(changelogPath);
  if (changelogContent == null) {
    changelogPath = null;
  }

  String examplePath = searchForFile(exampleFileCandidates(package));
  final exampleContent = await extractContent(examplePath);
  if (exampleContent == null) {
    examplePath = null;
  }

  final libraries = files
      .where((file) => file.startsWith('lib/'))
      .where((file) => !file.startsWith('lib/src'))
      .where((file) => file.endsWith('.dart'))
      .map((file) => file.substring('lib/'.length))
      .toList();

  issues.addAll(validatePackageName(pubspec.name));
  issues.addAll(syntaxCheckUrl(pubspec.homepage, 'homepage'));
  issues.addAll(syntaxCheckUrl(pubspec.repository?.toString(), 'repository'));
  issues.addAll(forbidGitDependencies(pubspec));

  return PackageSummary(
    issues: issues,
    pubspecContent: pubspecContent,
    readmePath: readmePath,
    readmeContent: readmeContent,
    changelogPath: changelogPath,
    changelogContent: changelogContent,
    examplePath: examplePath,
    exampleContent: exampleContent,
    libraries: libraries,
  );
}

/// Sanity checks if the user would upload a package with a modified pub client
/// that skips these verifications.
/// TODO: share code to use the same validations as in
/// https://github.com/dart-lang/pub/blob/master/lib/src/validator/name.dart#L52
Iterable<ArchiveIssue> validatePackageName(String name) sync* {
  if (!identifierExpr.hasMatch(name)) {
    yield ArchiveIssue(
        'Package name may only contain letters, numbers, and underscores.');
  }
  if (!startsWithLetterOrUnderscore.hasMatch(name)) {
    yield ArchiveIssue('Package name must begin with a letter or underscore.');
  }
  if (reservedWords.contains(reducePackageName(name))) {
    yield ArchiveIssue('Package name must not be a reserved word in Dart.');
  }

  if (name.length > 64) {
    yield ArchiveIssue('Package name must not exceed 64 characters. '
        '(Please file an issue if you think you have a good reason for a longer name.)');
  }

  final bool isLower = name == name.toLowerCase();
  final bool matchesMixedCase = knownMixedCasePackages.contains(name);
  if (!isLower && !matchesMixedCase) {
    yield ArchiveIssue('Package name must be lowercase.');
  }
  if (isLower && blockedLowerCasePackages.contains(name)) {
    yield ArchiveIssue('Name collision with mixed-case package.');
  }
  if (!isLower &&
      matchesMixedCase &&
      !blockedLowerCasePackages.contains(name.toLowerCase())) {
    yield ArchiveIssue('Name collision with mixed-case package.');
  }
}

/// Removes extra characters from the package name
String reducePackageName(String name) =>
    // we allow only `_` as part of the name.
    name.replaceAll('_', '').toLowerCase();

Iterable<ArchiveIssue> syntaxCheckUrl(String url, String name) sync* {
  if (url == null) {
    return;
  }
  final uri = Uri.tryParse(url);
  if (uri == null) {
    yield ArchiveIssue('Unable to parse $name URL: $url');
    return;
  }
  final hasValidScheme = uri.scheme == 'http' || uri.scheme == 'https';
  if (!hasValidScheme) {
    yield ArchiveIssue(
        'Use http:// or https:// URL schemes for $name URL: $url');
  }
  if (uri.host == null ||
      uri.host.isEmpty ||
      !uri.host.contains('.') ||
      invalidHostNames.contains(uri.host)) {
    final titleCaseName = name[1].toUpperCase() + name.substring(1);
    yield ArchiveIssue('$titleCaseName URL has no valid host: $url');
  }
}

/// Validate that the package does not have any git dependencies.
///
/// This also enforces that `dependencies` are hosted on the default pub server.
/// It ignores `dev_dependencies` as these are for development only.
Iterable<ArchiveIssue> forbidGitDependencies(Pubspec pubspec) sync* {
  for (final entry in pubspec.dependencies.entries) {
    final name = entry.key;

    if (entry.value is GitDependency) {
      yield ArchiveIssue(
        'Package dependency $name is a git dependency, '
        'this is not allowed in published packages.',
      );
      continue;
    }

    if (entry.value is SdkDependency) {
      // allow any SDK dependency
      continue;
    }

    if (entry.value is! HostedDependency) {
      yield ArchiveIssue('Package dependency $name is not hosted on pub.dev');
      continue;
    }

    final dep = entry.value as HostedDependency;
    if (dep.hosted == null) {
      continue;
    }
    if (dep.hosted.url != null) {
      yield ArchiveIssue(
        'Package dependency $name must be hosted on the default pub '
        'repository, and cannot have an explicit "url" specified',
      );
    }
    if (dep.hosted.name != name) {
      yield ArchiveIssue(
        'Package dependency $name depends on a package with a different name',
      );
    }
  }
}

/// Validate that the package does not have both `flutter.plugin.platforms` and
/// `flutter.plugin.{androidPackage,iosPrefix,pluginClass}`.
Iterable<ArchiveIssue> forbidConflictingFlutterPluginSchemes(
  Pubspec pubspec,
) sync* {
  if (pubspec.flutter is! Map || pubspec.flutter['plugin'] is! Map) {
    return;
  }
  final plugin = pubspec.flutter['plugin'] as Map;

  // Determine if this uses the old format by checking if `flutter.plugin`
  // contains any of the following keys.
  final usesOldPluginFormat = const {
    'androidPackage',
    'iosPrefix',
    'pluginClass',
  }.any(plugin.containsKey);

  // Determine if this uses the new format by check if the:
  // `flutter.plugin.platforms` keys is defined.
  final usesNewPluginFormat = plugin['platforms'] != null;

  const pluginDocsUrl =
      'https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin';

  if (usesOldPluginFormat && usesNewPluginFormat) {
    yield ArchiveIssue(
        'In pubspec.yaml the flutter.plugin.platforms key cannot be '
        'used in combination with the old '
        'flutter.plugin.{androidPackage,iosPrefix,pluginClass} keys.\n\n'
        'See $pluginDocsUrl');
  }

  if (usesNewPluginFormat &&
      (pubspec.environment == null ||
          pubspec.environment['flutter'] == null ||
          pubspec.environment['flutter'].allowsAny(VersionRange(
            min: Version.parse('0.0.0'),
            max: Version.parse('1.10.0'),
            includeMin: true,
            includeMax: false,
          )))) {
    yield ArchiveIssue(
      'pubspec.yaml allows Flutter SDK version 1.9.x, which does '
      'not support the flutter.plugin.platforms key.\n'
      'Please consider increasing the Flutter SDK requirement to '
      '^1.10.0 (environment.sdk.flutter)\n\nSee $pluginDocsUrl',
    );
  }
}
