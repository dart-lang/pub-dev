// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart' show YamlException, loadYaml;
import 'package:logging/logging.dart';

import 'src/archive_surface.dart';
import 'src/file_names.dart';
import 'src/names.dart';
import 'src/tar_utils.dart';
import 'src/yaml_utils.dart';

final _logger = Logger('pub_package_reader');

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
  final String? pubspecContent;
  final String? readmePath;
  final String? readmeContent;
  final String? changelogPath;
  final String? changelogContent;
  final String? examplePath;
  final String? exampleContent;
  final String? licensePath;
  final String? licenseContent;
  final List<String>? libraries;

  PackageSummary({
    List<ArchiveIssue>? issues,
    this.pubspecContent,
    this.readmePath,
    this.readmeContent,
    this.changelogPath,
    this.changelogContent,
    this.examplePath,
    this.exampleContent,
    this.licensePath,
    this.licenseContent,
    this.libraries,
  }) : issues = issues ?? <ArchiveIssue>[];

  factory PackageSummary.fail(ArchiveIssue issue) =>
      PackageSummary(issues: [issue]);

  bool get hasIssues => issues.isNotEmpty;
}

/// Observe the .tar.gz archive on [archivePath] and return the results.
Future<PackageSummary> summarizePackageArchive(
  String archivePath, {

  /// The maximum length of the extracted content text.
  int maxContentLength = 128 * 1024,

  /// The maximum file size of the archive (gzipped or compressed) and
  /// the maximum total size of the files inside the archive.
  int maxArchiveSize = 100 * 1024 * 1024,

  /// The maximum number of files in the archive.
  /// TODO: set this lower once we scan the existing archives
  int maxFileCount = 64 * 1024,
}) async {
  final issues = <ArchiveIssue>[];

  // Run scans before tar parsing...
  issues.addAll(
      await scanArchiveSurface(archivePath, maxArchiveSize: maxArchiveSize)
          .toList());
  if (issues.isNotEmpty) {
    return PackageSummary(issues: issues);
  }

  TarArchive tar;
  try {
    tar = await TarArchive.scan(
      archivePath,
      maxFileCount: maxFileCount,
      maxTotalLengthBytes: maxArchiveSize,
    );
  } catch (e, st) {
    _logger.info('Failed to scan tar archive.', e, st);
    return PackageSummary.fail(
        ArchiveIssue('Failed to scan tar archive. ($e)'));
  }

  // symlinks check
  final brokenSymlinks = tar.brokenSymlinks();
  if (brokenSymlinks.isNotEmpty) {
    final from = brokenSymlinks.keys.first;
    final to = brokenSymlinks[from];
    return PackageSummary.fail(ArchiveIssue(
        'Package archive contains a broken symlink: `$from` -> `$to`.'));
  }

  // processing pubspec.yaml
  final pubspecPath = tar.searchForFile(['pubspec.yaml']);
  if (pubspecPath == null) {
    issues.add(ArchiveIssue('pubspec.yaml is missing.'));
    return PackageSummary(issues: issues);
  }

  final pubspecContent = await tar.readContentAsString(pubspecPath);
  // Large pubspec content should be rejected, as either a storage limit will be
  // limiting it, or it will slow down queries and processing for very little
  // reason.
  if (pubspecContent.length > 128 * 1024) {
    issues.add(ArchiveIssue('pubspec.yaml is too large.'));
  }

  // Reject packages using aliases in `pubspec.yaml`, these are poorly supported
  // when transcoding to json.
  if (yamlContainsAliases(pubspecContent)) {
    issues.add(ArchiveIssue(
      'pubspec.yaml may not use references (alias/anchors), '
      'only the subset of YAML that can be encoded as JSON is allowed.',
    ));
    return PackageSummary(issues: issues);
  }

  Pubspec? pubspec;
  try {
    pubspec = Pubspec.parse(pubspecContent);
  } on YamlException catch (e) {
    issues.add(ArchiveIssue('Error parsing pubspec.yaml: $e'));
    return PackageSummary(issues: issues);
  } on Exception catch (e) {
    issues.add(ArchiveIssue('Error parsing pubspec.yaml: $e'));
  }
  // Try again with lenient parsing.
  try {
    pubspec ??= Pubspec.parse(pubspecContent, lenient: true);
  } on Exception catch (e) {
    issues.add(ArchiveIssue('Error parsing pubspec.yaml: $e'));
    return PackageSummary(issues: issues);
  }
  issues.addAll(checkValidJson(pubspecContent));
  issues.addAll(checkAuthors(pubspecContent));
  issues.addAll(checkSdkVersionRange(pubspec));
  // Check whether the files can be extracted on case-preserving file systems
  // (e.g. on Windows). We can't allow two files with the same case-insensitive
  // name.
  final lowerCaseFiles = <String, List<String>>{};
  for (final file in tar.fileNames) {
    final lower = file.toLowerCase();
    lowerCaseFiles.putIfAbsent(lower, () => <String>[]).add(file);
  }
  final fileNameCollisions =
      lowerCaseFiles.values.firstWhereOrNull((l) => l.length > 1);
  if (fileNameCollisions != null) {
    issues.add(ArchiveIssue(
        'Filename collision on case-preserving file systems: ${fileNameCollisions.join(' vs. ')}.'));
  }

  if (pubspec.name.trim().isEmpty) {
    issues.add(ArchiveIssue('pubspec.yaml is missing `name`.'));
    return PackageSummary(issues: issues);
  }
  if (pubspec.version == null) {
    issues.add(ArchiveIssue('pubspec.yaml is missing `version`.'));
    return PackageSummary(issues: issues);
  }

  final package = pubspec.name;

  Future<String?> extractContent(String? contentPath) async {
    if (contentPath == null) return null;
    final content =
        await tar.readContentAsString(contentPath, maxLength: maxContentLength);
    if (content.trim().isEmpty) {
      return null;
    }
    if (utf8.encode(content).length > maxContentLength) {
      issues.add(ArchiveIssue(
          '`$contentPath` exceeds the maximum content length ($maxContentLength bytes).'));
    }
    return content;
  }

  String? readmePath = tar.searchForFile(readmeFileNames);
  final readmeContent = await extractContent(readmePath);
  if (readmeContent == null) {
    readmePath = null;
  }

  String? changelogPath = tar.searchForFile(changelogFileNames);
  final changelogContent = await extractContent(changelogPath);
  if (changelogContent == null) {
    changelogPath = null;
  }

  String? examplePath = tar.searchForFile(exampleFileCandidates(package));
  final exampleContent = await extractContent(examplePath);
  if (exampleContent == null) {
    examplePath = null;
  }

  String? licensePath = tar.searchForFile(licenseFileNames);
  final licenseContent = await extractContent(licensePath);
  if (licenseContent == null) {
    licensePath = null;
  }

  final libraries = tar.fileNames
      .where((file) => file.startsWith('lib/'))
      .where((file) => !file.startsWith('lib/src'))
      .where((file) => file.endsWith('.dart'))
      .map((file) => file.substring('lib/'.length))
      .toList();

  issues.addAll(validatePackageName(pubspec.name));
  issues.addAll(validatePackageVersion(pubspec.version));
  issues.addAll(syntaxCheckUrl(pubspec.homepage, 'homepage'));
  issues.addAll(syntaxCheckUrl(pubspec.repository?.toString(), 'repository'));
  issues.addAll(syntaxCheckUrl(pubspec.documentation, 'documentation'));
  issues
      .addAll(syntaxCheckUrl(pubspec.issueTracker?.toString(), 'issueTracker'));
  issues.addAll(validateDependencies(pubspec));
  issues.addAll(forbidGitDependencies(pubspec));
  // TODO: re-enable or remove after version pinning gets resolved
  //       https://github.com/dart-lang/pub/issues/2557
  // issues.addAll(forbidPreReleaseSdk(pubspec));
  issues.addAll(requireIosFolderOrFlutter2_20(pubspec, tar.fileNames));
  issues.addAll(requireNonEmptyLicense(licensePath, licenseContent));

  return PackageSummary(
    issues: issues,
    pubspecContent: pubspecContent,
    readmePath: readmePath,
    readmeContent: readmeContent,
    changelogPath: changelogPath,
    changelogContent: changelogContent,
    examplePath: examplePath,
    exampleContent: exampleContent,
    licensePath: licensePath,
    licenseContent: licenseContent,
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

/// Sanity checks for the package's version.
Iterable<ArchiveIssue> validatePackageVersion(Version? version) sync* {
  if (version.toString().length > 64) {
    yield ArchiveIssue('Package version must not exceed 64 characters. '
        '(Please file an issue if you think you have a good reason for a longer version.)');
  }
}

/// Checks if the pubspec has both `author` and `authors` specified.
Iterable<ArchiveIssue> checkAuthors(String pubspecContent) sync* {
  final map = loadYaml(pubspecContent);
  if (map is Map && map.containsKey('author') && map.containsKey('authors')) {
    yield ArchiveIssue(
        'Do not specify both `author` and `authors` in `pubspec.yaml`.');
  }
}

final _preDart3 = VersionConstraint.parse('<3.0.0');
final _firstDart3Pre = Version.parse('3.0.0').firstPreRelease;

/// Checks if the version range is acceptable by current SDKs.
Iterable<ArchiveIssue> checkSdkVersionRange(Pubspec pubspec) sync* {
  final sdk = pubspec.environment?['sdk'];
  if (sdk == null ||
      sdk.isAny ||
      sdk is! VersionRange ||
      sdk.min == null ||
      sdk.min!.isAny ||
      sdk.max == null ||
      sdk.max!.isAny) {
    yield ArchiveIssue(
        'Dart SDK constraint with min and max range must be specified.');
    return;
  }

  // No known version exists.
  if (sdk.intersect(_preDart3).isEmpty) {
    yield ArchiveIssue('SDK constraint does not allow any known Dart SDK.');
  }

  // Dart 3 version accepted with valid upper constraint.
  if (sdk.allows(_firstDart3Pre)) {
    yield ArchiveIssue(
        'The SDK constraint allows Dart 3.0.0, this is not allowed because Dart 3 does not exist.');
  }
}

/// Removes extra characters from the package name
String reducePackageName(String name) =>
    // we allow only `_` as part of the name.
    name.replaceAll('_', '').toLowerCase();

Iterable<ArchiveIssue> syntaxCheckUrl(String? url, String name) sync* {
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
  if (uri.host.isEmpty ||
      !uri.host.contains('.') ||
      invalidHostNames.contains(uri.host)) {
    final titleCaseName = name[0].toUpperCase() + name.substring(1);
    yield ArchiveIssue('$titleCaseName URL has no valid host: $url');
  }
}

/// Validate that the package does not have too many dependencies.
///
/// It ignores `dev_dependencies` as these are for development only.
Iterable<ArchiveIssue> validateDependencies(Pubspec pubspec) sync* {
  // This is not an inherently hard limit, it's merely a sanity limitation.
  if (pubspec.dependencies.length > 100) {
    yield ArchiveIssue('Package must not exceed 128 direct dependencies. '
        '(Please file an issue if you think you have a good reason for more dependencies.)');
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
    if (dep.hosted!.url != null) {
      yield ArchiveIssue(
        'Package dependency $name must be hosted on the default pub '
        'repository, and cannot have an explicit "url" specified',
      );
    }
    if (dep.hosted!.name != name) {
      yield ArchiveIssue(
        'Package dependency $name depends on a package with a different name',
      );
    }
  }
}

/// Check wether the pubspecContent can be converted to JSON
Iterable<ArchiveIssue> checkValidJson(String pubspecContent) sync* {
  try {
    final map = loadYaml(pubspecContent) as Map?;
    json.decode(json.encode(map)) as Map<String, dynamic>?;
  } on JsonUnsupportedObjectError catch (_) {
    yield ArchiveIssue(
        'pubspec.yaml contains values that can\'t be converted to JSON.');
  } on Exception catch (e, st) {
    _logger.warning('Error while converting pubspec.yaml to JSON', e, st);
  }
}

/// Validate that the package does not have a lower dependency on a pre-release
/// Dart SDK, which is only allowed if the package itself is a pre-release.
Iterable<ArchiveIssue> forbidPreReleaseSdk(Pubspec pubspec) sync* {
  if (pubspec.version!.isPreRelease) return;
  final sdkConstraint = pubspec.environment!['sdk'];
  if (sdkConstraint is VersionRange) {
    if (sdkConstraint.min != null && sdkConstraint.min!.isPreRelease) {
      yield ArchiveIssue(
          'Packages with an SDK constraint on a pre-release of the Dart SDK '
          'should themselves be published as a pre-release version. ');
    }
  }
}

const _pluginDocsUrl =
    'https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin';

/// Validate that the package does not have both `flutter.plugin.platforms` and
/// `flutter.plugin.{androidPackage,iosPrefix,pluginClass}`.
Iterable<ArchiveIssue> forbidConflictingFlutterPluginSchemes(
  Pubspec pubspec,
) sync* {
  if (pubspec.flutter is! Map || pubspec.flutter!['plugin'] is! Map) {
    return;
  }
  final plugin = pubspec.flutter!['plugin'] as Map;

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

  if (usesOldPluginFormat && usesNewPluginFormat) {
    yield ArchiveIssue(
        'In pubspec.yaml the flutter.plugin.platforms key cannot be '
        'used in combination with the old '
        'flutter.plugin.{androidPackage,iosPrefix,pluginClass} keys.\n\n'
        'See $_pluginDocsUrl');
  }

  if (usesNewPluginFormat &&
      (pubspec.environment == null ||
          pubspec.environment!['flutter'] == null ||
          pubspec.environment!['flutter']!.allowsAny(VersionRange(
            min: Version.parse('0.0.0'),
            max: Version.parse('1.10.0'),
            includeMin: true,
            includeMax: false,
          )))) {
    yield ArchiveIssue(
      'pubspec.yaml allows Flutter SDK version 1.9.x, which does '
      'not support the flutter.plugin.platforms key.\n'
      'Please consider increasing the Flutter SDK requirement to '
      '^1.10.0 (environment.sdk.flutter)\n\nSee $_pluginDocsUrl',
    );
  }
}

/// Validate that the package does not have both `flutter.plugin.platforms` and
/// `flutter.plugin.{androidPackage,iosPrefix,pluginClass}`.
Iterable<ArchiveIssue> requireIosFolderOrFlutter2_20(
  Pubspec pubspec,
  List<String> files,
) sync* {
  if (pubspec.flutter is! Map || pubspec.flutter!['plugin'] is! Map) {
    return;
  }
  final plugin = pubspec.flutter!['plugin'] as Map;

  // Determine if this uses the new format by check if the:
  // `flutter.plugin.platforms` keys is defined.
  final usesNewPluginFormat = plugin['platforms'] != null;

  if (usesNewPluginFormat &&
      (pubspec.environment == null ||
          pubspec.environment!['flutter'] == null ||
          pubspec.environment!['flutter']!.allowsAny(VersionRange(
            min: Version.parse('0.0.0'),
            max: Version.parse('1.20.0'),
            includeMin: true,
            includeMax: false,
          ))) &&
      !files.any((f) => f.startsWith('ios/'))) {
    yield ArchiveIssue(
        'pubspec.yaml allows Flutter SDK version prior to 1.20.0, which does '
        'not support having no `ios/` folder.\n'
        'Please consider increasing the Flutter SDK requirement to '
        '^1.20.0 or higher (environment.sdk.flutter) or create an `ios/` folder.\n\nSee $_pluginDocsUrl');
  }
}

Iterable<ArchiveIssue> requireNonEmptyLicense(
    String? path, String? content) sync* {
  if (path == null) {
    yield ArchiveIssue('LICENSE file not found.');
    return;
  }
  if (content == null || content.trim().isEmpty) {
    yield ArchiveIssue('LICENSE file `$path` has no content.');
    return;
  }
  if (content.toLowerCase().contains('todo: add your license here.')) {
    yield ArchiveIssue('LICENSE file `$path` contains generic TODO.');
    return;
  }
}
