// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.appengine_repository.models;

import 'dart:math';

import 'package:gcloud/db.dart' as db;
import 'package:meta/meta.dart';
import 'package:pub_semver/pub_semver.dart';

import '../scorecard/models.dart';
import '../shared/model_properties.dart';
import '../shared/search_service.dart' show ApiPageRef;
import '../shared/urls.dart' as urls;
import '../shared/utils.dart';
import 'model_properties.dart';

export 'model_properties.dart' show FileObject;

/// Pub package metdata.
///
/// The main property used is `uploaderEmails` for determining who is allowed
/// to upload packages.
// TODO:
// The uploaders are saved as User objects in the python datastore. We don't
// have db Models for users, but the lowlevel datastore API will store them
// as expanded properties of type `Entity`.
// We should move ExpandoModel -> Model once we have highlevel db.User objects.
//
// NOTE: Keep in sync with PackageArchive.
@db.Kind(name: 'Package', idType: db.IdType.String)
class Package extends db.ExpandoModel {
  @db.StringProperty()
  String name; // Same as id

  @db.DateTimeProperty()
  DateTime created;

  @db.DateTimeProperty()
  DateTime updated;

  @db.IntProperty()
  int downloads;

  @db.ModelKeyProperty(propertyName: 'latest_version')
  db.Key latestVersionKey;

  @db.ModelKeyProperty(propertyName: 'latest_dev_version')
  db.Key latestDevVersionKey;

  /// List of User.userId
  @db.StringListProperty()
  List<String> uploaders;

  @db.BoolProperty()
  bool isDiscontinued;

  @db.BoolProperty()
  bool doNotAdvertise;

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

  // Check if a user is an uploader for a package.
  bool hasUploader(String uploaderId) {
    return uploaderId != null && uploaders.contains(uploaderId);
  }

  int get uploaderCount => uploaders.length;

  /// Add the id to the list of uploaders.
  void addUploader(String uploaderId) {
    if (uploaderId != null && !uploaders.contains(uploaderId)) {
      uploaders.add(uploaderId);
    }
  }

  // Remove the id from the list of uploaders.
  void removeUploader(String uploaderId) {
    uploaders.removeWhere((s) => s == uploaderId);
  }

  void updateVersion(PackageVersion pv) {
    final Version newVersion = pv.semanticVersion;
    final Version latestStable = latestSemanticVersion;
    final Version latestDev = latestDevSemanticVersion;

    if (isNewer(latestStable, newVersion, pubSorted: true)) {
      latestVersionKey = pv.key;
    }

    if (latestDev == null || isNewer(latestDev, newVersion, pubSorted: false)) {
      latestDevVersionKey = pv.key;
    }
  }

  bool isNewPackage() => created.difference(DateTime.now()).abs().inDays <= 30;
}

/// Pub package metadata for a specific uploaded version.
///
/// Metadata such as changelog/readme/libraries are used for rendering HTML
/// pages.
// The uploaders are saved as User objects in the python datastore. We don't
// have db Models for users, but the lowlevel datastore API will store them
// as expanded properties of type `Entity`.
// We should move ExpandoModel -> Model once we have highlevel db.User objects.
//
// NOTE: Keep in sync with PackageVersionArchive.
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

  // This was set to false because some obsolete PackageVersion entities were
  // not migrated. We are waiting for confirmation to delete them, but until
  // that happens, it is not much risk to set it to false.
  // TODO: set it to required: true once the integrity check script passes
  @db.StringProperty(required: false)
  String uploader;

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

/// A secret value stored in Datastore, typically an access credential used by
/// the application.
@db.Kind(name: 'Secret', idType: db.IdType.String)
class Secret extends db.Model {
  @db.StringProperty(required: true)
  String value;
}

/// Identifiers of the [Secret] keys.
abstract class SecretKey {
  static const String smtpUsername = 'smtp.username';
  static const String smtpPassword = 'smtp.password';
  static const String redisConnectionString = 'redis.connectionString';

  /// OAuth audiences have separate secrets for each audience.
  static const String oauthPrefix = 'oauth.secret-';

  /// List of all keys.
  static const values = [
    smtpUsername,
    smtpPassword,
    redisConnectionString,
  ];
}

/// An active invitation sent to a recipient.
/// The parent entity is a [Package] the id is the concatenation of '[type]/[recipientEmail]'.
///
/// The invitation secret ([urlNonce]) is sent via e-mail to the recipient and
/// they need to open a URL to accept the invitation.
@db.Kind(name: 'PackageInvite', idType: db.IdType.String)
class PackageInvite extends db.Model {
  @db.StringProperty()
  String type;

  @db.StringProperty()
  String recipientEmail;

  @db.StringProperty()
  String urlNonce;

  @db.StringProperty()
  String fromUserId;

  @db.StringProperty()
  String fromEmail;

  @db.DateTimeProperty()
  DateTime created;

  @db.DateTimeProperty()
  DateTime expires;

  @db.DateTimeProperty()
  DateTime lastNotified;

  @db.IntProperty()
  int notificationCount;

  String get packageName => parentKey.id as String;

  /// Create a composite id.
  static String createId(String type, String recipientEmail) =>
      '$type/$recipientEmail';

  bool isExpired() => DateTime.now().toUtc().isAfter(expires);

  /// Whether a new notification should be sent.
  bool shouldNotify() => DateTime.now().toUtc().isAfter(nextNotification);

  /// The timestamp when the next notification could be sent out.
  DateTime get nextNotification =>
      created.add(Duration(minutes: 1 << notificationCount));

  /// Whether the invite is still valid and available.
  bool isValid({@required String recipientEmail, @required String urlNonce}) {
    return this.recipientEmail == recipientEmail &&
        this.urlNonce == urlNonce &&
        !isExpired();
  }
}

abstract class PackageInviteType {
  static const newUploader = 'new-uploader';
}

/// An extract of [Package] and [PackageVersion], for
/// display-only uses.
class PackageView extends Object with FlagMixin {
  final bool isExternal;
  final String url;
  final String name;
  final String version;

  // Not null only if there is a difference compared to the [version].
  final String devVersion;
  final String ellipsizedDescription;
  final String shortUpdated;
  final List<String> authors;
  @override
  final List<String> flags;
  final bool isAwaiting;
  final double overallScore;
  final List<String> platforms;
  final bool isNewPackage;
  final List<ApiPageRef> apiPages;

  PackageView({
    this.isExternal = false,
    this.url,
    this.name,
    this.version,
    this.devVersion,
    this.ellipsizedDescription,
    this.shortUpdated,
    this.authors,
    this.flags,
    this.isAwaiting = false,
    this.overallScore,
    this.platforms,
    this.isNewPackage,
    this.apiPages,
  });

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
        (scoreCard == null) || (!scoreCard.isSkipped && !hasPanaReport);
    return PackageView(
      name: version?.package ?? package?.name,
      version: version?.version ?? package?.latestVersion,
      devVersion: devVersion,
      ellipsizedDescription: version?.ellipsizedDescription,
      shortUpdated: version?.shortCreated ?? package?.shortUpdated,
      authors: version?.pubspec?.authors,
      flags: scoreCard?.flags,
      isAwaiting: isAwaiting,
      overallScore: scoreCard?.overallScore,
      platforms: scoreCard?.platformTags,
      isNewPackage: package?.isNewPackage(),
      apiPages: apiPages,
    );
  }
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
  final String homepageUrl;
  final String documentationUrl;
  final String repositoryUrl;
  final String issueTrackerUrl;

  PackageLinks({
    this.homepageUrl,
    this.documentationUrl,
    this.repositoryUrl,
    this.issueTrackerUrl,
  });

  factory PackageLinks.infer({
    String homepageUrl,
    String documentationUrl,
    String repositoryUrl,
    String issueTrackerUrl,
  }) {
    repositoryUrl ??= urls.inferRepositoryUrl(homepageUrl);
    issueTrackerUrl ??= urls.inferIssueTrackerUrl(repositoryUrl);
    return PackageLinks(
      homepageUrl: homepageUrl,
      documentationUrl: documentationUrl,
      repositoryUrl: repositoryUrl,
      issueTrackerUrl: issueTrackerUrl,
    );
  }
}
