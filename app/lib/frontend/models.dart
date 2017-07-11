// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.appengine_repository.models;

import 'dart:math';

import 'package:gcloud/db.dart' as db;
import 'package:intl/intl.dart';
import 'package:pub_semver/pub_semver.dart';

import '../shared/model_properties.dart';
import '../shared/utils.dart';

import 'model_properties.dart';

export 'model_properties.dart' show FileObject;

final DateFormat ShortDateFormat = new DateFormat.yMMMd();

/// Pub package metdata.
///
/// The main property used is `uploaderEmails` for determining who is allowed
/// to upload packages.
// TODO:
// The uploaders are saved as User objects in the python datastore. We don't
// have db Models for users, but the lowlevel datastore API will store them
// as expanded properties of type `Entity`.
// We should move ExpandoModel -> Model once we have highlevel db.User objects.
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

  @CompatibleStringListProperty()
  List<String> uploaderEmails;

  // Fields that contain the properties of the latest stable version

  @CompatibleStringListProperty()
  List<String> detectedTypes;

  // Convenience Fields:

  String get latestVersion => latestVersionKey.id;

  Version get latestSemanticVersion => new Version.parse(latestVersionKey.id);

  String get latestDevVersion => latestDevVersionKey?.id;

  Version get latestDevSemanticVersion =>
      latestDevVersionKey == null ? null : new Version.parse(latestDevVersion);

  // Check if a user is an uploader for a package.
  bool hasUploader(String email) {
    return uploaderEmails
        .map((s) => s.toLowerCase())
        .contains(email.toLowerCase());
  }

  // Remove the email from the list of uploaders.
  void removeUploader(String email) {
    final lowerEmail = email.toLowerCase();
    uploaderEmails = uploaderEmails
        .map((s) => s.toLowerCase())
        .where((email) => email != lowerEmail)
        .toList();
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

  /// Updates the search-related fields (eg. [detectedTypes]) to match the
  /// latest stable [PackageVersion].
  ///
  /// Returns whether any field has been updated.
  bool updateSearchFields(PackageVersion pv) {
    if (latestVersion == pv.version) {
      if (!isSameDetectedType(detectedTypes, pv.detectedTypes)) {
        detectedTypes = pv.detectedTypes;
        return true;
      }
    }
    if (detectedTypes == null) {
      detectedTypes = [];
      return true;
    }
    return false;
  }
}

/// Pub package metadata for a specific uploaded version.
///
/// Metadata such as changelog/readme/libraries are used for rendering HTML
/// pages.
// The uploaders are saved as User objects in the python datastore. We don't
// have db Models for users, but the lowlevel datastore API will store them
// as expanded properties of type `Entity`.
// We should move ExpandoModel -> Model once we have highlevel db.User objects.
@db.Kind(name: 'PackageVersion', idType: db.IdType.String)
class PackageVersion extends db.ExpandoModel {
  @db.StringProperty(required: true)
  String version; // Same as id

  String get package => packageKey.id;

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
      return new FileObject(readmeFilename, readmeContent);
    }
    return null;
  }

  @db.StringProperty(indexed: false)
  String changelogFilename;

  @db.StringProperty(indexed: false)
  String changelogContent;

  FileObject get changelog {
    if (changelogFilename != null) {
      return new FileObject(changelogFilename, changelogContent);
    }
    return null;
  }

  @db.StringProperty(indexed: false)
  String exampleFilename;

  @db.StringProperty(indexed: false)
  String exampleContent;

  FileObject get example {
    if (exampleFilename != null) {
      return new FileObject(exampleFilename, exampleContent);
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
  String uploaderEmail;

  @CompatibleStringListProperty()
  List<String> detectedTypes;

  // Convenience Fields:

  Version get semanticVersion => new Version.parse(version);

  String get ellipsizedDescription {
    final String description = pubspec.description;
    if (description == null) return null;
    return description.substring(0, min(description.length, 200));
  }

  String get shortCreated {
    return ShortDateFormat.format(created);
  }

  String get dartdocsUrl {
    final name = Uri.encodeComponent(packageKey.id);
    final version = Uri.encodeComponent(id);
    return 'http://www.dartdocs.org/documentation/$name/$version/';
  }

  String get documentation {
    // TODO: Look first into pubspecYaml['documentation'] otherwise do this:
    return dartdocsUrl;
  }

  String get documentationNice => niceUrl(documentation);

  String get crossdart {
    final name = Uri.encodeComponent(packageKey.id);
    final version = Uri.encodeComponent(id);
    return 'https://www.crossdart.info/p/$name/$version/';
  }

  String get crossdartNice => niceUrl(crossdart);

  String get homepage {
    return pubspec.homepage;
  }

  String get homepageNice => niceUrl(homepage);
}

@db.Kind(name: 'PrivateKey', idType: db.IdType.String)
class PrivateKey extends db.Model {
  @db.StringProperty(required: true)
  String value;
}

/// Removes the scheme part from `url`. (i.e. http://a/b becomes a/b).
String niceUrl(String url) {
  if (url == null) {
    return url;
  } else if (url.startsWith('https://')) {
    return url.substring('https://'.length);
  } else if (url.startsWith('http://')) {
    return url.substring('http://'.length);
  }
  return url;
}

/// Sorts [versions] according to the semantic versioning specification.
///
/// If [pubSorting] is `true` then pub's priorization ordering is used, which
/// will rank pre-release versions lower than stable versions (e.g. it will
/// order "0.9.0-dev.1 < 0.8.0").  Otherwise it will use semantic version
/// sorting (e.g. it will order "0.8.0 < 0.9.0-dev.1").
void sortPackageVersionsDesc(List<PackageVersion> versions,
    {bool decreasing: true, bool pubSorting: true}) {
  versions.sort((PackageVersion a, PackageVersion b) =>
      compareSemanticVersionsDesc(
          a.semanticVersion, b.semanticVersion, decreasing, pubSorting));
}

/// The list of built-in types.
/// TODO: rename to DetectedTypes
/// TODO: move isSameDetectedType method inside
class BuiltinTypes {
  /// Package is related to angular.
  static final String angular = 'angular';

  /// Package is related to Flutter: is a plugin, or depends on the Flutter SDK.
  static final String flutterPackage = 'flutter_package';

  /// Package is related to Flutter and it is a plugin.
  static final String flutterPlugin = 'flutter_plugin';

  static final Set<String> _used = new Set.from([
    BuiltinTypes.flutterPackage,
    BuiltinTypes.flutterPlugin,
  ]);

  /// Verifies that the client-provided [type] is a known type.
  static bool isKnownType(String type) => _used.contains(type);
}

/// Returns true if the two list of detected types are the same.
bool isSameDetectedType(List<String> a, List<String> b) {
  final int lengthA = a?.length ?? 0;
  final int lengthB = b?.length ?? 0;
  if (lengthA != lengthB) return false;
  if (lengthA == 0) return true;
  return (a.toSet()..removeAll(b)).isEmpty;
}
