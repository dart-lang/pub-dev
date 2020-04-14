// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:yaml/yaml.dart' as yaml;

part 'mirror_config.g.dart';

/// The configuration to use when creating a local (partial) mirror of pub.dev
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MirrorConfig {
  List<Package> packages;
  List<Publisher> publishers;
  List<User> users;
  String defaultUser;

  MirrorConfig({
    @required this.packages,
    @required this.publishers,
    @required this.users,
    this.defaultUser,
  });

  factory MirrorConfig.fromJson(Map<String, dynamic> json,
      {bool normalize = false}) {
    final mc = _$MirrorConfigFromJson(json);
    if (normalize) mc.normalize();
    return mc;
  }

  factory MirrorConfig.fromYaml(String source, {bool normalize = false}) {
    final map = json.decode(json.encode(yaml.loadYaml(source)));
    final mc = MirrorConfig.fromJson(map as Map<String, dynamic>);
    if (normalize) mc.normalize();
    return mc;
  }

  Map<String, dynamic> toJson() => _$MirrorConfigToJson(this);

  void normalize() {
    packages ??= <Package>[];
    publishers ??= <Publisher>[];
    users ??= <User>[];

    for (final publisher in publishers) {
      publisher.members ??= <Member>[];

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
            publisher.admins.map((e) => Member(email: e, role: 'admin')));
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
          publishers.add(Publisher(name: package.publisher, members: []));
        }
      }
    }

    defaultUser ??= users.first.email;
    _createUserIfNeeded(defaultUser);

    for (final publisher in publishers) {
      if (publisher.members.isEmpty) {
        publisher.members.add(Member(email: defaultUser, role: 'admin'));
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
      users.add(User(email: email));
    }
  }
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Package {
  final String name;
  List<String> uploaders;
  String publisher;
  List<String> versions;

  Package({
    this.name,
    this.uploaders,
    this.publisher,
    this.versions,
  });

  factory Package.fromJson(Map<String, dynamic> json) =>
      _$PackageFromJson(json);

  Map<String, dynamic> toJson() => _$PackageToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Publisher {
  final String name;
  List<Member> members;
  List<Package> packages;
  List<String> admins;

  Publisher({
    @required this.name,
    @required this.members,
    this.packages,
    this.admins,
  });

  factory Publisher.fromJson(Map<String, dynamic> json) =>
      _$PublisherFromJson(json);

  Map<String, dynamic> toJson() => _$PublisherToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Member {
  final String email;
  final String role;

  Member({
    @required this.email,
    @required this.role,
  });

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class User {
  final String email;
  final List<String> likes;

  User({
    @required this.email,
    this.likes,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
