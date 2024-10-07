// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.appengine_repository.models;

import 'dart:convert';

import 'package:_pub_shared/data/package_api.dart';
import 'package:_pub_shared/search/tags.dart';
import 'package:clock/clock.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pana/models.dart';
import 'package:pub_dev/shared/markdown.dart';
import 'package:pub_semver/pub_semver.dart';

import '../package/model_properties.dart';
import '../scorecard/models.dart';
import '../search/search_service.dart' show ApiPageRef;
import '../shared/datastore.dart' as db;
import '../shared/exceptions.dart';
import '../shared/model_properties.dart';
import '../shared/popularity_storage.dart';
import '../shared/urls.dart' as urls;
import '../shared/utils.dart';

part 'models.g.dart';

/// The age of package (the last version published) after it is hidden in
/// `robots.txt`.
const robotsVisibilityMaxAge = Duration(days: 365 * 2);

/// The age of package (the first version published) after it is shown in
/// `sitemap.txt`. During this time, the package is marked as `noindex`.
///
/// This gives administrators time to detect and remove spam packages, reducing
/// their attractiveness to spammers.
const robotsVisibilityMinAge = Duration(days: 3);

/// Pub package metadata.
///
/// The main property used is `uploaders` for determining who is allowed
/// to upload packages.
@db.Kind(name: 'Package', idType: db.IdType.String)
class Package extends db.ExpandoModel<String> {
  @db.StringProperty(required: true)
  String? name; // Same as id

  @db.DateTimeProperty(required: true)
  DateTime? created;

  @db.DateTimeProperty(required: true)
  DateTime? updated;

  /// Number of `User`s for which a `Like` entity of this package exists.
  ///
  /// Should be set zero when [Package] is created, and always updated in a
  /// transaction with a `Like` entity being created or removed, or by a
  /// background job correcting `Like` counts.
  @db.IntProperty(required: true)
  int likes = 0;

  /// [DateTime] when the most recently uploaded [PackageVersion] was published,
  /// regardless of the retracted status of that version.
  @db.DateTimeProperty(required: true)
  DateTime? lastVersionPublished;

  /// Key referencing the [PackageVersion] for the latest version of this package, ordered by priority order of
  /// semantic versioning, hence, deprioritizing prereleases.
  @db.ModelKeyProperty(propertyName: 'latest_version', required: true)
  db.Key? latestVersionKey;

  /// [DateTime] when the [PackageVersion] in [latestVersionKey] was published.
  @db.DateTimeProperty()
  DateTime? latestPublished;

  /// Reference to latest version of this package ordered by semantic versioning, including
  /// prerelease versions of this package.
  ///
  /// Note. This is **not** the _latest prerelease version_, it is the _latest version_ without deprioritization of
  /// prereleases. Hence, this might not be a prerelease version, if a newer non-prerelease exists.
  @db.ModelKeyProperty(propertyName: 'latest_dev_version')
  db.Key? latestPrereleaseVersionKey;

  /// DateTime at which point the `PackageVersion` referenced in [latestPrereleaseVersionKey] was published.
  @db.DateTimeProperty()
  DateTime? latestPrereleasePublished;

  /// Reference to latest version of this package ordered by semantic versioning,
  /// filtered for versions that depend on an SDK that will be published in the
  /// future.
  ///
  /// Note: the version may be stable or prerelease.
  @db.ModelKeyProperty()
  db.Key? latestPreviewVersionKey;

  /// DateTime at which point the `PackageVersion` referenced in [latestPreviewVersionKey] was published.
  @db.DateTimeProperty()
  DateTime? latestPreviewPublished;

  /// The publisher id (null, if the package does not have a publisher).
  @db.StringProperty()
  String? publisherId;

  /// List of User.userId
  @db.StringListProperty()
  List<String>? uploaders;

  /// The number of published versions.
  @db.IntProperty(required: true)
  int versionCount = 0;

  /// Set to `true` if package is discontinued, may otherwise be `false`.
  @db.BoolProperty(required: true)
  bool isDiscontinued = false;

  /// The package that should be used instead of the current package.
  /// May have a value only if [isDiscontinued] is set.
  @db.StringProperty()
  String? replacedBy;

  /// Set to `true` if package should not be advertised on the front page, not
  /// be found through default package search; may otherwise be `false`.
  @db.BoolProperty(required: true)
  bool isUnlisted = false;

  /// Set to `true` if package should not be displayed anywhere, because of
  /// pending moderation or deletion.
  @db.BoolProperty(required: true)
  bool isBlocked = false;

  /// The reason why the package was blocked.
  @db.StringProperty(indexed: false)
  String? blockedReason;

  /// The timestamp when the package was blocked.
  @db.DateTimeProperty()
  DateTime? blocked;

  /// `true` if package was moderated (pending moderation or deletion).
  @db.BoolProperty(required: true)
  bool isModerated = false;

  /// The timestamp when the package was moderated.
  @db.DateTimeProperty()
  DateTime? moderatedAt;

  /// Tags that are assigned to this package.
  ///
  /// The permissions required to assign a tag typically depends on the tag.
  /// A package owner might be able to assign `'is:discontinued'` while other
  /// tags might only be managed by pub-administrators.
  @db.StringListProperty()
  List<String>? assignedTags;

  /// List of versions that have been deleted and must not be re-uploaded again.
  @db.StringListProperty()
  List<String>? deletedVersions;

  /// Scheduling state for all versions of this package.
  @AutomatedPublishingProperty()
  AutomatedPublishing? automatedPublishing;

  /// The latest point in time at which a security advisory that affects this
  /// package has been synchronized into pub.
  ///
  /// `null` if the package has never been affected by an advisory.
  ///
  /// Once set, it must only be moved forward, never `null` again and never a
  /// future date.
  @db.DateTimeProperty()
  DateTime? latestAdvisory;

  Package();

  /// Creates a new [Package] and populates all of it's fields from [version].
  factory Package.fromVersion(PackageVersion version) {
    final now = clock.now().toUtc();
    return Package()
      ..parentKey = version.packageKey!.parent
      ..id = version.pubspec!.name
      ..name = version.pubspec!.name
      ..created = version.created
      ..updated = now
      ..latestVersionKey = version.key
      ..latestPublished = version.created
      ..latestPrereleaseVersionKey = version.key
      ..latestPrereleasePublished = version.created
      ..latestPreviewVersionKey = version.key
      ..latestPreviewPublished = version.created
      ..lastVersionPublished = version.created
      ..uploaders = [version.uploader!]
      ..versionCount = 0
      ..likes = 0
      ..isDiscontinued = false
      ..isUnlisted = false
      ..isBlocked = false
      ..isModerated = false
      ..assignedTags = []
      ..deletedVersions = [];
  }

  // Convenience Fields:

  bool get isVisible => !isBlocked && !isModerated;
  bool get isNotVisible => !isVisible;

  bool get isIncludedInRobots {
    final now = clock.now();
    return isVisible &&
        !isModerated &&
        !isDiscontinued &&
        !isUnlisted &&
        now.difference(created!) > robotsVisibilityMinAge &&
        now.difference(latestPublished!) < robotsVisibilityMaxAge;
  }

  bool get isExcludedInRobots => !isIncludedInRobots;

  String? get latestVersion => latestVersionKey!.id as String?;

  Version get latestSemanticVersion =>
      Version.parse(latestVersionKey!.id as String);

  String? get latestPrereleaseVersion =>
      latestPrereleaseVersionKey?.id as String?;

  String? get latestPreviewVersion => latestPreviewVersionKey?.id as String?;

  Version? get latestPrereleaseSemanticVersion =>
      latestPrereleaseVersionKey == null
          ? null
          : Version.parse(latestPrereleaseVersion!);

  Version? get latestPreviewSemanticVersion => latestPreviewVersionKey == null
      ? null
      : Version.parse(latestPreviewVersion!);

  bool get showPrereleaseVersion {
    if (latestPrereleaseVersion == null) return false;
    return latestSemanticVersion < latestPrereleaseSemanticVersion! &&
        (latestPreviewSemanticVersion == null ||
            latestPreviewSemanticVersion! < latestPrereleaseSemanticVersion!);
  }

  bool get showPreviewVersion {
    if (latestPreviewVersion == null) return false;
    return latestSemanticVersion < latestPreviewSemanticVersion!;
  }

  // Check if a [userId] is in the list of [uploaders].
  bool containsUploader(String? userId) {
    return userId != null && uploaders!.contains(userId);
  }

  int get uploaderCount => uploaders!.length;

  /// Add the [userId] to the list of [uploaders].
  void addUploader(String? userId) {
    if (publisherId != null) {
      throw OperationForbiddenException.publisherOwnedPackageNoUploader(
          name!, publisherId!);
    }
    if (userId != null && !uploaders!.contains(userId)) {
      uploaders!.add(userId);
    }
  }

  // Remove the [userId] from the list of [uploaders].
  void removeUploader(String? userId) {
    if (publisherId != null) {
      throw OperationForbiddenException.publisherOwnedPackageNoUploader(
          name!, publisherId!);
    }
    uploaders!.remove(userId);
  }

  /// Updates the latest* version fields using all the available versions
  /// and the current Dart and Flutter SDK version.
  ///
  /// If the update was triggered because of a single version changing, the
  /// [replaced] parameter can be used to replace the corresponding entry
  /// from the [versions] parameter, which may have been loaded before the
  /// transaction started.
  ///
  /// Returns whether the internal state has changed.
  bool updateVersions(
    List<PackageVersion> versions, {
    required Version dartSdkVersion,
    required Version flutterSdkVersion,
    PackageVersion? replaced,
  }) {
    final oldStableVersion = latestVersionKey;
    final oldPrereleaseVersion = latestPrereleaseVersionKey;
    final oldPreviewVersion = latestPreviewVersionKey;
    final oldLastVersionPublished = lastVersionPublished;
    final oldVersionCount = versionCount;

    versions = versions
        .map((v) => v.version == replaced?.version ? replaced! : v)
        .toList();

    final isAllRetracted = versions.every((v) => v.isRetracted);
    final isAllModerated = versions.every((v) => v.isModerated);
    if (isAllModerated) {
      throw NotAcceptableException('No visible versions left.');
    }

    // reset field values
    latestVersionKey = null;
    latestPublished = null;
    latestPreviewVersionKey = null;
    latestPreviewPublished = null;
    latestPrereleaseVersionKey = null;
    latestPrereleasePublished = null;
    lastVersionPublished = null;
    versionCount = 0;

    for (final pv in versions) {
      // Skip all moderated versions.
      if (pv.isModerated) {
        continue;
      }

      versionCount++;

      // `lastVersionPublished` is updated regardless of its retracted status.
      if (lastVersionPublished == null ||
          lastVersionPublished!.isBefore(pv.created!)) {
        lastVersionPublished = pv.created;
      }

      // Skip retracted versions if there is a non-retracted version,
      // otherwise process all of the retracted ones.
      if (pv.isRetracted && !isAllRetracted) {
        continue;
      }

      final newVersion = pv.semanticVersion;
      final isOnPreviewSdk = pv.pubspec!.isPreviewForCurrentSdk(
        dartSdkVersion: dartSdkVersion,
        flutterSdkVersion: flutterSdkVersion,
      );
      final isOnStableSdk = !isOnPreviewSdk;

      if (latestVersionKey == null ||
          (isNewer(latestSemanticVersion, newVersion, pubSorted: true) &&
              (latestSemanticVersion.isPreRelease || isOnStableSdk))) {
        latestVersionKey = pv.key;
        latestPublished = pv.created;
      }

      if (latestPreviewVersionKey == null ||
          isNewer(latestPreviewSemanticVersion!, newVersion, pubSorted: true)) {
        latestPreviewVersionKey = pv.key;
        latestPreviewPublished = pv.created;
      }

      if (latestPrereleaseVersionKey == null ||
          isNewer(latestPrereleaseSemanticVersion!, newVersion,
              pubSorted: false)) {
        latestPrereleaseVersionKey = pv.key;
        latestPrereleasePublished = pv.created;
      }
    }

    final unchanged = oldStableVersion == latestVersionKey &&
        oldPrereleaseVersion == latestPrereleaseVersionKey &&
        oldPreviewVersion == latestPreviewVersionKey &&
        oldLastVersionPublished == lastVersionPublished &&
        oldVersionCount == versionCount;
    if (unchanged) {
      return false;
    }
    updated = clock.now().toUtc();
    return true;
  }

  bool isNewPackage() => created!.difference(clock.now()).abs().inDays <= 30;

  /// List of tags from the flags on the current [Package] entity.
  Iterable<String> getTags() {
    return <String>{
      ...?assignedTags,
      if (isNewPackage()) PackageTags.isRecent,
      if (isDiscontinued) ...[
        PackageTags.isDiscontinued,
        PackageTags.isUnlisted,
      ],
      if (isUnlisted) PackageTags.isUnlisted,
      if (publisherId != null) PackageTags.publisherTag(publisherId!),
    };
  }

  LatestReleases get latestReleases {
    return LatestReleases(
      stable: Release(
        version: latestVersion!,
        published: latestPublished!,
      ),
      prerelease: showPrereleaseVersion
          ? Release(
              version: latestPrereleaseVersion!,
              published: latestPrereleasePublished!,
            )
          : null,
      preview: showPreviewVersion
          ? Release(
              version: latestPreviewVersion!,
              published: latestPreviewPublished!,
            )
          : null,
    );
  }

  void updateIsBlocked({
    required bool isBlocked,
    String? reason,
  }) {
    this.isBlocked = isBlocked;
    blockedReason = reason;
    blocked = isBlocked ? clock.now().toUtc() : null;
    updated = clock.now().toUtc();
  }

  void updateIsModerated({
    required bool isModerated,
  }) {
    this.isModerated = isModerated;
    moderatedAt = isModerated ? clock.now().toUtc() : null;
    updated = clock.now().toUtc();
  }
}

/// Describes the various categories of latest releases.
@JsonSerializable()
class LatestReleases {
  final Release stable;
  final Release? prerelease;
  final Release? preview;

  LatestReleases({
    required this.stable,
    this.prerelease,
    this.preview,
  });

  factory LatestReleases.fromJson(Map<String, dynamic> json) =>
      _$LatestReleasesFromJson(json);

  Map<String, dynamic> toJson() => _$LatestReleasesToJson(this);

  bool get showPrerelease =>
      prerelease != null && stable.version != prerelease!.version;
  bool get showPreview => preview != null && stable.version != preview!.version;
}

@JsonSerializable()
class Release {
  final String version;
  final DateTime published;

  Release({
    required this.version,
    required this.published,
  });

  factory Release.fromJson(Map<String, dynamic> json) =>
      _$ReleaseFromJson(json);

  Map<String, dynamic> toJson() => _$ReleaseToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AutomatedPublishing {
  GithubPublishingConfig? githubConfig;
  GithubPublishingLock? githubLock;
  GcpPublishingConfig? gcpConfig;
  GcpPublishingLock? gcpLock;

  AutomatedPublishing({
    this.githubConfig,
    this.githubLock,
    this.gcpConfig,
    this.gcpLock,
  });

  factory AutomatedPublishing.fromJson(Map<String, dynamic> json) =>
      _$AutomatedPublishingFromJson(json);

  Map<String, dynamic> toJson() => _$AutomatedPublishingToJson(this);
}

/// A [db.Property] encoding [AutomatedPublishing] as JSON.
class AutomatedPublishingProperty extends db.Property {
  const AutomatedPublishingProperty(
      {String? propertyName, bool required = false})
      : super(propertyName: propertyName, required: required, indexed: false);

  @override
  Object? encodeValue(
    db.ModelDB mdb,
    Object? value, {
    bool forComparison = false,
  }) {
    if (value == null) return null;
    return json.encode(value as AutomatedPublishing);
  }

  @override
  Object? decodePrimitiveValue(
    db.ModelDB mdb,
    Object? value,
  ) {
    if (value == null) return null;
    return AutomatedPublishing.fromJson(
        json.decode(value as String) as Map<String, dynamic>);
  }

  @override
  bool validate(db.ModelDB mdb, Object? value) =>
      super.validate(mdb, value) &&
      (value == null || value is AutomatedPublishing);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class GithubPublishingLock {
  final String repositoryOwnerId;
  final String repositoryId;

  GithubPublishingLock({
    required this.repositoryOwnerId,
    required this.repositoryId,
  });

  factory GithubPublishingLock.fromJson(Map<String, dynamic> json) =>
      _$GithubPublishingLockFromJson(json);

  Map<String, dynamic> toJson() => _$GithubPublishingLockToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class GcpPublishingLock {
  final String oauthUserId;

  GcpPublishingLock({
    required this.oauthUserId,
  });

  factory GcpPublishingLock.fromJson(Map<String, dynamic> json) =>
      _$GcpPublishingLockFromJson(json);

  Map<String, dynamic> toJson() => _$GcpPublishingLockToJson(this);
}

/// Pub package metadata for a specific uploaded version.
///
/// Metadata such as changelog/readme/libraries are used for rendering HTML
/// pages.
@db.Kind(name: 'PackageVersion', idType: db.IdType.String)
class PackageVersion extends db.ExpandoModel<String> {
  @db.StringProperty(required: true)
  String? version; // Same as id

  String get package => packageKey!.id as String;

  @db.ModelKeyProperty(required: true, propertyName: 'package')
  db.Key? packageKey;

  /// [DateTime] when [version] of [package] was published.
  @db.DateTimeProperty(required: true)
  DateTime? created;

  // Extracted data from the uploaded package.

  /// The SHA-256 hash of the canonical archive file.
  @db.BlobProperty(required: false)
  List<int>? sha256;

  @PubspecProperty(required: true)
  Pubspec? pubspec;

  @CompatibleStringListProperty()
  List<String>? libraries;

  // Metadata about the package version.

  /// `User.userId` of the user or a known service agent, who uploaded the package.
  ///
  /// - For `User` accounts, this is a UUIDv4. If the user has been deleted,
  ///   it is possible that this property may not match any `User` entity.
  /// - For known service accounts this value starts with `service:` prefix.
  @db.StringProperty(required: true)
  String? uploader;

  /// The publisher id at the time of the upload.
  @db.StringProperty()
  String? publisherId;

  /// Whether the version has been retracted.
  @db.BoolProperty(required: true)
  bool isRetracted = false;

  /// The timestamp when the version was retracted.
  @db.DateTimeProperty()
  DateTime? retracted;

  /// `true` if package version was moderated (pending moderation or deletion).
  @db.BoolProperty(required: true)
  bool isModerated = false;

  /// The timestamp when the package version was moderated.
  @db.DateTimeProperty()
  DateTime? moderatedAt;

  PackageVersion();

  PackageVersion.init() {
    isModerated = false;
    isRetracted = false;
  }

  // Convenience Fields:

  late final semanticVersion = Version.parse(version!);

  String? get ellipsizedDescription {
    final description = pubspec!.description;
    if (description == null) return null;
    if (description.length < 210) return description;
    return '${description.substring(0, 200)} [...]';
  }

  QualifiedVersionKey get qualifiedVersionKey {
    return QualifiedVersionKey(
      package: package,
      version: version,
    );
  }

  /// Updates the current instance with the newly derived data.
  /// Returns true if the current instance changed.
  bool updateIfChanged({
    required String? pubspecContentAsYaml,
  }) {
    var changed = false;
    if (pubspecContentAsYaml != null) {
      final newPubspec = Pubspec.fromYaml(pubspecContentAsYaml);
      // TODO: consider deep compare of the pubspec data
      if (pubspec!.jsonString != newPubspec.jsonString) {
        pubspec = newPubspec;
        changed = true;
      }
    }
    return changed;
  }

  /// List of tags from the properties on the current [PackageVersion] entity.
  Iterable<String> getTags() {
    return <String>{
      if (pubspec!.supportsOnlyLegacySdk) ...[
        PackageVersionTags.isLegacy,
        PackageTags.isUnlisted,
      ],
      if (pubspec!.funding.isNotEmpty) PackageVersionTags.hasFundingLink,
      if (pubspec!.hasTopic) PackageVersionTags.hasTopic,
    };
  }

  bool get canBeRetracted =>
      !isRetracted &&
      created!.isAfter(clock.now().toUtc().subtract(const Duration(days: 7)));

  bool get canUndoRetracted =>
      isRetracted &&
      retracted!.isAfter(clock.now().toUtc().subtract(const Duration(days: 7)));

  void updateIsModerated({
    required bool isModerated,
  }) {
    this.isModerated = isModerated;
    moderatedAt = isModerated ? clock.now().toUtc() : null;
  }
}

/// A derived entity that holds derived/cleaned content of [PackageVersion].
@db.Kind(name: 'PackageVersionInfo', idType: db.IdType.String)
class PackageVersionInfo extends db.ExpandoModel<String> {
  @db.StringProperty(required: true)
  String? package;

  @db.StringProperty(required: true)
  String? version;

  /// The created timestamp of the [PackageVersion] (the time of publishing).
  @db.DateTimeProperty(required: true)
  DateTime? versionCreated;

  @db.DateTimeProperty(required: true)
  DateTime? updated;

  @db.StringListProperty()
  List<String>? libraries = <String>[];

  @db.IntProperty(required: true)
  int? libraryCount;

  /// The [AssetKind] identifier of assets extracted from the archive.
  @db.StringListProperty()
  List<String> assets = <String>[];

  @db.IntProperty()
  int? assetCount;

  PackageVersionInfo();

  /// Updates the current instance with the newly [derived] data.
  /// Returns true if the current instance changed.
  bool updateIfChanged(PackageVersionInfo derived) {
    var changed = false;
    if (versionCreated != derived.versionCreated) {
      versionCreated = derived.versionCreated;
      changed = true;
    }
    // TODO: implement more efficient difference check
    if (json.encode(libraries) != json.encode(derived.libraries)) {
      libraries = derived.libraries;
      changed = true;
    }
    if (libraryCount != (libraries?.length ?? 0)) {
      libraryCount = libraries?.length ?? 0;
      changed = true;
    }
    // TODO: implement more efficient difference check
    if (json.encode(assets) != json.encode(derived.assets)) {
      assets = derived.assets;
      changed = true;
    }
    if (assetCount != (assets.length)) {
      assetCount = assets.length;
      changed = true;
    }
    if (changed) {
      updated = clock.now().toUtc();
    }
    return changed;
  }

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

  bool get hasLicense => assets.contains(AssetKind.license);
}

/// The kind classifier of the extracted [PackageVersionAsset].
abstract class AssetKind {
  static const pubspec = 'pubspec';
  static const readme = 'readme';
  static const changelog = 'changelog';
  static const example = 'example';
  static const license = 'license';
}

/// A derived entity that holds extracted asset of a [PackageVersion] archive.
@db.Kind(name: 'PackageVersionAsset', idType: db.IdType.String)
class PackageVersionAsset extends db.ExpandoModel {
  /// ID format: an URI path with <package>/<version>/<kind>
  String get assetId => id as String;

  /// The name of the package.
  @db.StringProperty(required: true)
  String? package;

  /// The version of the package (e.g. `1.0.0`)
  @db.StringProperty(required: true)
  String? version;

  /// The combined name and version of the package (e.g. `package/1.0.0`).
  /// Can be used for version-specific listing.
  @db.StringProperty(required: true)
  String? packageVersion;

  /// One of the values in [AssetKind].
  @db.StringProperty(required: true)
  String? kind;

  /// The created timestamp of the [PackageVersion] (the time of publishing).
  @db.DateTimeProperty(required: true)
  DateTime? versionCreated;

  @db.DateTimeProperty(required: true)
  DateTime? updated;

  @db.StringProperty(required: true, indexed: false)
  String? path;

  @db.StringProperty(required: true, indexed: false)
  String? textContent;

  PackageVersionAsset();

  PackageVersionAsset.init({
    required this.package,
    required this.version,
    required this.kind,
    required this.versionCreated,
    DateTime? updated,
    required this.path,
    required this.textContent,
  }) {
    id = Uri(pathSegments: [package!, version!, kind!]).path;
    packageVersion = Uri(pathSegments: [package!, version!]).path;
    this.updated = updated ?? clock.now().toUtc();
  }

  /// Updates the current instance with the newly [derived] data.
  /// Returns true if the current instance changed.
  bool updateIfChanged(PackageVersionAsset derived) {
    var changed = false;
    if (versionCreated != derived.versionCreated) {
      versionCreated = derived.versionCreated;
      changed = true;
    }
    if (path != derived.path) {
      path = derived.path;
      changed = true;
    }
    if (textContent != derived.textContent) {
      textContent = derived.textContent;
      changed = true;
    }
    if (changed) {
      updated = clock.now().toUtc();
    }
    return changed;
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
class ModeratedPackage extends db.ExpandoModel<String> {
  @db.StringProperty(required: true)
  String? name;

  @db.DateTimeProperty()
  late DateTime moderated;

  /// The previous publisher id (null, if the package did not have a publisher).
  @db.StringProperty()
  String? publisherId;

  /// List of User.userId of previous uploaders.
  @db.StringListProperty()
  List<String>? uploaders;

  /// List of previous versions.
  @db.StringListProperty()
  List<String>? versions;
}

/// Entity representing a reserved package: the name is available only
/// for a subset of the users (`@google.com` + list of [emails]).
@db.Kind(name: 'ReservedPackage', idType: db.IdType.String)
class ReservedPackage extends db.ExpandoModel<String> {
  @db.StringProperty(required: true)
  String? name;

  @db.DateTimeProperty()
  late DateTime created;

  /// List of email addresses that are allowed to claim this package name.
  /// This is on top of the `@google.com` email addresses.
  @db.StringListProperty()
  List<String> emails = <String>[];

  ReservedPackage();
  ReservedPackage.init(this.name) {
    id = name;
    created = clock.now().toUtc();
  }
}

/// An identifier to point to a specific [package] and [version].
class QualifiedVersionKey {
  final String? package;
  final String? version;

  QualifiedVersionKey({
    required this.package,
    required this.version,
  });

  /// The qualified key in `<package>/<version>` format.
  String get qualifiedVersion => Uri(pathSegments: [package!, version!]).path;

  String assetId(String kind) =>
      Uri(pathSegments: [package!, version!, kind]).path;

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
class PackageView {
  final String name;
  final LatestReleases releases;
  final String? ellipsizedDescription;

  /// The date when the package was first published.
  final DateTime created;
  final String? publisherId;
  final bool isPending;

  final int likes;

  /// The package's granted points from pana and dartdoc analysis.
  /// May be `null` if the analysis is not available yet.
  final int? grantedPubPoints;

  /// The package's max points from pana and dartdoc analysis.
  /// May be `null` if the analysis is not available yet.
  final int? maxPubPoints;

  final List<String> tags;

  /// The package that should be used instead of the current package.
  /// May have a value only if the package is discontinued.
  final String? replacedBy;

  /// The recognized SPDX identifiers of the licenses for the package.
  final List<String>? spdxIdentifiers;
  final List<ApiPageRef>? apiPages;
  final List<ProcessedScreenshot>? screenshots;

  final List<String>? topics;
  final int popularity;

  PackageView({
    this.screenshots,
    required this.name,
    required this.releases,
    this.ellipsizedDescription,
    required this.created,
    this.publisherId,
    bool? isPending,
    required this.likes,
    this.grantedPubPoints,
    this.maxPubPoints,
    List<String>? tags,
    this.replacedBy,
    this.spdxIdentifiers,
    this.apiPages,
    this.topics,
    required this.popularity,
  })  : isPending = isPending ?? false,
        tags = tags ?? <String>[];

  factory PackageView.fromJson(Map<String, dynamic> json) =>
      _$PackageViewFromJson(json);

  factory PackageView.fromModel({
    required Package package,
    required LatestReleases releases,
    PackageVersion? version,
    required ScoreCardData scoreCard,
    List<ApiPageRef>? apiPages,
    required int popularity,
  }) {
    final tags = <String>{
      ...package.getTags(),
      ...?version?.getTags(),
      ...?scoreCard.derivedTags,
    };
    return PackageView(
      name: package.name!,
      releases: releases,
      ellipsizedDescription: version?.ellipsizedDescription,
      created: package.created!,
      publisherId: package.publisherId,
      isPending: scoreCard.isPending,
      likes: package.likes,
      grantedPubPoints: scoreCard.grantedPubPoints,
      maxPubPoints: scoreCard.maxPubPoints,
      tags: tags.toList(),
      replacedBy: package.replacedBy,
      spdxIdentifiers:
          scoreCard.panaReport?.licenses?.map((e) => e.spdxIdentifier).toList(),
      apiPages: apiPages,
      screenshots: scoreCard.panaReport?.screenshots,
      topics: version?.pubspec?.canonicalizedTopics,
      popularity: popularity,
    );
  }

  PackageView change({List<ApiPageRef>? apiPages}) {
    return PackageView(
      name: name,
      releases: releases,
      ellipsizedDescription: ellipsizedDescription,
      created: created,
      publisherId: publisherId,
      isPending: isPending,
      likes: likes,
      grantedPubPoints: grantedPubPoints,
      maxPubPoints: maxPubPoints,
      tags: tags,
      replacedBy: replacedBy,
      spdxIdentifiers: spdxIdentifiers,
      apiPages: apiPages ?? this.apiPages,
      screenshots: screenshots,
      topics: topics,
      popularity: popularity,
    );
  }

  Map<String, dynamic> toJson() => _$PackageViewToJson(this);

  bool get isDiscontinued => tags.contains(PackageTags.isDiscontinued);
  bool get isLegacy => tags.contains(PackageVersionTags.isLegacy);
  bool get isObsolete => tags.contains(PackageVersionTags.isObsolete);
}

/// Sorts [versions] according to the semantic versioning specification.
///
/// If [pubSorting] is `true` then pub's prioritization ordering is used, which
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
  final String? homepageUrl;

  /// `documentation` property in `pubspec.yaml`
  final String? documentationUrl;

  /// `repository` property in `pubspec.yaml`, or if not specified, an inferred
  /// URL from [homepageUrl].
  final String? repositoryUrl;

  /// `issue_tracker` property in `pubspec.yaml`, or if not specified, an
  /// inferred URL from [repositoryUrl].
  final String? issueTrackerUrl;

  /// The link to `CONTRIBUTING.md` in the git repository (when the repository is verified).
  final String? contributingUrl;

  /// The inferred base URL that can be used to link files from.
  final String? _baseUrl;

  PackageLinks._(
    this._baseUrl, {
    this.homepageUrl,
    String? documentationUrl,
    this.repositoryUrl,
    this.issueTrackerUrl,
    this.contributingUrl,
  }) : documentationUrl = urls.hideUserProvidedDocUrl(documentationUrl)
            ? null
            : documentationUrl;

  factory PackageLinks.infer({
    String? homepageUrl,
    String? documentationUrl,
    String? repositoryUrl,
    String? issueTrackerUrl,
  }) {
    repositoryUrl ??= urls.inferRepositoryUrl(homepageUrl);
    issueTrackerUrl ??= urls.inferIssueTrackerUrl(repositoryUrl);
    final baseUrl = urls.inferBaseUrl(
      homepageUrl: homepageUrl,
      repositoryUrl: repositoryUrl,
    );
    return PackageLinks._(
      baseUrl,
      homepageUrl: homepageUrl,
      documentationUrl: documentationUrl,
      repositoryUrl: repositoryUrl,
      issueTrackerUrl: issueTrackerUrl,
    );
  }
}

/// Common data structure shared between package pages.
class PackagePageData {
  final Package package;
  final LatestReleases latestReleases;
  final PackageVersion version;
  final PackageVersionInfo versionInfo;
  final PackageVersionAsset? asset;
  final ScoreCardData scoreCard;
  final bool isAdmin;
  final bool isLiked;
  PackageView? _view;

  PackagePageData({
    required this.package,
    LatestReleases? latestReleases,
    required this.version,
    required this.versionInfo,
    required this.asset,
    required this.scoreCard,
    required this.isAdmin,
    required this.isLiked,
  }) : latestReleases = latestReleases ?? package.latestReleases;

  bool get hasReadme => versionInfo.assets.contains(AssetKind.readme);
  bool get hasChangelog => versionInfo.assets.contains(AssetKind.changelog);
  bool get hasExample => versionInfo.assets.contains(AssetKind.example);
  bool get hasLicense => versionInfo.assets.contains(AssetKind.license);
  bool get hasPubspec => versionInfo.assets.contains(AssetKind.pubspec);

  bool get isLatestStable => version.version == package.latestVersion;

  late final packageLinks = () {
    // start with the URLs from pubspec.yaml
    final pubspec = version.pubspec!;
    final inferred = PackageLinks.infer(
      homepageUrl: pubspec.homepage,
      documentationUrl: pubspec.documentation,
      repositoryUrl: pubspec.repository,
      issueTrackerUrl: pubspec.issueTracker,
    );

    // Use verified URLs when they are available.
    final result = scoreCard.panaReport?.result;
    if (result == null) {
      return inferred;
    }

    final baseUrl = urls.inferBaseUrl(
      homepageUrl: result.homepageUrl ?? inferred.homepageUrl,
      repositoryUrl: result.repositoryUrl ?? inferred.repositoryUrl,
    );
    return PackageLinks._(
      baseUrl,
      homepageUrl: result.homepageUrl ?? inferred.homepageUrl,
      repositoryUrl: result.repositoryUrl ?? inferred.repositoryUrl,
      issueTrackerUrl: result.issueTrackerUrl ?? inferred.issueTrackerUrl,
      documentationUrl: result.documentationUrl ?? inferred.documentationUrl,
      contributingUrl: result.contributingUrl ?? inferred.contributingUrl,
    );
  }();

  /// The verified repository (or homepage).
  late final urlResolverFn =
      scoreCard.panaReport?.result?.repository?.resolveUrl ??
          fallbackUrlResolverFn(packageLinks._baseUrl);

  PackageView toPackageView() {
    return _view ??= PackageView.fromModel(
      package: package,
      releases: latestReleases,
      version: version,
      scoreCard: scoreCard,
      popularity: popularityStorage.lookupAsScore(package.name!),
    );
  }
}

/// Describes the list of packages names and the continuation token for the next page.
class PackageListPage {
  final List<String> packages;
  final String? nextPackage;

  PackageListPage({
    required this.packages,
    this.nextPackage,
  });
}
