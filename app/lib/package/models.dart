// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.appengine_repository.models;

import 'dart:math';

import 'package:gcloud/db.dart' as db;
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:pub_semver/pub_semver.dart';

import '../analyzer/analyzer_client.dart' show AnalysisView;
import '../package/model_properties.dart';
import '../scorecard/models.dart';
import '../search/search_service.dart' show ApiPageRef;
import '../shared/exceptions.dart';
import '../shared/model_properties.dart';
import '../shared/tags.dart';
import '../shared/urls.dart' as urls;
import '../shared/utils.dart';

export '../package/model_properties.dart' show FileObject;

part 'models.g.dart';

/// Pub package metdata.
///
/// The main property used is `uploaders` for determining who is allowed
/// to upload packages.
@db.Kind(name: 'Package', idType: db.IdType.String)
class Package extends db.ExpandoModel {
  @db.StringProperty(required: true)
  String name; // Same as id

  @db.DateTimeProperty(required: true)
  DateTime created;

  @db.DateTimeProperty(required: true)
  DateTime updated;

  @db.IntProperty()
  int downloads;

  /// Number of `User`s for which a `Like` entity of this package exists.
  ///
  /// Should be set zero when [Package] is created, and always updated in a
  /// transaction with a `Like` entity being created or removed, or by a
  /// background job correcting `Like` counts.
  @db.IntProperty(required: true)
  int likes;

  @db.ModelKeyProperty(propertyName: 'latest_version', required: true)
  db.Key latestVersionKey;

  @db.ModelKeyProperty(propertyName: 'latest_dev_version')
  db.Key latestDevVersionKey;

  /// The publisher id (null, if the package does not have a publisher).
  @db.StringProperty()
  String publisherId;

  /// List of User.userId
  @db.StringListProperty()
  List<String> uploaders;

  /// Set to `true` if package is discontinued, may otherwise be `false`.
  @db.BoolProperty(required: true)
  bool isDiscontinued;

  /// Set to `true` if package should not be advertised on the front page,
  /// may otherwise be `false`.
  @db.BoolProperty(required: true)
  bool doNotAdvertise;

  /// Tags that are assigned to this package.
  ///
  /// The permissions required to assign a tag typically depends on the tag.
  /// A package owner might be able to assign `'is:discontinued'` while a tag
  /// like `'is:not-advertized'` might only be managed by pub-administrators.
  @db.StringListProperty()
  List<String> assignedTags;

  // Convenience Fields:

  String get latestVersion => latestVersionKey.id as String;

  Version get latestSemanticVersion =>
      Version.parse(latestVersionKey.id as String);

  String get latestDevVersion => latestDevVersionKey?.id as String;

  Version get latestDevSemanticVersion =>
      latestDevVersionKey == null ? null : Version.parse(latestDevVersion);

  String get shortUpdated {
    return shortDateFormat.format(updated);
  }

  // Check if a [userId] is in the list of [uploaders].
  bool containsUploader(String userId) {
    return userId != null && uploaders.contains(userId);
  }

  int get uploaderCount => uploaders.length;

  /// Add the [userId] to the list of [uploaders].
  void addUploader(String userId) {
    if (publisherId != null) {
      throw OperationForbiddenException.publisherOwnedPackageNoUploader(
          name, publisherId);
    }
    if (userId != null && !uploaders.contains(userId)) {
      uploaders.add(userId);
    }
  }

  // Remove the [userId] from the list of [uploaders].
  void removeUploader(String userId) {
    if (publisherId != null) {
      throw OperationForbiddenException.publisherOwnedPackageNoUploader(
          name, publisherId);
    }
    uploaders.remove(userId);
  }

  /// Updates latest stable and dev version keys with the new version.
  void updateVersion(PackageVersion pv) {
    final Version newVersion = pv.semanticVersion;

    if (latestVersionKey == null ||
        isNewer(latestSemanticVersion, newVersion, pubSorted: true)) {
      latestVersionKey = pv.key;
    }

    if (latestDevVersionKey == null ||
        isNewer(latestDevSemanticVersion, newVersion, pubSorted: false)) {
      latestDevVersionKey = pv.key;
    }
  }

  bool isNewPackage() => created.difference(DateTime.now()).abs().inDays <= 30;

  /// List of tags from the flags on the current [Package] entity.
  List<String> getTags() {
    return <String>[
      // TODO(jonasfj): Remove the if (assignedTags != null) condition, we only
      //                need this until we've done backfill_package_fields.dart
      if (assignedTags != null)
        ...assignedTags,
      if (isDiscontinued)
        PackageTags.isDiscontinued,
      if (isNewPackage())
        PackageTags.isRecent,
      if (doNotAdvertise)
        PackageTags.isNotAdvertized,
      // TODO: publisher:<publisherId>
      // TODO: uploader:<...>
    ];
  }
}

/// Pub package metadata for a specific uploaded version.
///
/// Metadata such as changelog/readme/libraries are used for rendering HTML
/// pages.
@db.Kind(name: 'PackageVersion', idType: db.IdType.String)
class PackageVersion extends db.ExpandoModel {
  @db.StringProperty(required: true)
  String version; // Same as id

  String get package => packageKey.id as String;

  @db.ModelKeyProperty(required: true, propertyName: 'package')
  db.Key packageKey;

  @db.DateTimeProperty()
  DateTime created;

  // Extracted data from the uploaded package.

  @PubspecProperty(required: true)
  Pubspec pubspec;

  @db.StringProperty(indexed: false)
  String readmeFilename;

  @db.StringProperty(indexed: false)
  String readmeContent;

  FileObject get readme {
    if (readmeFilename != null) {
      return FileObject(readmeFilename, readmeContent);
    }
    return null;
  }

  @db.StringProperty(indexed: false)
  String changelogFilename;

  @db.StringProperty(indexed: false)
  String changelogContent;

  FileObject get changelog {
    if (changelogFilename != null) {
      return FileObject(changelogFilename, changelogContent);
    }
    return null;
  }

  @db.StringProperty(indexed: false)
  String exampleFilename;

  @db.StringProperty(indexed: false)
  String exampleContent;

  FileObject get example {
    if (exampleFilename != null) {
      return FileObject(exampleFilename, exampleContent);
    }
    return null;
  }

  @CompatibleStringListProperty()
  List<String> libraries;

  // Metadata about the package version.

  @db.IntProperty(required: true)
  int downloads;

  @db.IntProperty(propertyName: 'sort_order')
  int sortOrder;

  @db.StringProperty(required: true)
  String uploader;

  /// The publisher id at the time of the upload.
  @db.StringProperty()
  String publisherId;

  // Convenience Fields:

  Version get semanticVersion => Version.parse(version);

  String get ellipsizedDescription {
    final String description = pubspec.description;
    if (description == null) return null;
    return description.substring(0, min(description.length, 200));
  }

  String get shortCreated {
    return shortDateFormat.format(created);
  }

  String get documentation {
    return pubspec.documentation;
  }

  String get homepage {
    return pubspec.homepage;
  }

  PackageLinks get packageLinks {
    return PackageLinks.infer(
      homepageUrl: pubspec.homepage,
      documentationUrl: pubspec.documentation,
      repositoryUrl: pubspec.repository,
      issueTrackerUrl: pubspec.issueTracker,
    );
  }

  QualifiedVersionKey get qualifiedVersionKey {
    return QualifiedVersionKey(
      package: package,
      version: version,
    );
  }

  /// List of tags from the flags on the current [PackageVersion] entity.
  List<String> getTags() {
    return <String>[
      if (pubspec.supportsOnlyLegacySdk) PackageVersionTags.isLegacy,
    ];
  }
}

/// An derived entity that holds only the `pubspec.yaml` content of [PackageVersion].
///
/// The content of `pubspec.yaml` may be updated/cleaned in case of a breaking
/// change was introduced since the [PackageVersion] was published.
@db.Kind(name: 'PackageVersionPubspec', idType: db.IdType.String)
class PackageVersionPubspec extends db.ExpandoModel {
  @db.StringProperty(required: true)
  String package;

  @db.StringProperty(required: true)
  String version;

  @db.DateTimeProperty()
  DateTime updated;

  @PubspecProperty(required: true)
  Pubspec pubspec;

  PackageVersionPubspec();

  void initFromKey(QualifiedVersionKey key) {
    id = key.qualifiedVersion;
    package = key.package;
    version = key.version;
  }

  QualifiedVersionKey get qualifiedVersionKey {
    return QualifiedVersionKey(
      package: package,
      version: version,
    );
  }
}

/// An derived entity that holds derived/cleaned content of [PackageVersion].
@db.Kind(name: 'PackageVersionInfo', idType: db.IdType.String)
class PackageVersionInfo extends db.ExpandoModel {
  @db.StringProperty(required: true)
  String package;

  @db.StringProperty(required: true)
  String version;

  @db.DateTimeProperty()
  DateTime updated;

  @CompatibleStringListProperty()
  List<String> libraries;

  @db.IntProperty()
  int libraryCount;

  PackageVersionInfo();

  void initFromKey(QualifiedVersionKey key) {
    id = key.qualifiedVersion;
    package = key.package;
    version = key.version;
  }

  QualifiedVersionKey get qualifiedVersionKey {
    return QualifiedVersionKey(
      package: package,
      version: version,
    );
  }
}

/// Entity representing a package that has been removed.
@db.Kind(name: 'ModeratedPackage', idType: db.IdType.String)
class ModeratedPackage extends db.ExpandoModel {
  @db.StringProperty(required: true)
  String name;

  @db.DateTimeProperty()
  DateTime moderated;

  /// The previous publisher id (null, if the package did not have a publisher).
  @db.StringProperty()
  String publisherId;

  /// List of User.userId of previous uploaders.
  @db.StringListProperty()
  List<String> uploaders;

  /// List of previous versions.
  @db.StringListProperty()
  List<String> versions;
}

/// An identifier to point to a specific [package] and [version].
class QualifiedVersionKey {
  final String package;
  final String version;

  QualifiedVersionKey({
    @required this.package,
    @required this.version,
  });

  String get qualifiedVersion => '$package-$version';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QualifiedVersionKey &&
          runtimeType == other.runtimeType &&
          package == other.package &&
          version == other.version;

  @override
  int get hashCode => package.hashCode ^ version.hashCode;

  @override
  String toString() => qualifiedVersion;
}

/// An extract of [Package] and [PackageVersion], for
/// display-only uses.
@JsonSerializable(includeIfNull: false)
class PackageView extends Object with FlagMixin {
  final bool isExternal;
  final String url;
  final String name;
  final String version;

  // Not null only if there is a difference compared to the [version].
  final String devVersion;
  final String ellipsizedDescription;

  /// The date when the package was first published.
  final DateTime created;
  final String shortUpdated;
  @override
  final List<String> flags;
  final String publisherId;
  final bool isAwaiting;

  final int likes;

  /// The package's health score value (on the scale of 0-100).
  /// May be `null` if the score is not available yet.
  final int health;

  /// The package's popularity score value (on the scale of 0-100).
  /// May be `null` if the score is not available yet.
  final int popularity;

  /// TODO: remove this after the new design is finalized
  final double overallScore;
  final List<String> tags;
  final bool isNewPackage;
  final List<ApiPageRef> apiPages;

  PackageView({
    this.isExternal = false,
    this.url,
    this.name,
    this.version,
    this.devVersion,
    this.ellipsizedDescription,
    this.created,
    this.shortUpdated,
    this.flags,
    this.publisherId,
    this.isAwaiting = false,
    this.likes,
    this.health,
    this.popularity,
    this.overallScore,
    List<String> tags,
    this.isNewPackage = false,
    this.apiPages,
  }) : tags = tags ?? <String>[];

  factory PackageView.fromJson(Map<String, dynamic> json) =>
      _$PackageViewFromJson(json);

  factory PackageView.fromModel({
    Package package,
    PackageVersion version,
    ScoreCardData scoreCard,
    List<ApiPageRef> apiPages,
  }) {
    final String devVersion =
        package != null && package.latestVersion != package.latestDevVersion
            ? package.latestDevVersion
            : null;
    final hasPanaReport = scoreCard?.reportTypes != null &&
        scoreCard.reportTypes.contains(ReportType.pana);
    final isAwaiting =
        // Job processing has not created any card yet.
        (scoreCard == null) ||
            // The uploader has recently removed the "discontinued" flag, but the
            // analysis did not complete yet.
            (scoreCard.isDiscontinued && !package.isDiscontinued) ||
            // No blocker for analysis, but no results yet.
            (!scoreCard.isSkipped && !hasPanaReport);
    return PackageView(
      name: version?.package ?? package?.name,
      version: version?.version ?? package?.latestVersion,
      devVersion: devVersion,
      ellipsizedDescription: version?.ellipsizedDescription,
      created: package.created,
      shortUpdated: version?.shortCreated ?? package?.shortUpdated,
      flags: scoreCard?.flags,
      publisherId: package.publisherId,
      isAwaiting: isAwaiting,
      likes: package.likes,
      health: scoreCard?.healthScore == null
          ? null
          : (100.0 * scoreCard.healthScore).round(),
      popularity: scoreCard?.popularityScore == null
          ? null
          : (100.0 * scoreCard.popularityScore).round(),
      overallScore: scoreCard?.overallScore,
      tags: <String>[
        ...(package?.getTags() ?? <String>[]),
        ...(version?.getTags() ?? <String>[]),
        ...(scoreCard?.derivedTags ?? <String>[]),
      ],
      isNewPackage: package?.isNewPackage() ?? false,
      apiPages: apiPages,
    );
  }

  PackageView change({List<ApiPageRef> apiPages}) {
    return PackageView(
      isExternal: isExternal,
      url: url,
      name: name,
      version: version,
      devVersion: devVersion,
      ellipsizedDescription: ellipsizedDescription,
      created: created,
      shortUpdated: shortUpdated,
      flags: flags,
      publisherId: publisherId,
      isAwaiting: isAwaiting,
      likes: likes,
      health: health,
      popularity: popularity,
      overallScore: overallScore,
      tags: tags,
      isNewPackage: isNewPackage,
      apiPages: apiPages ?? this.apiPages,
    );
  }

  Map<String, dynamic> toJson() => _$PackageViewToJson(this);
}

/// Sorts [versions] according to the semantic versioning specification.
///
/// If [pubSorting] is `true` then pub's priorization ordering is used, which
/// will rank pre-release versions lower than stable versions (e.g. it will
/// order "0.9.0-dev.1 < 0.8.0").  Otherwise it will use semantic version
/// sorting (e.g. it will order "0.8.0 < 0.9.0-dev.1").
void sortPackageVersionsDesc(List<PackageVersion> versions,
    {bool decreasing = true, bool pubSorting = true}) {
  versions.sort((PackageVersion a, PackageVersion b) =>
      compareSemanticVersionsDesc(
          a.semanticVersion, b.semanticVersion, decreasing, pubSorting));
}

/// The URLs provided by the package's pubspec or inferred from the homepage.
class PackageLinks {
  /// `homepage` property in `pubspec.yaml`
  final String homepageUrl;

  /// `documentation` property in `pubspec.yaml`
  final String documentationUrl;

  /// `repository` property in `pubspec.yaml`, or if not specified, an inferred
  /// URL from [homepageUrl].
  final String repositoryUrl;

  /// `issue_tracker` property in `pubspec.yaml`, or if not specified, an
  /// inferred URL from [repositoryUrl].
  final String issueTrackerUrl;

  /// The inferred base URL that can be used to link files from.
  final String baseUrl;

  PackageLinks._({
    this.homepageUrl,
    this.documentationUrl,
    this.repositoryUrl,
    this.issueTrackerUrl,
    this.baseUrl,
  });

  factory PackageLinks.infer({
    String homepageUrl,
    String documentationUrl,
    String repositoryUrl,
    String issueTrackerUrl,
  }) {
    repositoryUrl ??= urls.inferRepositoryUrl(homepageUrl);
    issueTrackerUrl ??= urls.inferIssueTrackerUrl(repositoryUrl);
    final baseUrl = urls.inferBaseUrl(
      homepageUrl: homepageUrl,
      repositoryUrl: repositoryUrl,
    );
    return PackageLinks._(
      homepageUrl: homepageUrl,
      documentationUrl: documentationUrl,
      repositoryUrl: repositoryUrl,
      issueTrackerUrl: issueTrackerUrl,
      baseUrl: baseUrl,
    );
  }
}

/// Common data structure shared between package pages.
class PackagePageData {
  final Package package;
  final PackageVersion version;
  final AnalysisView analysis;
  final List<String> uploaderEmails;
  final bool isAdmin;
  final bool isLiked;

  PackagePageData({
    @required this.package,
    @required this.version,
    @required this.analysis,
    @required this.uploaderEmails,
    @required this.isAdmin,
    @required this.isLiked,
  });

  PackagePageData.missingVersion({@required this.package})
      : version = null,
        analysis = null,
        uploaderEmails = null,
        isAdmin = null,
        isLiked = null;

  PackageView toPackageView() {
    return PackageView.fromModel(
      package: package,
      version: version,
      scoreCard: analysis?.card,
    );
  }
}
