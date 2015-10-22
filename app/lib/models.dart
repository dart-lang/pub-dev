// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.appengine_repository.models;

import 'dart:math';

import 'package:gcloud/db.dart' as db;
import 'package:intl/intl.dart';
import 'package:pub_semver/pub_semver.dart';

import 'model_properties.dart';

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

  @CompatibleStringListProperty()
  List<String> uploaderEmails;

  String get latestVersion => latestVersionKey.id;

  Version get latestSemanticVersion => new Version.parse(latestVersionKey.id);

  // Check if a user is an uploader for a package.
  bool hasUploader(String email) {
    return uploaderEmails.map((s) => s.toLowerCase())
                         .contains(email.toLowerCase());

  }

  // Remove the email from the list of uploaders.
  void removeUploader(String email) {
    var lowerEmail = email.toLowerCase();
    uploaderEmails =
        uploaderEmails.map((s) => s.toLowerCase())
                      .where((email) => email != lowerEmail).toList();

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
  String version;  // Same as id

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
    if (readmeFilename != null)
      return new FileObject(readmeFilename, readmeContent);
    return null;
  }

  @db.StringProperty(indexed: false)
  String changelogFilename;

  @db.StringProperty(indexed: false)
  String changelogContent;

  FileObject get changelog {
    if (changelogFilename != null)
      return new FileObject(changelogFilename, changelogContent);
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

  // Convenience Fields:

  Version get semanticVersion => new Version.parse(version);

  String get ellipsizedDescription {
    String description = pubspec.description;
    if (description == null) return null;
    return description.substring(0, min(description.length, 200));
  }

  String get shortCreated {
    return ShortDateFormat.format(created);
  }

  String get dartdocsUrl {
    var name = Uri.encodeComponent(packageKey.id);
    var version = Uri.encodeComponent(id);
    return 'http://www.dartdocs.org/documentation/$name/$version/';
  }

  String get documentation {
    // TODO: Look first into pubspecYaml['documentation'] otherwise do this:
    return dartdocsUrl;
  }

  String get documentationNice => niceUrl(documentation);


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
