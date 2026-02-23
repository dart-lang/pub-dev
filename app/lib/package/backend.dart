// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:_pub_shared/data/account_api.dart' as account_api;
import 'package:_pub_shared/data/package_api.dart' as api;
import 'package:_pub_shared/utils/sdk_version_cache.dart';
import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pool/pool.dart';
import 'package:pub_dev/package/api_export/api_exporter.dart';
import 'package:pub_dev/package/tarball_storage.dart';
import 'package:pub_dev/scorecard/backend.dart';
import 'package:pub_dev/service/async_queue/async_queue.dart';
import 'package:pub_dev/service/rate_limit/rate_limit.dart';
import 'package:pub_dev/shared/changelog.dart';
import 'package:pub_dev/shared/monitoring.dart';
import 'package:pub_dev/shared/versions.dart';
import 'package:pub_dev/task/backend.dart';
import 'package:pub_package_reader/pub_package_reader.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec_parse/pubspec_parse.dart' as pubspec_parse;

import '../account/agent.dart';
import '../account/backend.dart';
import '../account/consent_backend.dart';
import '../account/models.dart' show User;
import '../audit/models.dart';
import '../publisher/backend.dart';
import '../service/email/backend.dart';
import '../service/email/email_templates.dart';
import '../service/email/models.dart';
import '../service/secret/backend.dart';
import '../shared/configuration.dart';
import '../shared/datastore.dart';
import '../shared/exceptions.dart';
import '../shared/redis_cache.dart' show cache;
import '../shared/storage.dart';
import '../shared/urls.dart' as urls;
import '../shared/utils.dart';
import 'model_properties.dart';
import 'models.dart';
import 'name_tracker.dart';
import 'overrides.dart';
import 'upload_signer_service.dart';

// The maximum stored length of `README.md` and other user-provided file content
// that is stored separately in the database.
final maxAssetContentLength = 256 * 1024;

/// The maximum number of versions a package is allowed to have.
final _defaultMaxVersionsPerPackage = 1000;

final Logger _logger = Logger('pub.cloud_repository');
final _validGitHubUserOrRepoRegExp = RegExp(
  r'^[a-z0-9\-\._]+$',
  caseSensitive: false,
);
// NOTE: The `/` character is allowed inside the tag pattern because we are
//       not splitting the `refs/tags/` prefix. A change of that parsing
//       should specifically test the presence of `/`.
final _validGitHubVersionPattern = RegExp(
  r'^[a-z0-9\-._/]+$',
  caseSensitive: false,
);
final _validGitHubEnvironment = RegExp(
  r'^[a-z0-9\-\._]+$',
  caseSensitive: false,
);

/// Sets the package backend service.
void registerPackageBackend(PackageBackend backend) =>
    ss.register(#_packageBackend, backend);

/// The active package backend service.
PackageBackend get packageBackend =>
    ss.lookup(#_packageBackend) as PackageBackend;

/// Represents the backend for the pub site.
class PackageBackend {
  final DatastoreDB db;

  final Storage _storage;

  /// The Cloud Storage bucket to use for incoming package archives.
  /// The following files are present:
  /// - `tmp/$guid` (incoming package archive that was uploaded, but not yet processed)
  final Bucket _incomingBucket;

  /// The storage handling for the package archive files.
  final TarballStorage tarballStorage;

  @visibleForTesting
  int maxVersionsPerPackage = _defaultMaxVersionsPerPackage;

  PackageBackend(
    this.db,
    this._storage,
    this._incomingBucket,
    Bucket canonicalBucket,
    Bucket publicBucket,
  ) : tarballStorage = TarballStorage(
        db,
        _storage,
        canonicalBucket,
        publicBucket,
      );

  /// Whether the package exists and is not blocked or deleted.
  Future<bool> isPackageVisible(String package) async {
    return (await cache.packageVisible(package).get(() async {
      final p = await db.lookupOrNull<Package>(
        db.emptyKey.append(Package, id: package),
      );
      return p != null && p.isVisible;
    }))!;
  }

  Stream<Package> allPackages() => db.query<Package>().run();

  Stream<String> allPackageNames() {
    return allPackages().map((p) => p.name!);
  }

  /// Retrieves the packages that need to be included in sitemap.txt.
  Stream<Package> sitemapPackageNames() {
    final query = db.query<Package>()
      ..filter(
        'updated >',
        clock.now().toUtc().subtract(robotsVisibilityMaxAge),
      );
    return query
        .run()
        .where((p) => p.isVisible)
        .where((p) => p.isIncludedInRobots)
        .where((p) => !isSdkPackage(p.name!));
  }

  /// Retrieves package versions ordered by their published date descending.
  Future<List<PackageVersion>> latestPackageVersions({
    int offset = 0,
    required int limit,
  }) async {
    final query = db.query<PackageVersion>()
      ..order('-created')
      ..offset(offset)
      ..limit(limit);
    final versions = await query.run().toList();
    final results = <PackageVersion>[];
    for (final v in versions) {
      if (isSdkPackage(v.package)) continue;
      if (!(await isPackageVisible(v.package))) continue;
      results.add(v);
    }
    return results;
  }

  /// Returns the latest stable version of a package.
  Future<String?> getLatestVersion(String package) async {
    return cache.packageLatestVersion(package).get(() async {
      final p = await db.lookupOrNull<Package>(
        db.emptyKey.append(Package, id: package),
      );
      return p?.latestVersion;
    });
  }

  /// Looks up a package by name.
  ///
  /// Returns `null` if the package doesn't exist.
  Future<Package?> lookupPackage(String packageName) async {
    final packageKey = db.emptyKey.append(Package, id: packageName);
    return await db.lookupOrNull<Package>(packageKey);
  }

  /// Looks up a moderated package by name.
  ///
  /// Returns `null` if the package doesn't exist.
  Future<ModeratedPackage?> lookupModeratedPackage(String packageName) async {
    final packageKey = db.emptyKey.append(ModeratedPackage, id: packageName);
    return await db.lookupOrNull<ModeratedPackage>(packageKey);
  }

  /// Looks up a reserved package by name.
  ///
  /// Returns `null` if the package doesn't exist.
  Future<ReservedPackage?> lookupReservedPackage(String packageName) async {
    final packageKey = db.emptyKey.append(ReservedPackage, id: packageName);
    return await db.lookupOrNull<ReservedPackage>(packageKey);
  }

  /// Lists the currently reserved package names. A reserved package prefix is a regular name
  /// that ends with `_` (underscore).
  ///
  /// List the prefixes in descending length for easier matching.
  Future<List<String>> listReservedPackagePrefixes() async {
    return await cache.reservedPackagePrefixes().get(() async {
          final list = <String>[];
          await for (final p in db.query<ReservedPackage>().run()) {
            final name = p.name;
            if (name != null && name.endsWith('_')) {
              list.add(name);
            }
          }
          list.sort((a, b) {
            if (a.length != b.length) {
              return -a.length.compareTo(b.length);
            }
            return a.compareTo(b);
          });
          return list;
        })
        as List<String>;
  }

  /// Looks up a package by name.
  Future<List<Package>> lookupPackages(Iterable<String> packageNames) async {
    return (await db.lookup(
      packageNames.map((p) => db.emptyKey.append(Package, id: p)).toList(),
    )).cast();
  }

  /// List all packages where the [userId] is an uploader.
  Future<PackageListPage> listPackagesForUser(
    String userId, {
    String? next,
    int limit = 10,
  }) async {
    final query = db.query<Package>()
      ..filter('uploaders =', userId)
      ..order('name')
      ..limit(limit + 1);
    if (next != null) {
      query.filter('name >=', next);
    }
    final packages = await query.run().toList();
    return PackageListPage(
      packages: packages.take(limit).map((p) => p.name!).toList(),
      nextPackage: packages.length <= limit ? null : packages.last.name!,
    );
  }

  /// Streams package names where the [userId] is an uploader.
  Stream<String> streamPackagesWhereUserIsUploader(
    String userId, {
    int pageSize = 100,
  }) async* {
    var page = await listPackagesForUser(userId, limit: pageSize);
    while (page.packages.isNotEmpty) {
      yield* Stream.fromIterable(page.packages);
      if (page.nextPackage == null) {
        break;
      } else {
        page = await listPackagesForUser(userId, next: page.nextPackage);
      }
    }
  }

  /// Returns the cached list of package names, where the [userId] is an uploader
  /// (package is not under a publisher).
  Future<List<String>> cachedPackagesWhereUserIsUploader(String userId) async {
    final list = await cache.userUploaderOfPackages(userId).get(() async {
      return await streamPackagesWhereUserIsUploader(
        userId,
      ).take(1000).toList();
    });
    return list as List<String>;
  }

  /// Returns the latest releases info of a package.
  Future<LatestReleases> latestReleases(Package package) async {
    // TODO: implement runtimeVersion-specific release calculation
    return package.latestReleases;
  }

  /// Looks up a specific package version.
  ///
  /// Returns null if the version is not a semantic version or if the version
  /// entity does not exists in the datastore.
  Future<PackageVersion?> lookupPackageVersion(
    String package,
    String version,
  ) async {
    final canonicalVersion = canonicalizeVersion(version);
    if (canonicalVersion == null) return null;
    final packageVersionKey = db.emptyKey
        .append(Package, id: package)
        .append(PackageVersion, id: canonicalVersion);
    return await db.lookupOrNull<PackageVersion>(packageVersionKey);
  }

  /// Looks up a specific package version's info object.
  ///
  /// Returns null if the [version] is not a semantic version or if the info
  /// entity does not exists in the datastore.
  Future<PackageVersionInfo?> lookupPackageVersionInfo(
    String package,
    String version,
  ) async {
    final canonicalVersion = canonicalizeVersion(version);
    if (canonicalVersion == null) return null;
    final qvk = QualifiedVersionKey(
      package: package,
      version: canonicalVersion,
    );
    return await db.lookupOrNull<PackageVersionInfo>(
      db.emptyKey.append(PackageVersionInfo, id: qvk.qualifiedVersion),
    );
  }

  /// Looks up a specific package version's asset object.
  ///
  /// Returns null if the [version] is not a semantic version or if the asset
  /// entity does not exists in the Datastore.
  Future<PackageVersionAsset?> lookupPackageVersionAsset(
    String package,
    String version,
    String assetKind,
  ) async {
    final canonicalVersion = canonicalizeVersion(version);
    if (canonicalVersion == null) return null;
    final qvk = QualifiedVersionKey(
      package: package,
      version: canonicalVersion,
    );
    return await db.lookupOrNull<PackageVersionAsset>(
      db.emptyKey.append(PackageVersionAsset, id: qvk.assetId(assetKind)),
    );
  }

  /// Looks up the qualified [versions].
  Future<List<PackageVersion?>> lookupVersions(
    Iterable<QualifiedVersionKey> versions,
  ) async {
    return await db.lookup<PackageVersion>(
      versions
          .map(
            (k) => db.emptyKey
                .append(Package, id: k.package)
                .append(PackageVersion, id: k.version),
          )
          .toList(),
    );
  }

  /// Looks up all versions of a package and return them as a [List].
  Future<List<PackageVersion>> versionsOfPackage(String packageName) async {
    return streamVersionsOfPackage(packageName).toList();
  }

  /// Looks up all versions of a package and return them as a [Stream].
  Stream<PackageVersion> streamVersionsOfPackage(
    String packageName, {
    String? order,
    int? limit,
  }) {
    final packageKey = db.emptyKey.append(Package, id: packageName);
    final query = db.query<PackageVersion>(ancestorKey: packageKey);
    if (order != null) {
      query.order(order);
    }
    if (limit != null && limit > 0) {
      query.limit(limit);
    }
    return query.run();
  }

  /// List the versions of [package] that are published in the last N [days].
  Future<List<PackageVersion>> _listVersionsFromPastDays(
    String package, {
    required int days,
    bool Function(PackageVersion pv)? where,
  }) async {
    final packageKey = db.emptyKey.append(Package, id: package);
    final query = db.query<PackageVersion>(
      ancestorKey: packageKey,
    )..filter('created >=', clock.now().toUtc().subtract(Duration(days: days)));
    return await query.run().where((pv) => where == null || where(pv)).toList();
  }

  /// List retractable versions.
  Future<List<PackageVersion>> listRetractableVersions(String package) async {
    return await _listVersionsFromPastDays(
      package,
      days: 7,
      where: (pv) => pv.canBeRetracted,
    );
  }

  /// List versions that are retracted and the retraction is recent, it can be undone.
  Future<List<PackageVersion>> listRecentlyRetractedVersions(
    String package,
  ) async {
    return await _listVersionsFromPastDays(
      package,
      days: 14,
      where: (pv) => pv.canUndoRetracted,
    );
  }

  /// Get a [Uri] which can be used to download a tarball of the pub package.
  Future<Uri> downloadUrl(String package, String version) async {
    InvalidInputException.checkSemanticVersion(version);
    final cv = canonicalizeVersion(version);
    // NOTE: We should maybe check for existence first?
    // return storage.bucket(bucket).info(object)
    //     .then((info) => info.downloadLink);
    return tarballStorage.getPublicDownloadUrl(package, cv!);
  }

  /// Updates the stable, prerelease and preview versions of [package].
  ///
  /// Returns true if the values did change.
  Future<bool> updatePackageVersions(
    String package, {
    Version? dartSdkVersion,
    Version? flutterSdkVersion,
  }) async {
    _logger.info("Checking Package's versions fields for package `$package`.");
    final pkgKey = db.emptyKey.append(Package, id: package);
    dartSdkVersion ??= (await getCachedDartSdkVersion(
      lastKnownStable: toolStableDartSdkVersion,
    )).semanticVersion;
    flutterSdkVersion ??= (await getCachedFlutterSdkVersion(
      lastKnownStable: toolStableFlutterSdkVersion,
    )).semanticVersion;

    // ordered version list by publish date
    final versions = await db
        .query<PackageVersion>(ancestorKey: pkgKey)
        .run()
        .toList();

    final updated = await withRetryTransaction(db, (tx) async {
      final p = await tx.lookupOrNull<Package>(pkgKey);
      if (p == null) {
        throw NotFoundException.resource('package "$package"');
      }

      final changed = p.updateVersions(
        versions,
        dartSdkVersion: dartSdkVersion!,
        flutterSdkVersion: flutterSdkVersion!,
      );

      if (!changed) {
        _logger.info('No version field updates for package `$package`.');
        return false;
      }

      _logger.info('Updating version fields for package `$package`.');
      tx.insert(p);
      return true;
    });
    if (updated) {
      triggerPackagePostUpdates(
        package,
        skipReanalysis: true,
        skipExport: true,
      );
    }
    return updated;
  }

  /// Updates the stable, prerelease and preview versions of all package.
  ///
  /// Return the number of updated packages.
  Future<int> updateAllPackageVersions({
    Version? dartSdkVersion,
    int? concurrency,
  }) async {
    final pool = Pool(concurrency ?? 1);
    var count = 0;
    final futures = <Future>[];
    await for (final p in db.query<Package>().run()) {
      final package = p.name!;
      final f = pool.withResource(() async {
        final updated = await updatePackageVersions(
          package,
          dartSdkVersion: dartSdkVersion,
        );
        if (updated) count++;
      });
      futures.add(f);
    }
    await Future.wait(futures);
    await pool.close();
    return count;
  }

  /// Returns the package options.
  Future<api.PkgOptions> getPackageOptions(String package) async {
    checkPackageVersionParams(package);
    final p = await packageBackend.lookupPackage(package);
    if (p == null) {
      throw NotFoundException.resource(package);
    }
    return api.PkgOptions(
      isDiscontinued: p.isDiscontinued,
      replacedBy: p.replacedBy,
      isUnlisted: p.isUnlisted,
    );
  }

  /// Updates [options] on [package].
  Future<void> updateOptions(String package, api.PkgOptions options) async {
    final authenticatedUser = await requireAuthenticatedWebUser();
    final user = authenticatedUser.user;
    // Validate replacedBy parameter
    final replacedBy = options.replacedBy?.trim() ?? '';
    InvalidInputException.check(
      package != replacedBy,
      '"replacedBy" must point to a different package.',
    );
    if (replacedBy.isNotEmpty) {
      InvalidInputException.check(
        options.isDiscontinued == true,
        '"replacedBy" must be set only with "isDiscontinued": true.',
      );

      final rp = await lookupPackage(replacedBy);
      InvalidInputException.check(
        rp != null && rp.isVisible,
        'Package specified by "replaceBy" does not exists.',
      );
      InvalidInputException.check(
        rp != null && !rp.isDiscontinued,
        'Package specified by "replaceBy" must not be discontinued.',
      );
    }

    final pkg = await _requirePackageAdmin(package, user.userId);
    await withRetryTransaction(db, (tx) async {
      final p = await tx.lookupValue<Package>(pkg.key);

      final optionsChanges = <String>[];
      if (options.isDiscontinued != null &&
          options.isDiscontinued != p.isDiscontinued) {
        p.isDiscontinued = options.isDiscontinued!;
        if (!p.isDiscontinued) {
          p.replacedBy = null;
        }
        optionsChanges.add('discontinued');
      }
      if (options.isDiscontinued == true &&
          (p.replacedBy ?? '') != replacedBy) {
        p.replacedBy = replacedBy.isEmpty ? null : replacedBy;
        optionsChanges.add('replacedBy');
      }
      if (options.isUnlisted != null && options.isUnlisted != p.isUnlisted) {
        p.isUnlisted = options.isUnlisted!;
        optionsChanges.add('unlisted');
      }

      if (optionsChanges.isEmpty) {
        return;
      }

      p.updated = clock.now().toUtc();
      _logger.info(
        'Updating $package options: '
        'isDiscontinued: ${p.isDiscontinued} '
        'isUnlisted: ${p.isUnlisted}',
      );
      tx.insert(p);
      tx.insert(
        await AuditLogRecord.packageOptionsUpdated(
          agent: authenticatedUser,
          package: p.name!,
          publisherId: p.publisherId,
          options: optionsChanges,
        ),
      );
    });
    triggerPackagePostUpdates(package, skipArchiveExport: true);
  }

  /// Updates [options] on [package]/[version], assuming the current user
  /// has proper rights, and the option change is allowed.
  Future<void> updatePackageVersionOptions(
    String package,
    String version,
    api.VersionOptions options,
  ) async {
    final authenticatedUser = await requireAuthenticatedWebUser();
    final user = authenticatedUser.user;

    final pkg = await _requirePackageAdmin(package, user.userId);
    final versionKey = pkg.key.append(PackageVersion, id: version);
    await withRetryTransaction(db, (tx) async {
      final p = await tx.lookupValue<Package>(pkg.key);
      final pv = await tx.lookupOrNull<PackageVersion>(versionKey);
      if (pv == null) {
        throw NotFoundException.resource(version);
      }
      if (pv.isNotVisible) {
        throw ModeratedException.packageVersion(package, version);
      }

      if (options.isRetracted != null &&
          options.isRetracted != pv.isRetracted) {
        if (options.isRetracted!) {
          InvalidInputException.check(
            pv.canBeRetracted,
            'Can\'t retract package "$package" version "$version".',
          );
        } else {
          InvalidInputException.check(
            pv.canUndoRetracted,
            'Can\'t undo retraction of package "$package" version "$version".',
          );
        }
        await doUpdateRetractedStatus(
          authenticatedUser,
          tx,
          p,
          pv,
          options.isRetracted!,
        );
      }
    });
    await purgeScorecardData(
      package,
      version,
      isLatest: pkg.latestVersion == version,
    );
    triggerPackagePostUpdates(package);
  }

  /// Verifies an update to the credential-less publishing settings and
  /// updates the Datastore entity if everything is valid.
  Future<api.PkgPublishingConfig> setAutomatedPublishing(
    String package,
    api.PkgPublishingConfig body,
  ) async {
    final authenticatedUser = await requireAuthenticatedWebUser();
    final user = authenticatedUser.user;
    final pkg = await _requirePackageAdmin(package, user.userId);
    return await withRetryTransaction(db, (tx) async {
      final p = await tx.lookupValue<Package>(pkg.key);
      final githubConfig = body.github;
      final gcpConfig = body.gcp;
      final manualConfig = body.manual;

      if (githubConfig != null) {
        final isEnabled = githubConfig.isEnabled;

        InvalidInputException.check(
          githubConfig.isPushEventEnabled ||
              githubConfig.isWorkflowDispatchEventEnabled,
          'At least one of the events (`push` or `workflow_dispatch`) must be enabled.',
        );

        // normalize input values
        final repository = githubConfig.repository?.trim() ?? '';
        githubConfig.repository = repository.isEmpty ? null : repository;
        final tagPattern = githubConfig.tagPattern?.trim() ?? '';
        if (isEnabled) {
          verifyTagPattern(tagPattern: tagPattern);
        }
        githubConfig.tagPattern = tagPattern.isEmpty ? null : tagPattern;
        final environment = githubConfig.environment?.trim() ?? '';
        githubConfig.environment = environment.isEmpty ? null : environment;

        InvalidInputException.check(
          !isEnabled || repository.isNotEmpty,
          'The `repository` field must not be empty when enabled.',
        );

        if (repository.isNotEmpty) {
          final parts = repository.split('/');
          InvalidInputException.check(
            parts.length == 2,
            'The `repository` field must follow the `<owner>/<repository>` pattern.',
          );
          InvalidInputException.check(
            _validGitHubUserOrRepoRegExp.hasMatch(parts[0]) &&
                _validGitHubUserOrRepoRegExp.hasMatch(parts[1]),
            'The `repository` field has invalid characters.',
          );
        }

        InvalidInputException.check(
          !githubConfig.requireEnvironment || environment.isNotEmpty,
          'The `environment` field must not be empty when enabled.',
        );

        if (environment.isNotEmpty) {
          InvalidInputException.check(
            _validGitHubEnvironment.hasMatch(environment),
            'The `environment` field has invalid characters.',
          );
        }
      }
      if (gcpConfig != null) {
        final isEnabled = gcpConfig.isEnabled;
        // normalize input values
        final serviceAccountEmail = gcpConfig.serviceAccountEmail?.trim() ?? '';
        gcpConfig.serviceAccountEmail = serviceAccountEmail;

        InvalidInputException.check(
          !isEnabled || serviceAccountEmail.isNotEmpty,
          'The service account email field must not be empty when enabled.',
        );

        if (serviceAccountEmail.isNotEmpty) {
          InvalidInputException.check(
            isValidEmail(serviceAccountEmail),
            'The service account email is not valid: `$serviceAccountEmail`.',
          );

          InvalidInputException.check(
            serviceAccountEmail.endsWith('.gserviceaccount.com'),
            'The service account email must end with `.gserviceaccount.com`. '
            'If you have a different service account email, please create an issue at '
            'https://github.com/dart-lang/pub-dev',
          );
        }
      }

      // update lock
      final current = p.publishingConfig;
      final githubChanged =
          (githubConfig?.isEnabled != current?.githubConfig?.isEnabled) ||
          (githubConfig?.repository != current?.githubConfig?.repository);
      if (githubChanged) {
        p.publishingConfig?.githubLock = null;
      }
      final gcpChanged =
          (gcpConfig?.isEnabled != current?.gcpConfig?.isEnabled) ||
          (gcpConfig?.serviceAccountEmail !=
              current?.gcpConfig?.serviceAccountEmail);
      if (gcpChanged) {
        p.publishingConfig?.gcpLock = null;
      }

      // finalize changes
      final publishingConfig = p.publishingConfig ?? PublishingConfig();
      p.automatedPublishing = publishingConfig;
      p.newPublishingConfig = publishingConfig;
      publishingConfig.githubConfig =
          githubConfig ?? publishingConfig.githubConfig;
      publishingConfig.gcpConfig = gcpConfig ?? publishingConfig.gcpConfig;
      publishingConfig.manualConfig =
          manualConfig ?? publishingConfig.manualConfig;

      p.updated = clock.now().toUtc();
      tx.insert(p);
      tx.insert(
        await AuditLogRecord.packagePublicationAutomationUpdated(
          package: p.name!,
          publisherId: p.publisherId,
          user: user,
        ),
      );
      return api.PkgPublishingConfig(
        github: p.publishingConfig!.githubConfig,
        gcp: p.publishingConfig!.gcpConfig,
        manual: p.publishingConfig!.manualConfig,
      );
    });
  }

  /// Updates the retracted status inside a transaction.
  ///
  /// This is a helper method, and should be used only after appropriate
  /// input validation.
  Future<void> doUpdateRetractedStatus(
    AuthenticatedAgent agent,
    TransactionWrapper tx,
    Package p,
    PackageVersion pv,
    bool isRetracted,
  ) async {
    pv.isRetracted = isRetracted;
    pv.retracted = isRetracted ? clock.now() : null;

    // Update references to latest versions.
    final versions = await tx.query<PackageVersion>(p.key).run().toList();
    final currentDartSdk = await getCachedDartSdkVersion(
      lastKnownStable: toolStableDartSdkVersion,
    );
    final currentFlutterSdk = await getCachedFlutterSdkVersion(
      lastKnownStable: toolStableFlutterSdkVersion,
    );
    p.updateVersions(
      versions,
      dartSdkVersion: currentDartSdk.semanticVersion,
      flutterSdkVersion: currentFlutterSdk.semanticVersion,
      replaced: pv,
    );
    // Always update the "updated" timestamp, so these changes can be reflected
    // in exported API
    p.updated = clock.now().toUtc();

    _logger.info(
      'Updating ${p.name} ${pv.version} options: isRetracted: $isRetracted',
    );

    tx.insert(p);
    tx.insert(pv);
    tx.insert(
      await AuditLogRecord.packageVersionOptionsUpdated(
        agent: agent,
        package: p.name!,
        version: pv.version!,
        publisherId: p.publisherId,
        options: ['retracted'],
      ),
    );
  }

  /// Whether [userId] is a package admin (through direct uploaders list or
  /// publisher admin).
  ///
  /// Returns false if the user is not an admin.
  /// Returns false if the package is not visible e.g. blocked.
  Future<bool> isPackageAdmin(Package p, String userId) async {
    if (p.isNotVisible) {
      return false;
    }
    if (p.publisherId == null) {
      return p.containsUploader(userId);
    } else {
      final publisherId = p.publisherId!;
      final publisher = await publisherBackend.getListedPublisher(publisherId);
      if (publisher == null) {
        return false;
      }
      return await publisherBackend.isMemberAdmin(publisher, userId);
    }
  }

  /// Returns the publisher info of a given package.
  Future<api.PackagePublisherInfo> getPublisherInfo(String packageName) async {
    checkPackageVersionParams(packageName);
    final key = db.emptyKey.append(Package, id: packageName);
    final package = await db.lookupOrNull<Package>(key);
    if (package == null) {
      throw NotFoundException.resource('package "$packageName"');
    }
    return _asPackagePublisherInfo(package);
  }

  /// Returns the number of likes of a given package.
  Future<account_api.PackageLikesCount> getPackageLikesCount(
    String packageName,
  ) async {
    checkPackageVersionParams(packageName);
    final key = db.emptyKey.append(Package, id: packageName);
    final package = await db.lookupOrNull<Package>(key);
    if (package == null) {
      throw NotFoundException.resource('package "$packageName"');
    }
    return account_api.PackageLikesCount(
      package: packageName,
      likes: package.likes,
    );
  }

  /// Sets/updates the publisher of a package.
  Future<api.PackagePublisherInfo> setPublisher(
    String packageName,
    api.PackagePublisherInfo request,
  ) async {
    final newPublisherId = request.publisherId;
    InvalidInputException.checkNotNull(newPublisherId, 'publisherId');
    final authenticatedUser = await requireAuthenticatedWebUser();
    final user = authenticatedUser.user;

    final key = db.emptyKey.append(Package, id: packageName);
    final preTxPackage = await _requirePackageAdmin(packageName, user.userId);
    await requirePublisherAdmin(newPublisherId!, user.userId);
    if (preTxPackage.publisherId == newPublisherId) {
      // If desired publisherId is already the current publisherId, then we're already done.
      return _asPackagePublisherInfo(preTxPackage);
    }

    final preTxUploaderEmails = await _listAdminNotificationEmailsForPackage(
      preTxPackage,
    );
    final newPublisherAdminEmails = await publisherBackend.getAdminMemberEmails(
      newPublisherId,
    );
    final allAdminEmails = <String>{
      ...preTxUploaderEmails,
      ...newPublisherAdminEmails.nonNulls,
    };

    OutgoingEmail? email;
    String? currentPublisherId;
    final rs = await withRetryTransaction(db, (tx) async {
      final package = await tx.lookupValue<Package>(key);
      if (package.publisherId == newPublisherId) {
        // If desired publisherId is already the current publisherId, then we're already done.
        return _asPackagePublisherInfo(package);
      }
      currentPublisherId = package.publisherId;
      package.publisherId = newPublisherId;
      package.uploaders?.clear();
      package.updated = clock.now().toUtc();

      tx.insert(package);
      tx.insert(
        await AuditLogRecord.packageTransferred(
          user: user,
          package: package.name!,
          fromPublisherId: currentPublisherId,
          toPublisherId: package.publisherId!,
        ),
      );

      email = emailBackend.prepareEntity(
        createPackageTransferEmail(
          packageName: packageName,
          activeUserEmail: user.email!,
          oldPublisherId: currentPublisherId,
          newPublisherId: package.publisherId!,
          authorizedAdmins: allAdminEmails
              .map((email) => EmailAddress(email))
              .toList(),
        ),
      );
      tx.insert(email!);
      return _asPackagePublisherInfo(package);
    });
    await purgePublisherCache(newPublisherId);

    if (email != null) {
      await emailBackend.trySendOutgoingEmail(email!);
    }
    if (currentPublisherId != null) {
      await purgePublisherCache(currentPublisherId!);
    }
    triggerPackagePostUpdates(
      packageName,
      skipReanalysis: true,
      skipArchiveExport: true,
    );
    return rs;
  }

  /// Returns the known versions of [package].
  /// The available versions are sorted by their semantic version number (ascending).
  ///
  /// Used in `pub` client for finding which versions exist.
  Future<api.PackageData> listVersions(String package) async {
    final pkg = await packageBackend.lookupPackage(package);
    if (pkg == null || pkg.isNotVisible) {
      throw NotFoundException.resource('package "$package"');
    }
    final packageVersions = (await packageBackend.versionsOfPackage(
      package,
    )).where((v) => v.isVisible).toList();
    if (packageVersions.isEmpty) {
      throw NotFoundException.resource('package "$package"');
    }
    packageVersions.sort(
      (a, b) => a.semanticVersion.compareTo(b.semanticVersion),
    );
    final latest = packageVersions.firstWhere(
      (pv) => pv.version == pkg.latestVersion,
      orElse: () => packageVersions.last,
    );
    return api.PackageData(
      name: package,
      isDiscontinued: pkg.isDiscontinued ? true : null,
      replacedBy: pkg.replacedBy,
      latest: latest.toApiVersionInfo(),
      versions: packageVersions.map((pv) => pv.toApiVersionInfo()).toList(),
      advisoriesUpdated: pkg.latestAdvisory,
    );
  }

  /// Returns the known versions of [package] (via [listVersions]),
  /// getting it from cache if available.
  ///
  /// This returns gzipped UTF-8 encoded JSON.
  Future<List<int>> listVersionsGzCachedBytes(
    String package, {
    bool refreshVersionsCache = false,
  }) async {
    final entry = cache.packageDataGz(package);
    final cached = refreshVersionsCache ? null : await entry.get();
    if (cached != null) {
      return cached;
    }
    final data = await listVersions(package);
    final raw = jsonUtf8Encoder.convert(data.toJson());
    final zipped = gzip.encode(raw);
    await entry.set(zipped);
    return zipped;
  }

  /// Returns the known versions of [package] (via [listVersions]),
  /// getting it from the cache if available.
  ///
  ///  The available versions are sorted by their semantic version number (ascending).
  Future<api.PackageData> listVersionsCached(
    String package, {
    bool refreshVersionsCache = false,
  }) async {
    final data = await listVersionsGzCachedBytes(
      package,
      refreshVersionsCache: refreshVersionsCache,
    );
    return api.PackageData.fromJson(
      utf8JsonDecoder.convert(gzip.decode(data)) as Map<String, dynamic>,
    );
  }

  /// Lookup and return the API's version info object.
  ///
  /// Throws [NotFoundException] when the version is missing.
  Future<api.VersionInfo> lookupVersion(String package, String version) async {
    checkPackageVersionParams(package, version);
    final canonicalVersion = canonicalizeVersion(version);
    InvalidInputException.checkSemanticVersion(canonicalVersion);

    final packageVersionKey = db.emptyKey
        .append(Package, id: package)
        .append(PackageVersion, id: canonicalVersion);

    if (!await isPackageVisible(package)) {
      throw NotFoundException.resource('package "$package"');
    }
    final pv = await db.lookupOrNull<PackageVersion>(packageVersionKey);
    if (pv == null) {
      throw NotFoundException.resource('version "$version"');
    }

    return pv.toApiVersionInfo();
  }

  Future<api.UploadInfo> startUpload(Uri redirectUrl) async {
    final restriction = await getUploadRestrictionStatus();
    if (restriction == UploadRestrictionStatus.noUploads) {
      throw PackageRejectedException.uploadRestricted();
    }
    _logger.info('Starting async upload.');
    // NOTE: We use an authenticated user scope here to ensure the uploading
    // user is authenticated. But we're not validating anything at this point
    // because we don't even know which package or version is going to be
    // uploaded.
    await requireAuthenticatedClient();

    final guid = createUuid();
    final String object = tmpObjectName(guid);
    final String bucket = _incomingBucket.bucketName;
    final Duration lifetime = const Duration(minutes: 10);

    final url = redirectUrl.resolve('?upload_id=$guid');

    _logger.info(
      'Redirecting pub client to google cloud storage (uuid: $guid)',
    );
    return uploadSigner.buildUpload(
      bucket,
      object,
      lifetime,
      successRedirectUrl: '$url',
    );
  }

  /// Finishes the upload of a package and returns the list of messages
  /// related to the publishing.
  Future<List<String>> publishUploadedBlob(String uploadGuid) async {
    final restriction = await getUploadRestrictionStatus();
    if (restriction == UploadRestrictionStatus.noUploads) {
      throw PackageRejectedException.uploadRestricted();
    }
    final agent = await requireAuthenticatedClient();
    _logger.info('Finishing async upload (uuid: $uploadGuid)');
    _logger.info('Reading tarball from cloud storage.');

    return await withTempDirectory((Directory dir) async {
      // Check the existence of the uploaded file
      final uploadObjectName = tmpObjectName(uploadGuid);
      final info = await _incomingBucket.tryInfo(uploadObjectName);
      if (info?.length == null) {
        throw PackageRejectedException.archiveEmpty();
      }

      // Create a temporary copy that we will continue working with.
      // This will protect us against the unlikely scenario where the
      // uploaded blob changes during this processing.
      final workGuid = createUuid();
      final workObjectName = '${tmpObjectName(workGuid)}-$uploadGuid';
      try {
        await _storage.copyObjectWithRetry(
          _incomingBucket.absoluteObjectName(uploadObjectName),
          _incomingBucket.absoluteObjectName(workObjectName),
        );
      } catch (e, st) {
        _logger.warning('Failed to copy uploaded file to work object.', e, st);
        throw InvalidInputException(
          'Failed to copy uploaded file (uuid:$uploadGuid).',
        );
      }

      // Check the file size is within limits.
      if (info!.length > UploadSignerService.maxUploadSize) {
        throw PackageRejectedException.archiveTooLarge(
          UploadSignerService.maxUploadSize,
        );
      }

      final filename = '${dir.absolute.path}/tarball.tar.gz';
      await _incomingBucket.readWithRetry(
        workObjectName,
        (input) => _saveTarballToFS(input, filename),
      );
      _logger.info('Examining tarball content ($uploadGuid).');
      final sw = Stopwatch()..start();
      final file = File(filename);
      final fileLength = await file.length();
      if (fileLength != info.length) {
        _logger.warning(
          'Saved file length mismatch ($fileLength != ${info.length}).',
        );
        throw InvalidInputException(
          'Failed to save uploaded file: length mismatch.',
        );
      }
      final md5Hash = (await file.openRead().transform(md5).single).bytes;
      if (!md5Hash.byteToByteEquals(info.md5Hash)) {
        _logger.warning('Saved file md5 mismatch.');
        throw InvalidInputException(
          'Failed to save uploaded file: md5 mismatch.',
        );
      }
      final sha256Hash = (await file.openRead().transform(sha256).single).bytes;
      final archive = await summarizePackageArchive(
        filename,
        maxContentLength: maxAssetContentLength,
        maxArchiveSize: UploadSignerService.maxUploadSize,
        published: clock.now().toUtc(),
      );
      _logger.info('Package archive scanned in ${sw.elapsed}.');
      if (archive.hasIssues) {
        throw PackageRejectedException(archive.issues.first.message);
      }

      final pubspec = Pubspec.fromYaml(archive.pubspecContent!);
      await _verifyPackageName(name: pubspec.name, agent: agent);

      // Check if new packages are allowed to be uploaded.
      if (restriction == UploadRestrictionStatus.onlyUpdates &&
          !(await isPackageVisible(pubspec.name))) {
        throw PackageRejectedException.uploadRestricted();
      }

      // Check version format.
      final versionString = canonicalizeVersion(pubspec.nonCanonicalVersion);
      if (versionString == null) {
        throw InvalidInputException.canonicalizeVersionError(
          pubspec.nonCanonicalVersion,
        );
      }
      // TODO: check this in pkg/pub_package_reader too
      if (versionString != pubspec.nonCanonicalVersion) {
        throw InvalidInputException.nonCanonicalVersion(
          pubspec.nonCanonicalVersion,
          versionString,
        );
      }

      // Check canonical archive.
      final canonicalContentMatch = await tarballStorage
          .matchArchiveContentInCanonical(pubspec.name, versionString, file);
      if (canonicalContentMatch == ContentMatchStatus.different) {
        throw PackageRejectedException.versionExists(
          pubspec.name,
          versionString,
        );
      }

      // check existences of referenced packages
      for (final MapEntry(key: name, :value) in pubspec.dependencies.entries) {
        if (value is! pubspec_parse.HostedDependency) {
          // We disallow git/path dependencies elsewhere, but for the purpose
          // of checking of the dependency exists we can skip them.
          continue;
        }
        if (value.hosted?.url != null) {
          // we disallow hosted dependencies with a URL elsewhere, but for the
          // purpose of checking if the dependency exists, we skip them.
          continue;
        }
        if (isSdkPackage(name)) {
          continue;
        }
        if (nameTracker.hasPackage(name)) {
          continue;
        }
        // Note: When the name tracker has not yet updated its in-memory cache
        //       with recent packages, this check would cause a datastore lookup.
        if (await isPackageVisible(name)) {
          continue;
        }
        throw PackageRejectedException.dependencyDoesNotExists(name);
      }

      sw.reset();
      final entities = await _createUploadEntities(
        db,
        agent,
        archive,
        sha256Hash: sha256Hash,
      );
      final (version, uploadMessages) = await _performTarballUpload(
        entities: entities,
        agent: agent,
        archive: archive,
        objectName: workObjectName,
        hasCanonicalArchiveObject:
            canonicalContentMatch == ContentMatchStatus.same,
      );
      _logger.info('Tarball uploaded in ${sw.elapsed}.');
      _logger.info('Removing temporary object $uploadGuid.');

      sw.reset();
      await _incomingBucket.deleteWithRetry(uploadObjectName);
      await _incomingBucket.deleteWithRetry(workObjectName);
      _logger.info('Temporary object removed in ${sw.elapsed}.');
      return [
        'Successfully uploaded '
            '${urls.pkgPageUrl(version.package, includeHost: true)} '
            'version ${version.version}, '
            'it may take up-to 10 minutes before the new version is available.',
        ...uploadMessages,
      ];
    });
  }

  /// Verify the package name defined in the newly uploaded archive file,
  /// and throw [PackageRejectedException] if it is not accepted.
  /// Some reasons to reject a name:
  /// - it is closely related to another package name,
  /// - it is already being blocked,
  /// - it is reserved for future internal use, but the current user is
  ///   not authorized to claim such package names.
  Future<void> _verifyPackageName({
    required String name,
    required AuthenticatedAgent agent,
  }) async {
    // Apply either the exact-name reserved package lookup, or the closest prefix (ending with '_').
    var reservedPackage = await lookupReservedPackage(name);
    if (reservedPackage == null) {
      // lookup prefixes
      final prefixes = await listReservedPackagePrefixes();
      for (final prefix in prefixes) {
        if (name.startsWith(prefix)) {
          reservedPackage = await lookupReservedPackage(prefix);
          break;
        }
      }
    }

    bool isAllowedUser = false;
    if (agent is AuthenticatedUser) {
      final email = agent.user.email;
      if (email != null) {
        final reservedEmails = reservedPackage?.emails ?? const <String>[];
        isAllowedUser =
            reservedEmails.contains(email) || email.endsWith('@google.com');
      }
    }

    final isReservedName =
        reservedPackage != null || matchesReservedPackageName(name);
    final isExempted = isReservedName && isAllowedUser;

    final conflictingName = await nameTracker.accept(name);
    if (conflictingName != null && !isExempted) {
      final visible = await isPackageVisible(conflictingName);
      if (visible) {
        throw PackageRejectedException.similarToActive(
          name,
          conflictingName,
          urls.pkgPageUrl(conflictingName, includeHost: true),
        );
      } else {
        throw PackageRejectedException.similarToModerated(
          name,
          conflictingName,
        );
      }
    }

    // Apply name verification for new packages.
    final isCurrentlyVisible = await isPackageVisible(name);
    if (!isCurrentlyVisible) {
      final newNameIssues = validateNewPackageName(name).toList();
      if (newNameIssues.isNotEmpty) {
        throw PackageRejectedException(newNameIssues.first.message);
      }

      // reserved package names for the Dart team or allowlisted users
      if (isReservedName && !isAllowedUser) {
        throw PackageRejectedException.nameReserved(name);
      }
    }
  }

  Future<(PackageVersion, List<String>)> _performTarballUpload({
    required _UploadEntities entities,
    required AuthenticatedAgent agent,
    required PackageSummary archive,
    required String objectName,
    required bool hasCanonicalArchiveObject,
  }) async {
    final sw = Stopwatch()..start();
    final uploadMessages = <String>[];
    // messages that are sent in the email but not returned as upload messages to the pub client
    final newVersion = entities.packageVersion;
    final [currentDartSdk, currentFlutterSdk] = await Future.wait([
      getCachedDartSdkVersion(lastKnownStable: toolStableDartSdkVersion),
      getCachedFlutterSdkVersion(lastKnownStable: toolStableFlutterSdkVersion),
    ]);
    final existingPackage = await lookupPackage(newVersion.package);
    final isNew = existingPackage == null;
    // check authorizations before the transaction
    await _requireUploadAuthorization(
      agent,
      existingPackage,
      newVersion.version!,
    );

    // query admin notification emails before the transaction
    List<String> uploaderEmails;
    if (existingPackage == null) {
      if (agent is AuthenticatedUser) {
        uploaderEmails = [agent.email!];
      } else {
        // won't happen as upload authorization check throws earlier
        uploaderEmails = [];
      }
    } else {
      uploaderEmails = await _listAdminNotificationEmailsForPackage(
        existingPackage,
      );
    }
    if (uploaderEmails.isEmpty) {
      // should not happen
      throw AssertionError(
        'Package "${newVersion.package}" has no admin email to notify.',
      );
    }
    // check rate limits before the transaction
    await verifyPackageUploadRateLimit(
      agent: agent,
      package: newVersion.package,
      isNew: isNew,
    );
    Package? package;
    final existingVersions = await db
        .query<PackageVersion>(ancestorKey: newVersion.packageKey!)
        .run()
        .toList();

    final changelogExcerpt = _createChangelogExcerpt(
      versionKey: newVersion.qualifiedVersionKey,
      changelogContent: entities.changelogAsset?.textContent,
    );

    // Add the new package to the repository by storing the tarball and
    // inserting metadata to datastore (which happens atomically).
    final (pv, outgoingEmail) = await withRetryTransaction(db, (tx) async {
      _logger.info('Starting datastore transaction.');

      final tuple = (await tx.lookup([
        newVersion.key,
        newVersion.packageKey!,
        db.emptyKey.append(ModeratedPackage, id: newVersion.package),
      ]));
      final version = tuple[0] as PackageVersion?;
      package = tuple[1] as Package?;
      final moderatedPackage = tuple[2] as ModeratedPackage?;

      if (moderatedPackage != null) {
        throw PackageRejectedException.nameReserved(newVersion.package);
      }

      if (isNew) {
        final reservedPackage = await tx.lookupOrNull<ReservedPackage>(
          db.emptyKey.append(ReservedPackage, id: newVersion.package),
        );
        if (reservedPackage != null) {
          tx.delete(reservedPackage.key);
        }
      }

      // If the version already exists, we fail.
      if (version != null) {
        _logger.info(
          'Version ${version.version} of package '
          '${version.package} already exists, rolling transaction back.',
        );
        throw PackageRejectedException.versionExists(
          version.package,
          version.version!,
        );
      }

      // If the package does not exist, then we create a new package.
      if (package == null) {
        _logger.info('New package uploaded. [new-package-uploaded]');
        package = Package.fromVersion(newVersion);
      }

      final maxVersionCount =
          maxVersionsPerPackageOverrides[package!.name] ??
          maxVersionsPerPackage;
      final remainingVersionCount = maxVersionCount - package!.versionCount;
      if (remainingVersionCount <= 0) {
        throw PackageRejectedException.maxVersionCountReached(
          newVersion.package,
          maxVersionCount,
        );
      }
      if (remainingVersionCount <= 100) {
        // We need to decrease the remaining version count as the newly uploaded
        // version is not yet in it.
        final limitAfterUpload = remainingVersionCount - 1;
        final s = limitAfterUpload == 1 ? '' : 's';
        uploadMessages.add(
          'The package "${package!.name!}" has $limitAfterUpload version$s left '
          'before reaching the limit of $maxVersionCount. '
          'Please contact support@pub.dev',
        );
      }

      if (package!.deletedVersions != null &&
          package!.deletedVersions!.contains(newVersion.version!)) {
        throw PackageRejectedException.versionDeleted(
          package!.name!,
          newVersion.version!,
        );
      }

      // Store the publisher of the package at the time of the upload.
      newVersion.publisherId = package!.publisherId;

      // Keep the latest version in the package object up-to-date.
      package!.updateVersions(
        [...existingVersions, newVersion],
        dartSdkVersion: currentDartSdk.semanticVersion,
        flutterSdkVersion: currentFlutterSdk.semanticVersion,
      );
      package!.updated = clock.now().toUtc();

      // update automated publisher identifiers if this is the first time they have been used
      _updatePackageAutomatedPublishingLock(package!, agent);

      _logger.info(
        'Trying to upload tarball for ${package!.name} version ${newVersion.version} to cloud storage.',
      );
      if (!hasCanonicalArchiveObject) {
        // Copy archive to canonical bucket.
        await tarballStorage.copyFromTempToCanonicalBucket(
          sourceAbsoluteObjectName: _incomingBucket.absoluteObjectName(
            objectName,
          ),
          package: newVersion.package,
          version: newVersion.version!,
        );
      }
      await tarballStorage.copyArchiveFromCanonicalToPublicBucket(
        newVersion.package,
        newVersion.version!,
      );

      final email = createPackageUploadedEmail(
        packageName: newVersion.package,
        packageVersion: newVersion.version!,
        displayId: agent.displayId,
        authorizedUploaders: uploaderEmails
            .map((email) => EmailAddress(email))
            .toList(),
        uploadMessages: uploadMessages,
        changelogExcerpt: changelogExcerpt,
      );
      final outgoingEmail = emailBackend.prepareEntity(email);

      final inserts = <Model>[
        package!,
        newVersion,
        entities.packageVersionInfo,
        ...entities.assets,
        if (activeConfiguration.isPublishedEmailNotificationEnabled)
          outgoingEmail,
        if (isNew)
          AuditLogRecord.packageCreated(
            uploader: agent,
            package: newVersion.package,
            created: newVersion.created!,
            publisherId: package!.publisherId,
          ),
        AuditLogRecord.packagePublished(
          uploader: agent,
          package: newVersion.package,
          version: newVersion.version!,
          created: newVersion.created!,
          publisherId: package!.publisherId,
        ),
      ];

      _logger.info('Trying to commit datastore changes.');
      tx.queueMutations(inserts: inserts);
      return (newVersion, outgoingEmail);
    });
    _logger.info('Upload successful. [package-uploaded]');
    _logger.info('Upload transaction completed in ${sw.elapsed}.');
    sw.reset();

    _logger.info('Invalidating cache for package ${newVersion.package}.');
    triggerPackagePostUpdates(newVersion.package, taskUpdateDependents: true);

    // Let's not block the upload response on these post-upload tasks.
    // The operations should either be non-critical, or should be retried
    // automatically.
    asyncQueue.addAsyncFn(
      () => _postUploadTasks(package, newVersion, outgoingEmail),
    );
    if (isNew && agent is AuthenticatedUser) {
      asyncQueue.addAsyncFn(
        () => cache.userUploaderOfPackages(agent.userId).purge(),
      );
    }

    _logger.info('Post-upload tasks completed in ${sw.elapsed}.');
    return (pv, uploadMessages);
  }

  String? _createChangelogExcerpt({
    required QualifiedVersionKey versionKey,
    required String? changelogContent,
  }) {
    if (changelogContent == null) {
      return null;
    }
    try {
      final parsed = ChangelogParser().parseMarkdownText(changelogContent);
      final version = parsed.releases.firstWhereOrNull(
        (r) => r.version == versionKey.version,
      );
      if (version == null) {
        return null;
      }
      final text = version.content.asMarkdownText;

      /// Limit the changelog to 10 lines, 75 characters each:
      final lines = text.split('\n');
      final excerpt = lines
          // prevent accidental HTML-tag creation
          .map(
            (line) => line
                .replaceAll('<', '[')
                .replaceAll('>', ']')
                .replaceAll('&', ' ')
                .trim(),
          )
          // filter empty or decorative lines to maximalize usefulness
          .where(
            (line) =>
                line.isNotEmpty &&
                line != '-' && // empty list item
                line != '1.' && // empty list item
                !line.startsWith('```') && // also removes the need to escape it
                !line.startsWith('---'),
          )
          .take(10)
          .map(
            (line) => line.length < 76 ? line : '${line.substring(0, 70)}[...]',
          )
          .join('\n');
      return excerpt;
    } catch (e, st) {
      _logger.pubNoticeShout(
        'changelog-parse-error',
        'Unable to parse changelog for $versionKey',
        e,
        st,
      );
      return null;
    }
  }

  /// The post-upload tasks are not critical and could fail without any impact on
  /// the uploaded package version. Important operations (e.g. email sending) are
  /// retried periodically, others (e.g. triggering re-analysis of dependent
  /// packages) are only nice to have.
  Future<void> _postUploadTasks(
    Package? package,
    PackageVersion newVersion,
    OutgoingEmail outgoingEmail,
  ) async {
    try {
      await Future.wait([
        if (activeConfiguration.isPublishedEmailNotificationEnabled)
          emailBackend.trySendOutgoingEmail(outgoingEmail),
        apiExporter.synchronizeAllPackagesAtomFeed(),
        tarballStorage.updateContentDispositionOnPublicBucket(
          newVersion.package,
          newVersion.version!,
        ),
      ]);
    } catch (e, st) {
      final v = newVersion.qualifiedVersionKey;
      _logger.severe('Error post-processing package upload $v', e, st);
    }
  }

  /// Throws a [ResponseException] if [agent] is **not** authorized to upload package.
  ///
  /// If [package] is null, this is an attempt to publish a new package, not a new version to an existing package.
  /// If [package] is not null, this is an attempt to publish [newVersion] of existing package.
  Future<void> _requireUploadAuthorization(
    AuthenticatedAgent agent,
    Package? package,
    String newVersion,
  ) async {
    // new package
    if (package == null) {
      if (agent is AuthenticatedUser) {
        return;
      }
      throw PackageRejectedException.onlyUsersAreAllowedToUploadNewPackages();
    }

    // existing package
    if (package.isNotVisible) {
      throw PackageRejectedException.isBlocked();
    }
    if (agent is AuthenticatedUser &&
        await packageBackend.isPackageAdmin(package, agent.user.userId)) {
      final isEnabled =
          package.publishingConfig?.manualConfig?.isEnabled ?? true;
      if (!isEnabled) {
        throw AuthorizationException.manualPublishingDisabled(package.name!);
      }
      return;
    }
    if (agent is AuthenticatedGitHubAction) {
      await _checkGitHubActionAllowed(agent, package, newVersion);
      return;
    }
    if (agent is AuthenticatedGcpServiceAccount) {
      await _checkServiceAccountAllowed(agent, package, newVersion);
      return;
    }

    _logger.info(
      'User ${agent.agentId} (${agent.displayId}) '
      'is not an uploader for package ${package.name}, rolling transaction back.',
    );
    throw AuthorizationException.userCannotUploadNewVersion(
      agent.displayId,
      package.name!,
    );
  }

  Future<void> _checkGitHubActionAllowed(
    AuthenticatedGitHubAction agent,
    Package package,
    String newVersion,
  ) async {
    final githubConfig = package.publishingConfig?.githubConfig;
    final githubLock = package.publishingConfig?.githubLock;

    if (githubConfig?.isEnabled != true) {
      throw AuthorizationException.githubActionIssue(
        'publishing from github is not enabled',
      );
    }

    // verify that fields are configured
    final repository = githubConfig!.repository;
    if (repository == null || repository.isEmpty) {
      throw AssertionError('Missing or empty repository.');
    }
    final requireEnvironment = githubConfig.requireEnvironment;
    final environment = githubConfig.environment;
    if (requireEnvironment && (environment == null || environment.isEmpty)) {
      throw AssertionError('Missing or empty environment.');
    }

    // Repository must match the action's repository.
    if (repository != agent.payload.repository) {
      throw AuthorizationException.githubActionIssue(
        'publishing is not enabled for the "${agent.payload.repository}" repository, it may be enabled for another repository',
      );
    }

    final eventName = agent.payload.eventName;
    if (eventName == 'push' && !githubConfig.isPushEventEnabled) {
      throw AuthorizationException.githubActionIssue(
        'publishing is not allowed from "push" events',
      );
    }
    if (eventName == 'workflow_dispatch' &&
        !githubConfig.isWorkflowDispatchEventEnabled) {
      throw AuthorizationException.githubActionIssue(
        'publishing is not allowed from "workflow_dispath" events',
      );
    }
    if (eventName != 'push' && eventName != 'workflow_dispatch') {
      throw AuthorizationException.githubActionIssue(
        'publishing is only allowed from "push" or "workflow_dispatch" events, this token originates from a "${agent.payload.eventName}" event',
      );
    }

    if (agent.payload.refType != 'tag') {
      throw AuthorizationException.githubActionIssue(
        'publishing is only allowed from "tag" refType, this token has "${agent.payload.refType}" refType',
      );
    }
    verifyTagPatternWithRef(
      tagPattern: githubConfig.tagPattern ?? '',
      ref: agent.payload.ref,
      newVersion: newVersion,
    );

    // When environment is configured, it must match the action's environment.
    if (requireEnvironment && environment != agent.payload.environment) {
      throw AuthorizationException.githubActionIssue(
        'publishing is configured to only be allowed from actions with an environment, '
        'this token originates from an action running in environment "${agent.payload.environment}" '
        'for which publishing is not allowed',
      );
    }

    if (githubLock != null) {
      final lockMatches =
          githubLock.repositoryId == agent.payload.repositoryId &&
          githubLock.repositoryOwnerId == agent.payload.repositoryOwnerId;
      if (!lockMatches) {
        _logger.info(
          'Disabled automated publishing using GitHub Actions for package:${package.name} because account identifier changed.',
        );
        await withRetryTransaction(db, (tx) async {
          final p = await tx.lookupValue<Package>(package.key);
          p.publishingConfig!.githubConfig!.isEnabled = false;
          tx.insert(p);
        });
        throw AuthorizationException.githubActionIssue(
          'GitHub repository identifiers changed, disabling automated publishing',
        );
      }
    }
  }

  Future<void> _checkServiceAccountAllowed(
    AuthenticatedGcpServiceAccount agent,
    Package package,
    String newVersion,
  ) async {
    final gcpConfig = package.publishingConfig?.gcpConfig;
    final gcpLock = package.publishingConfig?.gcpLock;
    if (gcpConfig?.isEnabled != true) {
      throw AuthorizationException.serviceAccountPublishingIssue(
        'publishing with service account is not enabled',
      );
    }

    // verify that fields are configured
    final serviceAccountEmail = gcpConfig!.serviceAccountEmail;
    if (serviceAccountEmail == null || serviceAccountEmail.isEmpty) {
      throw AssertionError('Missing or empty serviceAccountEmail.');
    }

    // the service account email must be set and matching the agent's email.
    if (serviceAccountEmail != agent.payload.email) {
      throw AuthorizationException.serviceAccountPublishingIssue(
        'publishing is not enabled for the "${agent.payload.email}" service account',
      );
    }

    if (gcpLock != null) {
      final lockMatches = gcpLock.oauthUserId == agent.payload.sub;
      if (!lockMatches) {
        _logger.info(
          'Disabled automated publishing using GCP service account for package:${package.name} because account identifier changed.',
        );
        await withRetryTransaction(db, (tx) async {
          final p = await tx.lookupValue<Package>(package.key);
          p.publishingConfig!.gcpConfig!.isEnabled = false;
          tx.insert(p);
        });
        throw AuthorizationException.githubActionIssue(
          'Google Cloud Service account identifiers changed, disabling automated publishing',
        );
      }
    }
  }

  /// List the admin emails that need to be notified when a [package] has a
  /// significant event (e.g. new version is uploaded).
  ///
  /// - Returns either the uploader emails of the publisher's admin member emails.
  ///   Throws exception if the list is empty, we should be able to notify somebody.
  Future<List<String>> _listAdminNotificationEmailsForPackage(
    Package package,
  ) async {
    final emails = package.publisherId == null
        ? await accountBackend.getEmailsOfUserIds(package.uploaders!)
        : await publisherBackend.getAdminMemberEmails(package.publisherId!);
    final existingEmails = emails.nonNulls.toList();
    if (existingEmails.isEmpty) {
      // should not happen
      throw AssertionError(
        'Package "${package.name}" has no admin email to notify.',
      );
    }
    return existingEmails;
  }

  // Uploaders support.

  Future<account_api.InviteStatus> inviteUploader(
    String packageName,
    api.InviteUploaderRequest invite,
  ) async {
    InvalidInputException.checkNotNull(invite.email, 'email');
    final uploaderEmail = invite.email.toLowerCase();
    final authenticatedUser = await requireAuthenticatedWebUser();
    final user = authenticatedUser.user;
    final packageKey = db.emptyKey.append(Package, id: packageName);
    final package = await db.lookupOrNull<Package>(packageKey);

    await _validatePackageUploader(packageName, package, user.userId);
    // Don't send invites for publisher-owned packages.
    if (package!.publisherId != null) {
      throw OperationForbiddenException.publisherOwnedPackageNoUploader(
        packageName,
        package.publisherId!,
      );
    }

    InvalidInputException.check(
      isValidEmail(uploaderEmail),
      'Not a valid email: `$uploaderEmail`.',
    );

    final uploaderUsers = await accountBackend.lookupUsersById(
      package.uploaders!,
    );
    final isNotUploaderYet = !uploaderUsers.any(
      (u) => u!.email == uploaderEmail,
    );
    InvalidInputException.check(
      isNotUploaderYet,
      '`$uploaderEmail` is already an uploader.',
    );

    final status = await consentBackend.invitePackageUploader(
      agent: authenticatedUser,
      packageName: packageName,
      uploaderEmail: uploaderEmail,
    );

    return account_api.InviteStatus(
      emailSent: status.emailSent,
      nextNotification: status.nextNotification,
    );
  }

  Future<void> confirmUploader(
    String packageName,
    User uploader, {
    required String consentRequestFromAgent,
  }) async {
    final uploaderUserId = await withRetryTransaction(db, (tx) async {
      final packageKey = db.emptyKey.append(Package, id: packageName);
      final package = (await tx.lookup([packageKey])).first as Package;

      if (consentRequestFromAgent != KnownAgents.pubSupport) {
        await _validatePackageUploader(
          packageName,
          package,
          consentRequestFromAgent,
        );
      }
      if (package.containsUploader(uploader.userId)) {
        // The requested uploaderEmail is already part of the uploaders.
        return uploader.userId;
      }

      // Add [uploaderEmail] to uploaders and commit.
      package.addUploader(uploader.userId);
      package.updated = clock.now().toUtc();

      tx.insert(package);
      tx.insert(
        await AuditLogRecord.uploaderInviteAccepted(
          user: uploader,
          package: packageName,
        ),
      );
      return uploader.userId;
    });
    await purgeAccountCache(userId: uploaderUserId);
    triggerPackagePostUpdates(
      packageName,
      skipReanalysis: true,
      skipExport: true,
    );
  }

  Future<void> _validatePackageUploader(
    String packageName,
    Package? package,
    String userId,
  ) async {
    // Fail if package doesn't exist.
    if (package == null) {
      throw NotFoundException.resource(packageName);
    }

    // Fail if calling user doesn't have permission to change uploaders.
    if (!await packageBackend.isPackageAdmin(package, userId)) {
      throw AuthorizationException.userCannotChangeUploaders(package.name!);
    }
  }

  Future<api.SuccessMessage> removeUploader(
    String packageName,
    String uploaderEmail,
  ) async {
    uploaderEmail = uploaderEmail.toLowerCase();
    final authenticatedUser = await requireAuthenticatedWebUser();
    final user = authenticatedUser.user;
    final uploaderUserId = await withRetryTransaction(db, (tx) async {
      final packageKey = db.emptyKey.append(Package, id: packageName);
      final package = await tx.lookupOrNull<Package>(packageKey);
      if (package == null) {
        throw NotFoundException.resource('package: $packageName');
      }

      await _validatePackageUploader(packageName, package, user.userId);

      // Fail if the uploader we want to remove does not exist.
      final uploaderUsers = await accountBackend.lookupUsersById(
        package.uploaders!,
      );
      final uploadersWithEmail = <User>[];
      for (final u in uploaderUsers) {
        final email = await accountBackend.getEmailOfUserId(u!.userId);
        if (email == uploaderEmail) uploadersWithEmail.add(u);
      }
      if (uploadersWithEmail.isEmpty) {
        throw NotFoundException.resource('uploader: $uploaderEmail');
      }
      if (uploadersWithEmail.length > 1) {
        throw NotAcceptableException(
          'Multiple uploaders with email: $uploaderEmail',
        );
      }
      final uploader = uploadersWithEmail.single;

      // We cannot have 0 uploaders, if we would remove the last one, we
      // fail with an error.
      if (package.uploaderCount <= 1) {
        throw OperationForbiddenException.lastUploaderRemoveError();
      }

      // At the moment we don't validate whether the other email addresses
      // are able to authenticate. To prevent accidentally losing the control
      // of a package, we don't allow self-removal.
      if (user.email == uploader.email || user.userId == uploader.userId) {
        throw OperationForbiddenException.selfRemovalNotAllowed();
      }

      // Remove the uploader from the list.
      package.removeUploader(uploader.userId);
      package.updated = clock.now().toUtc();

      tx.insert(package);
      tx.insert(
        await AuditLogRecord.uploaderRemoved(
          agent: authenticatedUser,
          package: packageName,
          uploaderUser: uploader,
        ),
      );
      return uploader.userId;
    });
    await purgeAccountCache(userId: uploaderUserId);
    triggerPackagePostUpdates(
      packageName,
      skipReanalysis: true,
      skipExport: true,
    );
    return api.SuccessMessage(
      success: api.Message(
        message:
            '$uploaderEmail has been removed as an uploader for this package.',
      ),
    );
  }

  Future<UploadRestrictionStatus> getUploadRestrictionStatus() async {
    final value =
        await secretBackend.lookup(
          SecretKey.uploadRestriction,
          maxAge: Duration(minutes: 5),
        ) ??
        '';
    switch (value) {
      case 'no-uploads':
        return UploadRestrictionStatus.noUploads;
      case 'only-updates':
        return UploadRestrictionStatus.onlyUpdates;
      case '':
      case '-':
      case 'no-restriction':
        return UploadRestrictionStatus.noRestriction;
    }
    // safe fallback on enabling uploads
    _logger.warning('Unknown upload restriction status: $value');
    return UploadRestrictionStatus.noRestriction;
  }

  /// Deletes the tarball of a [package] in the given [version] permanently.
  Future<void> removePackageTarball(String package, String version) async {
    await tarballStorage.deleteArchiveFromAllBuckets(package, version);
  }

  void _updatePackageAutomatedPublishingLock(
    Package package,
    AuthenticatedAgent agent,
  ) {
    final current = package.publishingConfig;
    if (current == null) {
      if (agent is AuthenticatedGitHubAction ||
          agent is AuthenticatedGcpServiceAccount) {
        // This should be unreachable
        throw AssertionError('Authentication should never have been possible');
      }
      return;
    }
    if (agent is AuthenticatedGitHubAction && current.githubLock == null) {
      current.githubLock = GitHubPublishingLock(
        repositoryOwnerId: agent.payload.repositoryOwnerId,
        repositoryId: agent.payload.repositoryId,
      );
    } else if (agent is AuthenticatedGcpServiceAccount &&
        current.gcpLock == null) {
      current.gcpLock = GcpPublishingLock(oauthUserId: agent.payload.sub);
    }
  }
}

extension PackageVersionExt on PackageVersion {
  api.VersionInfo toApiVersionInfo() {
    final hasSha256 = this.sha256 != null && this.sha256!.isNotEmpty;
    final archiveSha256 = hasSha256 ? hex.encode(this.sha256!) : null;
    return api.VersionInfo(
      version: version!,
      retracted: isRetracted ? true : null,
      pubspec: pubspec!.asJson,
      archiveUrl: urls.pkgArchiveDownloadUrl(
        package,
        version!,

        /// We should use the primary API URI here, because the generated URLs may
        /// end up in multiple cache, and it is critical that we always serve the
        /// content with the proper cached URLs.
        baseUri: activeConfiguration.primaryApiUri,
      ),
      archiveSha256: archiveSha256,
      published: created,
    );
  }
}

enum UploadRestrictionStatus {
  /// Publication of new packages and new versions of existing packages is allowed.
  noRestriction,

  /// Publication of new packages is **not** allowed, new versions of existing packages is allowed.
  onlyUpdates,

  /// Publication of packages is **not** allowed.
  noUploads,
}

/// Loads [package], returns its [Package] instance, and also checks if
/// [userId] is an admin of the package.
///
/// Throws [AuthorizationException] if the user is not an admin for the package.
Future<Package> _requirePackageAdmin(String package, String userId) async {
  final p = await packageBackend.lookupPackage(package);
  if (p == null) {
    throw NotFoundException.resource('package "$package"');
  }
  if (!await packageBackend.isPackageAdmin(p, userId)) {
    throw AuthorizationException.userIsNotAdminForPackage(package);
  }
  return p;
}

api.PackagePublisherInfo _asPackagePublisherInfo(Package p) =>
    api.PackagePublisherInfo(publisherId: p.publisherId);

/// Purge [cache] entries for given [package] and also global page caches.
Future<void> purgePackageCache(String package) async {
  await Future.wait([
    cache.packageVisible(package).purge(),
    cache.packageData(package).purge(),
    cache.packageDataGz(package).purge(),
    cache.packageLatestVersion(package).purge(),
    cache.packageView(package).purge(),
    cache.packageAtomFeedXml(package).purge(),
    cache.uiPackagePage(package, null).purge(),
    cache.uiPackageChangelog(package, null).purge(),
    cache.uiPackageExample(package, null).purge(),
    cache.uiPackageInstall(package, null).purge(),
    cache.uiPackageScore(package, null).purge(),
    cache.uiPackageVersions(package).purge(),
    cache.uiLandingPageContent().purge(),
    cache.allPackagesAtomFeedXml().purge(),
  ]);
}

/// Verifies the [tagPattern] before storing it on the automated publishing
/// settings object.
@visibleForTesting
void verifyTagPattern({required String tagPattern}) {
  final tagPatternParts = tagPattern.split('{{version}}');
  InvalidInputException.check(
    tagPatternParts.length == 2,
    'The `tagPattern` field must contain a single `{{version}}` part.',
  );
  InvalidInputException.check(
    tagPatternParts
        .where((e) => e.isNotEmpty)
        .every(_validGitHubVersionPattern.hasMatch),
    'The `tagPattern` field has invalid characters.',
  );
}

/// Verifies the user-settings [tagPattern] with the authentication-provided
/// [ref] value, and throws if the ref is not allowed or not recognized as
/// valid pattern.
@visibleForTesting
void verifyTagPatternWithRef({
  required String tagPattern,
  required String ref,
  required String newVersion,
}) {
  if (!tagPattern.contains('{{version}}')) {
    throw AssertionError(
      'Configured tag pattern does not include `{{version}}`',
    );
  }
  // NOTE: The `/` character is allowed inside the tag pattern because we are
  //       not splitting the `refs/tags/` prefix. A change of this parsing
  //       should specifically test the presence of `/`.
  final expectedRefStart = 'refs/tags/';
  if (!ref.startsWith(expectedRefStart)) {
    throw AuthorizationException.githubActionIssue(
      'publishing is only allowed from "refs/tags/*" ref, this token has "$ref" ref',
    );
  }
  final expectedTagValue = tagPattern.replaceFirst('{{version}}', newVersion);
  if (ref != 'refs/tags/$expectedTagValue') {
    // At this point we have concluded that the agent has push rights to the repository,
    // however, the tag pattern they have used is not the one we expect.
    //
    // By revealing the expected tag pattern, we are serving the users with better
    // error message, while not exposing much information to an assumed attacker.
    // With the current access level, an attacker would have access to past tags, and
    // figuring out the tag pattern from those should be straightforward anyway.
    throw AuthorizationException.githubActionIssue(
      'publishing is configured to only be allowed from actions with specific ref pattern, '
      'this token has "$ref" ref for which publishing is not allowed. '
      'Expected tag "$expectedTagValue". Check that the version in the tag matches the version in "pubspec.yaml"',
    );
  }
}

/// The status of an invite after being created or updated.
class InviteStatus {
  final String? urlNonce;
  final DateTime? nextNotification;

  InviteStatus({this.urlNonce, this.nextNotification});

  bool get isActive => urlNonce != null;

  bool get isDelayed => nextNotification != null;
}

/// Reads a tarball from a byte stream.
///
/// Completes with an error if the incoming stream has an error or if the size
/// exceeds [UploadSignerService.maxUploadSize].
Future _saveTarballToFS(Stream<List<int>> data, String filename) async {
  final sw = Stopwatch()..start();
  final targetFile = File(filename);

  // cleanup the leftover if previous attempt failed
  if (await targetFile.exists()) {
    await targetFile.delete();
  }
  late IOSink sink;
  try {
    sink = targetFile.openWrite();
    int receivedBytes = 0;
    await for (final chunk in data) {
      receivedBytes += chunk.length;
      if (receivedBytes <= UploadSignerService.maxUploadSize) {
        sink.add(chunk);
      } else {
        await sink.close();
        throw PackageRejectedException.archiveTooLarge(
          UploadSignerService.maxUploadSize,
        );
      }
    }
    await sink.flush();
  } catch (e, st) {
    _logger.warning('An error occurred while streaming tarball to FS.', e, st);
    rethrow;
  } finally {
    await sink.close();
  }
  _logger.info('Finished streaming tarball to FS (elapsed: ${sw.elapsed}).');
}

class _UploadEntities {
  final PackageVersion packageVersion;
  final PackageVersionInfo packageVersionInfo;
  final List<PackageVersionAsset> assets;

  _UploadEntities(this.packageVersion, this.packageVersionInfo, this.assets);

  late final changelogAsset = assets.firstWhereOrNull(
    (e) => e.kind == AssetKind.changelog,
  );
}

class DerivedPackageVersionEntities {
  final PackageVersionInfo packageVersionInfo;
  final List<PackageVersionAsset> assets;

  DerivedPackageVersionEntities(this.packageVersionInfo, this.assets);
}

/// Creates entities from [archive] summary.
Future<_UploadEntities> _createUploadEntities(
  DatastoreDB db,
  AuthenticatedAgent agent,
  PackageSummary archive, {
  required List<int> sha256Hash,
}) async {
  final pubspec = Pubspec.fromYaml(archive.pubspecContent!);
  final packageKey = db.emptyKey.append(Package, id: pubspec.name);
  final versionString = canonicalizeVersion(pubspec.nonCanonicalVersion);

  final version = PackageVersion.init()
    ..id = versionString
    ..parentKey = packageKey
    ..version = versionString
    ..packageKey = packageKey
    ..created = clock.now().toUtc()
    ..pubspec = pubspec
    ..libraries = archive.libraries
    ..uploader = agent.agentId
    ..sha256 = sha256Hash;

  final derived = derivePackageVersionEntities(
    archive: archive,
    versionCreated: version.created!,
  );

  // TODO: verify if assets sizes are within the transaction limit (10 MB)
  return _UploadEntities(version, derived.packageVersionInfo, derived.assets);
}

/// Creates new Datastore entities from the actual extraction of package [archive].
DerivedPackageVersionEntities derivePackageVersionEntities({
  required PackageSummary archive,
  required DateTime versionCreated,
}) {
  final pubspec = Pubspec.fromYaml(archive.pubspecContent!);
  final key = QualifiedVersionKey(
    package: pubspec.name,
    version: pubspec.canonicalVersion,
  );

  String? capContent(String? text) {
    if (text == null) return text;
    if (text.length < maxAssetContentLength) return text;
    return text.substring(0, maxAssetContentLength);
  }

  final assets = <PackageVersionAsset>[
    PackageVersionAsset.init(
      package: key.package,
      version: key.version,
      kind: AssetKind.pubspec,
      versionCreated: versionCreated,
      path: 'pubspec.yaml',
      textContent: capContent(archive.pubspecContent),
    ),
    if (archive.readmePath != null)
      PackageVersionAsset.init(
        package: key.package,
        version: key.version,
        kind: AssetKind.readme,
        versionCreated: versionCreated,
        path: archive.readmePath,
        textContent: capContent(archive.readmeContent),
      ),
    if (archive.changelogPath != null)
      PackageVersionAsset.init(
        package: key.package,
        version: key.version,
        kind: AssetKind.changelog,
        versionCreated: versionCreated,
        path: archive.changelogPath,
        textContent: capContent(archive.changelogContent),
      ),
    if (archive.examplePath != null)
      PackageVersionAsset.init(
        package: key.package,
        version: key.version,
        kind: AssetKind.example,
        versionCreated: versionCreated,
        path: archive.examplePath,
        textContent: capContent(archive.exampleContent),
      ),
    if (archive.licensePath != null)
      PackageVersionAsset.init(
        package: key.package,
        version: key.version,
        kind: AssetKind.license,
        versionCreated: versionCreated,
        path: archive.licensePath,
        textContent: capContent(archive.licenseContent),
      ),
  ];

  final versionInfo = PackageVersionInfo()
    ..initFromKey(key)
    ..versionCreated = versionCreated
    ..updated = clock.now().toUtc()
    ..libraries = archive.libraries
    ..libraryCount = archive.libraries!.length
    ..assets = assets.map((a) => a.kind!).toList()
    ..assetCount = assets.length;

  return DerivedPackageVersionEntities(versionInfo, assets);
}

/// The GCS object name of an temporary object [guid] - excluding leading '/'.
@visibleForTesting
String tmpObjectName(String guid) => 'tmp/$guid';

/// Verify that the [package] and the optional [version] parameter looks as acceptable input.
void checkPackageVersionParams(String package, [String? version]) {
  InvalidInputException.checkPackageName(package);
  if (version != null) {
    InvalidInputException.check(version.trim() == version, 'Invalid version.');
    InvalidInputException.checkStringLength(
      version,
      'version',
      minimum: 1,
      maximum: maxPackageVersionLength,
    );
    if (version != 'latest') {
      InvalidInputException.checkSemanticVersion(version);
    }
  }
}

/// Low-level, narrowly typed data access methods for [Package] entity.
extension PackageDatastoreDBExt on DatastoreDB {
  _PackageDataAccess get packages => _PackageDataAccess(this);
}

extension PackageTransactionWrapperExt on TransactionWrapper {
  _PackageTransactionDataAcccess get packages =>
      _PackageTransactionDataAcccess(this);

  _VersionTransactionDataAcccess get versions =>
      _VersionTransactionDataAcccess(this);
}

final class _PackageDataAccess {
  final DatastoreDB _db;

  _PackageDataAccess(this._db);

  Future<bool> exists(String name) async {
    final packageKey = _db.emptyKey.append(Package, id: name);
    final package = await _db.lookupOrNull<Package>(packageKey);
    return package != null;
  }

  Stream<({String name})> listAllNames() async* {
    final query = _db.query<Package>();
    await for (final p in query.run()) {
      yield (name: p.name!);
    }
  }

  Stream<({String name, DateTime updated})> listUpdatedSince(
    DateTime since,
  ) async* {
    final query = _db.query<Package>()
      ..filter('updated >', since)
      ..order('-updated');
    await for (final p in query.run()) {
      yield (name: p.name!, updated: p.updated!);
    }
  }
}

class _PackageTransactionDataAcccess {
  final TransactionWrapper _tx;

  _PackageTransactionDataAcccess(this._tx);

  Future<Package?> lookupOrNull(String name) async {
    final pkgKey = _tx.emptyKey.append(Package, id: name);
    return await _tx.lookupOrNull<Package>(pkgKey);
  }
}

class _VersionTransactionDataAcccess {
  final TransactionWrapper _tx;

  _VersionTransactionDataAcccess(this._tx);

  Future<List<PackageVersion>> listVersionsOfPackage(String name) async {
    final pkgKey = _tx.emptyKey.append(Package, id: name);
    return await _tx.query<PackageVersion>(pkgKey).run().toList();
  }
}

/// Triggers post-update event processing after a [Package] object is part of
/// a transaction.
///
/// Returns a record with an optionally awaitable [Future] in case the caller needs to
/// wait for the updates before yielding its response.
({Future future}) triggerPackagePostUpdates(
  String package, {

  /// Skip trigger a new analysis on the package.
  bool skipReanalysis = false,

  /// Skip triggering a new export to the CDN bucket.
  bool skipExport = false,

  /// Skip only the archive-related exports to the CDN bucket.
  bool skipArchiveExport = false,

  /// Pass the force-deletion flag to the package export operation.
  bool exportForceDelete = false,

  /// Pass the update-dependents flag to the task update operation.
  bool taskUpdateDependents = false,
}) {
  Future add(Future Function() fn) {
    return asyncQueue.addAsyncFn(fn).future;
  }

  final futures = [
    add(() => purgePackageCache(package)),
    if (!skipReanalysis)
      add(
        () => taskBackend.trackPackage(
          package,
          updateDependents: taskUpdateDependents,
          refreshVersionsCache: true,
        ),
      ),
    if (!skipExport)
      add(
        () => apiExporter.synchronizePackage(
          package,
          forceDelete: exportForceDelete,
          skipArchives: skipArchiveExport,
        ),
      ),
  ];

  return (future: Future.wait(futures));
}
