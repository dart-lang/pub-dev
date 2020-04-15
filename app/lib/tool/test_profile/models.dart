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
  List<TestPackage> packages;
  List<TestPublisher> publishers;
  List<TestUser> users;
  String defaultUser;

  TestProfile({
    @required this.packages,
    @required this.publishers,
    @required this.users,
    this.defaultUser,
  });

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
    packages ??= <TestPackage>[];
    publishers ??= <TestPublisher>[];
    users ??= <TestUser>[];

    for (final publisher in publishers) {
      publisher.members ??= <TestMember>[];

      // copy package definitions to [MirrorConfig.packages]
      if (publisher.packages != null) {
        publisher.packages.forEach((p) {
          p.publisher = publisher.name;
          packages.add(p);
        });
        publisher.packages = null;
      }

      // convert admins to members
      if (publisher.admins != null) {
        publisher.members.addAll(
            publisher.admins.map((e) => TestMember(email: e, role: 'admin')));
        publisher.admins = null;
      }

      // add missing users
      publisher.members?.forEach((m) => _createUserIfNeeded(m.email));
    }

    for (final package in packages) {
      // add missing users
      package.uploaders?.forEach(_createUserIfNeeded);

      // add missing publishers
      if (package.publisher != null) {
        final publisher = publishers
            .firstWhere((p) => p.name == package.publisher, orElse: () => null);
        if (publisher == null) {
          publishers.add(TestPublisher(name: package.publisher, members: []));
        }
      }
    }

    defaultUser ??= users.first.email;
    _createUserIfNeeded(defaultUser);

    for (final publisher in publishers) {
      if (publisher.members.isEmpty) {
        publisher.members.add(TestMember(email: defaultUser, role: 'admin'));
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
      users.add(TestUser(email: email));
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
  List<TestPackage> packages;
  List<String> admins;

  TestPublisher({
    @required this.name,
    @required this.members,
    this.packages,
    this.admins,
  });

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
    List<String> likes,
  }) : likes = likes ?? <String>[];

  factory TestUser.fromJson(Map<String, dynamic> json) =>
      _$TestUserFromJson(json);

  Map<String, dynamic> toJson() => _$TestUserToJson(this);
}
