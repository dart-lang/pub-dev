// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yaml/yaml.dart' as yaml;

part 'models.g.dart';

/// The configuration to use when creating a local database for testing and
/// development, containing a partial mirror of pub.dev and also synthetic
/// generated package contents.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TestProfile {
  /// Packages that will be imported from pub.dev.
  ///
  /// The archive of the package will be used without modification.
  /// The package options may be updated as provided by the [TestPackage].
  final List<TestPackage> importedPackages;

  /// Packages that will be generated locally using the provided parameters and semi-random templates.
  final List<TestPackage> generatedPackages;
  final List<TestPublisher> publishers;
  final List<TestUser> users;

  /// The email address of the default user.
  final String? defaultUser;

  TestProfile({
    List<TestPackage>? importedPackages,
    List<TestPackage>? generatedPackages,
    List<TestPublisher>? publishers,
    List<TestUser>? users,
    this.defaultUser,
  })  : importedPackages = importedPackages ?? <TestPackage>[],
        generatedPackages = generatedPackages ?? <TestPackage>[],
        publishers = publishers ?? <TestPublisher>[],
        users = users ?? <TestUser>[];

  factory TestProfile.fromJson(Map<String, dynamic> json) =>
      _$TestProfileFromJson(json);

  factory TestProfile.fromYaml(String source) {
    final map = json.decode(json.encode(yaml.loadYaml(source)));
    return TestProfile.fromJson(map as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => _$TestProfileToJson(this);

  TestProfile changeDefaultUser(String email) {
    return TestProfile(
      importedPackages: importedPackages,
      generatedPackages: generatedPackages,
      publishers: publishers,
      users: users,
      defaultUser: email,
    );
  }

  /// The [defaultUser] if specified, otherwise:
  /// - the first entry in the [users] list,
  /// - the first specified member in the [publishers] list,
  /// - the first specfied uploader in the [importedPackages] or the [generatedPackages] list.
  late final resolvedDefaultUser = defaultUser ??
      users.firstOrNull?.email ??
      publishers.expand((p) => p.members).map((m) => m.email).firstOrNull ??
      importedPackages.expand((p) => p.uploaders ?? <String>[]).firstOrNull ??
      generatedPackages.expand((p) => p.uploaders ?? <String>[]).first;
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TestPackage {
  final String name;
  final List<String>? uploaders;
  final String? publisher;
  final List<TestVersion>? versions;
  final bool? isDiscontinued;
  final String? replacedBy;
  final bool? isUnlisted;
  final bool? isFlutterFavorite;
  final List<String>? retractedVersions;
  final int? likeCount;

  TestPackage({
    required this.name,
    this.uploaders,
    this.publisher,
    this.versions,
    this.isDiscontinued,
    this.replacedBy,
    this.isUnlisted,
    this.isFlutterFavorite,
    this.retractedVersions,
    this.likeCount,
  });

  factory TestPackage.fromJson(Map<String, dynamic> json) {
    // convert simple String versions to objects
    final versions = json['versions'] as List?;
    json = {
      ...json,
      'versions':
          versions?.map((v) => v is String ? {'version': v} : v).toList(),
    };
    return _$TestPackageFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TestPackageToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TestVersion {
  final String version;
  final DateTime? created;

  TestVersion({
    required this.version,
    this.created,
  });

  factory TestVersion.fromJson(Map<String, dynamic> json) =>
      _$TestVersionFromJson(json);

  Map<String, dynamic> toJson() => _$TestVersionToJson(this);

  @override
  String toString() => '$version';
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TestPublisher {
  final String name;
  final List<TestMember> members;

  TestPublisher({
    required this.name,
    required List<TestMember>? members,
  }) : members = members ?? <TestMember>[];

  factory TestPublisher.fromJson(Map<String, dynamic> json) =>
      _$TestPublisherFromJson(json);

  Map<String, dynamic> toJson() => _$TestPublisherToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TestMember {
  final String email;
  final String role;

  TestMember({
    required this.email,
    required this.role,
  });

  factory TestMember.fromJson(Map<String, dynamic> json) =>
      _$TestMemberFromJson(json);

  Map<String, dynamic> toJson() => _$TestMemberToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TestUser {
  final String email;

  /// The list of package names that the user liked.
  final List<String> likes;

  TestUser({
    required this.email,
    required List<String>? likes,
  }) : likes = likes ?? <String>[];

  factory TestUser.fromJson(Map<String, dynamic> json) =>
      _$TestUserFromJson(json);

  Map<String, dynamic> toJson() => _$TestUserToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ResolvedVersion implements Comparable<ResolvedVersion> {
  final String package;
  final String version;
  final DateTime? created;

  ResolvedVersion({
    required this.package,
    required this.version,
    required this.created,
  });

  factory ResolvedVersion.fromJson(Map<String, dynamic> json) =>
      _$ResolvedVersionFromJson(json);

  Map<String, dynamic> toJson() => _$ResolvedVersionToJson(this);

  @override
  int compareTo(ResolvedVersion other) => created!.compareTo(other.created!);
}
