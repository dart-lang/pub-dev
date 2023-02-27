// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:yaml/yaml.dart' show YamlException, loadYaml;

import 'src/archive_surface.dart';
import 'src/check_platforms.dart';
import 'src/emoji_ranges.dart';
import 'src/file_names.dart';
import 'src/known_templates.dart';
import 'src/names.dart';
import 'src/pubspec_content_override.dart';
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

  /// [DateTime] when the archive was uploaded / published.
  ///
  /// Used to ensure that constraints in place when a package was published
  /// are considered when summarizing assets. Ensuring we preserve
  /// backwards-compatibility with packages that does not satisfy constraints
  /// enforced at publish-time today.
  ///
  /// Defaults to [DateTime.now], if not specified.
  DateTime? published,
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
  final pubspecPath = tar.firstMatchingFileNameOrNull(['pubspec.yaml']);
  if (pubspecPath == null) {
    issues.add(ArchiveIssue('pubspec.yaml is missing.'));
    return PackageSummary(issues: issues);
  }

  final pubspecContent = overridePubspecYamlIfNeeded(
    pubspecYaml: await tar.readContentAsString(pubspecPath),
    published: published ?? clock.now().toUtc(),
  );
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
  issues.addAll(checkPlatforms(pubspecContent));
  issues.addAll(checkStrictVersions(pubspec));
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

  String? readmePath = tar.firstMatchingFileNameOrNull(readmeFileNames);
  String? changelogPath = tar.firstMatchingFileNameOrNull(changelogFileNames);
  String? examplePath =
      tar.firstMatchingFileNameOrNull(exampleFileCandidates(pubspec.name));
  String? licensePath = tar.firstMatchingFileNameOrNull(licenseFileNames);

  final contentBytes = await tar.scanAndReadFiles(
    [readmePath, changelogPath, examplePath, licensePath]
        .whereType<String>()
        .toList(),
    maxLength: maxContentLength,
  );

  String? tryParseContentBytes(String? contentPath) {
    if (contentPath == null) return null;
    final bytes = contentBytes[contentPath];
    if (bytes == null) return null;
    if (bytes.length > maxContentLength) {
      issues.add(ArchiveIssue(
          '`$contentPath` exceeds the maximum content length ($maxContentLength bytes).'));
    }
    String content = utf8.decode(bytes, allowMalformed: true);
    if (content.length > maxContentLength) {
      content = content.substring(0, maxContentLength) + '[...]\n\n';
    }
    return content;
  }

  final readmeContent = tryParseContentBytes(readmePath);
  if (readmeContent == null) {
    readmePath = null;
  }
  final changelogContent = tryParseContentBytes(changelogPath);
  if (changelogContent == null) {
    changelogPath = null;
  }
  final exampleContent = tryParseContentBytes(examplePath);
  if (exampleContent == null) {
    examplePath = null;
  }
  final licenseContent = tryParseContentBytes(licensePath);
  issues.addAll(requireNonEmptyLicense(licensePath, licenseContent));
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
  issues.addAll(validatePublishTo(pubspec.publishTo));
  issues.addAll(validateDescription(pubspec.description));
  issues.addAll(validateZalgo('description', pubspec.description));
  issues.addAll(syntaxCheckUrl(pubspec.homepage, 'homepage'));
  issues.addAll(syntaxCheckUrl(pubspec.repository?.toString(), 'repository'));
  issues.addAll(syntaxCheckUrl(pubspec.documentation, 'documentation'));
  issues
      .addAll(syntaxCheckUrl(pubspec.issueTracker?.toString(), 'issueTracker'));
  issues.addAll(validateEnvironmentKeys(pubspec));
  issues.addAll(validateDependencies(pubspec));
  issues.addAll(forbidGitDependencies(pubspec));
  issues.addAll(requireIosFolderOrFlutter2_20(pubspec, tar.fileNames));
  issues.addAll(checkScreenshots(pubspec, tar.fileNames));
  issues.addAll(validateKnownTemplateReadme(readmePath, readmeContent));
  issues.addAll(checkFunding(pubspecContent));

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
/// that skips these verifications. This checks only basic package name patterns.
Iterable<ArchiveIssue> validatePackageName(String name) sync* {
  if (!identifierExpr.hasMatch(name)) {
    yield ArchiveIssue(
        'Package name may only contain letters, numbers, and underscores.');
  }
  if (!startsWithLetterOrUnderscore.hasMatch(name)) {
    yield ArchiveIssue('Package name must begin with a letter or underscore.');
  }

  if (name.length > 64) {
    yield ArchiveIssue('Package name must not exceed 64 characters. '
        '(Please file an issue if you think you have a good reason for a longer name.)');
  }
}

/// Sanity checks for new package names.
///
/// TODO: refactor to make sure this is applied only on new package names,
///       and consider removing the known mixed case package checks
Iterable<ArchiveIssue> validateNewPackageName(String name) sync* {
  if (reservedWords.contains(reducePackageName(name))) {
    yield ArchiveIssue('Package name must not be a reserved word in Dart.');
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

/// Sanity check for matching `publish_to` field in `pubspec.yaml`.
Iterable<ArchiveIssue> validatePublishTo(String? value) sync* {
  if (value != null) {
    yield ArchiveIssue('Invalid `publish_to` value: `$value`.');
  }
}

/// Validates the `description` field in the `pubspec.yaml`.
Iterable<ArchiveIssue> validateDescription(String? description) sync* {
  if (description == null) {
    yield ArchiveIssue('Missing `description`.');
    return;
  }
  final trimmed = description.trim();
  if (trimmed.isEmpty) {
    yield ArchiveIssue('No content in `description`.');
    return;
  }
  if (description.length > 512) {
    yield ArchiveIssue(
        '`description` is too long, maximum length allowed: 512 characters.');
  }
  if (description.split(' ').any((part) => part.length > 64)) {
    yield ArchiveIssue(
        '`description` uses too long phrases, maximum world length allowed: 64 characters.');
  }
  if (hasEmojiCharacter(description)) {
    yield ArchiveIssue(
        '`description` is not allowed to have emoji characters.');
  }
  yield* validateKnownTemplateDescription(description);
}

/// Checks if the [text] has any weird characters like in
/// https://en.wikipedia.org/wiki/Zalgo_text
Iterable<ArchiveIssue> validateZalgo(String field, String? text) sync* {
  if (text == null) return;
  // Checks if the code is in the combining character unicode ranges:
  // https://en.wikipedia.org/wiki/Combining_character
  bool isDiacritic(int code) =>
      (code >= 0x0300 && code <= 0x036F) ||
      (code >= 0x1AB0 && code <= 0x1AFF) ||
      (code >= 0x1DC0 && code <= 0x1DFF) ||
      (code >= 0x20D0 && code <= 0x20FF) ||
      (code >= 0xFE20 && code <= 0xFE2F) ||
      (code == 0x3099) ||
      (code == 0x309A);
  final codes = text.codeUnits;
  for (var i = 1; i < codes.length; i++) {
    // checks for consecutive diacritical marks
    if (isDiacritic(codes[i]) && isDiacritic(codes[i - 1])) {
      yield ArchiveIssue('`$field` contains too many diacritical marks.');
      break;
    }
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

final _strictRegExp = RegExp(r'^' // Start at beginning.
    r'(\d+)\.(\d+)\.(\d+)' // Version number.
    r'(-([0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*))?' // Pre-release.
    r'(\+([0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*))?' // Build.
    r'$' // End of string.
    );

/// Checks if all version constraints follow a stricter pattern.
Iterable<ArchiveIssue> checkStrictVersions(Pubspec pubspec) sync* {
  Iterable<Version?> expandConstraint(VersionConstraint? constraint) {
    if (constraint is VersionRange) {
      return [constraint.min, constraint.max];
    }
    return const Iterable.empty();
  }

  Iterable<Version?> expandDependency(Dependency? dependency) {
    /// TODO: add `GitDependency` and `PathDependency` once they start to support `version`.
    ///       https://github.com/dart-lang/pubspec_parse/issues/77
    if (dependency is HostedDependency) {
      return expandConstraint(dependency.version);
    }
    return const Iterable.empty();
  }

  final versions = [
    pubspec.version,
    ...?pubspec.environment?.values.expand(expandConstraint),
    ...pubspec.dependencies.values.expand(expandDependency),
    ...pubspec.devDependencies.values.expand(expandDependency),
    ...pubspec.dependencyOverrides.values.expand(expandDependency),
  ];

  yield* versions
      .whereType<Version>() // only consider non-null values
      .where((v) => _strictRegExp.matchAsPrefix(v.toString()) == null)
      .map((v) => ArchiveIssue(
          'Version value `$v` does not follow strict version pattern.'));
}

final _preDart4 = VersionConstraint.parse('<4.0.0');
final _firstDart4Pre = Version.parse('4.0.0').firstPreRelease;

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
  if (sdk.intersect(_preDart4).isEmpty) {
    yield ArchiveIssue('SDK constraint does not allow any known Dart SDK.');
  }

  // Dart 3 version accepted with valid upper constraint.
  if (sdk.allows(_firstDart4Pre)) {
    yield ArchiveIssue(
        'The SDK constraint allows Dart 4.0.0, this is not allowed because Dart 4 does not exist.');
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

const _knownEnvironmentKeys = <String>{
  'sdk', // the Dart SDK
  'flutter',
  'fuchsia'
};

/// Validates that keys referenced in the `environment` section are
/// known and valid, otherwise `pub` won't be able to use the package.
Iterable<ArchiveIssue> validateEnvironmentKeys(Pubspec pubspec) sync* {
  final keys = pubspec.environment?.keys;
  if (keys == null) {
    return;
  }
  for (final key in keys) {
    if (_knownEnvironmentKeys.contains(key)) {
      continue;
    }
    yield ArchiveIssue('Unknown `environment` key in `pubspec.yaml`: `$key`.\n'
        'Please check https://dart.dev/tools/pub/pubspec#sdk-constraints');
  }
}

/// Validate that the package does not have too many dependencies.
/// It ignores `dev_dependencies` as these are for development only.
///
/// Validates that the dependencies (`dev_dependencies` included) have valid
/// package names (does not checks existence).
Iterable<ArchiveIssue> validateDependencies(Pubspec pubspec) sync* {
  // This is not an inherently hard limit, it's merely a sanity limitation.
  if (pubspec.dependencies.length > 100) {
    yield ArchiveIssue('Package must not exceed 100 direct dependencies. '
        '(Please file an issue if you think you have a good reason for more dependencies.)');
  }

  final names = <String>{
    ...pubspec.dependencies.keys,
  };
  for (final name in names) {
    final issues = validatePackageName(name).toList();
    if (issues.isNotEmpty) {
      yield ArchiveIssue('Dependency `$name` is not a valid package name.');
    }
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
  Iterable<String> files,
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
  if (path == null || path != 'LICENSE') {
    yield ArchiveIssue(
        '`LICENSE` file not found. All packages on pub.dev must contain a `LICENSE` file.');
    return;
  }
  if (content == null || content.trim().isEmpty) {
    yield ArchiveIssue('`LICENSE` file has no content.');
    return;
  }
  if (content.toLowerCase().contains('todo: add your license here.')) {
    yield ArchiveIssue('`LICENSE` file contains generic TODO.');
    return;
  }
}

Iterable<ArchiveIssue> checkScreenshots(
    Pubspec pubspec, Iterable<String> files) sync* {
  if (pubspec.screenshots == null) return;
  for (final s in pubspec.screenshots!) {
    // check path
    final normalizedPath = p.normalize(s.path);
    if (normalizedPath != s.path) {
      yield ArchiveIssue(
          'Screenshot `${s.path}` is not normalized, should be `$normalizedPath`.');
    }
    if (!files.contains(normalizedPath)) {
      yield ArchiveIssue('Screenshot `${s.path}` is missing from archive.');
    }

    // verify duplicate screenshots
    if (pubspec.screenshots!.where((x) => x.path == s.path).length > 1) {
      yield ArchiveIssue('Screenshot `${s.path}` must be present only once.');
    }

    // validate screenshot text
    final textLength = s.description.trim().length;
    if (textLength <= 10) {
      yield ArchiveIssue(
          'Screenshot description for `${s.path}` is too short. Should be at least 10 characters.');
    }
    if (textLength > 200) {
      yield ArchiveIssue(
          'Screenshot description for `${s.path}` is too long (over 200 characters).');
    }
    yield* validateZalgo('screenshot description', s.description);
  }
}

Iterable<ArchiveIssue> checkFunding(String pubspecContent) sync* {
  final map = loadYaml(pubspecContent) as Map;
  if (!map.containsKey('funding')) {
    return;
  }
  final funding = map['funding'];
  if (funding == null || funding is! List || funding.isEmpty) {
    yield ArchiveIssue(
        '`pubspec.yaml` has invalid `funding`: only a list of URLs are allowed.');
    return;
  }
  for (final item in funding) {
    if (item is! String || item.trim().isEmpty) {
      yield ArchiveIssue(
          'Invalid `funding` value (`$item`): only URLs are allowed.');
      continue;
    }
    final uri = Uri.tryParse(item.trim());
    if (uri == null || uri.scheme != 'https') {
      yield ArchiveIssue(
          'Invalid `funding` value (`$item`): only `https` URLs are allowed.');
      continue;
    }
    if (item.length > 255) {
      yield ArchiveIssue(
          'Invalid `funding` value (`$item`): maximum URL length is 255 characters.');
    }
  }
}

Iterable<ArchiveIssue> checkTopics(String pubspecContent) sync* {
  final map = loadYaml(pubspecContent) as Map;
  if (!map.containsKey('topics')) {
    return;
  }
  final topics = map['topics'];
  if (topics == null || topics is! List || topics.isEmpty) {
    yield ArchiveIssue(
        '`pubspec.yaml` has invalid `topics`: only a list of topic names are allowed.');
    return;
  }
  if (topics.length > 5) {
    yield ArchiveIssue(
        '`pubspec.yaml` has invalid `topics`: at most 5 topics are allowed.');
    return;
  }

  for (var item in topics) {
    if (item is! String) {
      yield ArchiveIssue(
          'Invalid `topics` value (`$item`): only strings are allowed.');
      continue;
    }
    item = item.trim();
    if (item.length < 3) {
      yield ArchiveIssue(
          'Invalid `topics` value (`$item`): name is too short (less than 3 characters).');
      continue;
    }

    if (item.length > 32) {
      yield ArchiveIssue(
          'Invalid `topics` value (`$item`): name is too long (over 32 characters).');
      continue;
    }

    if (topics.where((x) => x == item).length > 1) {
      yield ArchiveIssue(
          'Invalid `topics` value (`$item`): name must only be present once.');
    }

    final RegExp regExp = RegExp(r'^[a-z]([a-z0-9]|\-(?=[^\-]))+[a-z0-9]$');
    if (!regExp.hasMatch(item)) {
      yield ArchiveIssue(
          'Invalid `topics` value (`$item`): must consist of lowercase '
          'alphanumerical characters or dash (but no double dash), starting '
          'with a-z and ending with a-z or 0-9.');
      continue;
    }
  }
}
