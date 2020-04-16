// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:yaml/yaml.dart' as yaml;

part 'models.g.dart';

/// The configuration to use when creating a local (partial) mirror of pub.dev
/// in order to us it in tests.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TestProfile {
  final List<TestPackage> packages;
  final List<TestPublisher> publishers;
  final List<TestUser> users;
  String defaultUser;

  TestProfile({
    @required List<TestPackage> packages,
    @required List<TestPublisher> publishers,
    @required List<TestUser> users,
    this.defaultUser,
  })  : packages = packages ?? <TestPackage>[],
        publishers = publishers ?? <TestPublisher>[],
        users = users ?? <TestUser>[];

  factory TestProfile.fromJson(Map<String, dynamic> json,
      {bool normalize = false}) {
    final mc = _$TestProfileFromJson(json);
    if (normalize) mc.normalize();
    return mc;
  }

  factory TestProfile.fromYaml(String source, {bool normalize = false}) {
    final map = json.decode(json.encode(yaml.loadYaml(source)));
    final mc = TestProfile.fromJson(map as Map<String, dynamic>);
    if (normalize) mc.normalize();
    return mc;
  }

  Map<String, dynamic> toJson() => _$TestProfileToJson(this);

  void normalize() {
    // add missing users from publishers
    publishers
        .expand((p) => p.members)
        .forEach((m) => _createUserIfNeeded(m.email));
    // add missing users from packages
    packages
        .where((p) => p.uploaders != null)
        .expand((p) => p.uploaders)
        .forEach(_createUserIfNeeded);

    defaultUser ??= users.first.email;
    _createUserIfNeeded(defaultUser);

    for (final package in packages) {
      // add missing publishers
      if (package.publisher != null) {
        final publisher = publishers
            .firstWhere((p) => p.name == package.publisher, orElse: () => null);
        if (publisher == null) {
          publishers.add(TestPublisher(
            name: package.publisher,
            members: [
              TestMember(
                email: defaultUser,
                role: 'admin',
              ),
            ],
          ));
        }
      }
    }

    for (final package in packages) {
      if (package.publisher == null) {
        package.uploaders ??= <String>[];
        if (package.uploaders.isEmpty) {
          package.uploaders.add(defaultUser);
        }
      }
    }
  }

  void _createUserIfNeeded(String email) {
    final user = users.firstWhere((u) => u.email == email, orElse: () => null);
    if (user == null) {
      users.add(TestUser(email: email, likes: <String>[]));
    }
  }
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TestPackage {
  final String name;
  List<String> uploaders;
  String publisher;
  List<String> versions;

  TestPackage({
    this.name,
    this.uploaders,
    this.publisher,
    this.versions,
  });

  factory TestPackage.fromJson(Map<String, dynamic> json) =>
      _$TestPackageFromJson(json);

  Map<String, dynamic> toJson() => _$TestPackageToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TestPublisher {
  final String name;
  List<TestMember> members;

  TestPublisher({
    @required this.name,
    @required List<TestMember> members,
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
    @required this.email,
    @required this.role,
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
    @required this.email,
    @required List<String> likes,
  }) : likes = likes ?? <String>[];

  factory TestUser.fromJson(Map<String, dynamic> json) =>
      _$TestUserFromJson(json);

  Map<String, dynamic> toJson() => _$TestUserToJson(this);
}
