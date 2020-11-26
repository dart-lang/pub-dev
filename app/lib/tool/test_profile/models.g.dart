// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestProfile _$TestProfileFromJson(Map<String, dynamic> json) {
  return TestProfile(
    packages: (json['packages'] as List)
        ?.map((e) =>
            e == null ? null : TestPackage.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    publishers: (json['publishers'] as List)
        ?.map((e) => e == null
            ? null
            : TestPublisher.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    users: (json['users'] as List)
        ?.map((e) =>
            e == null ? null : TestUser.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    defaultUser: json['defaultUser'] as String,
  );
}

Map<String, dynamic> _$TestProfileToJson(TestProfile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'packages', instance.packages?.map((e) => e?.toJson())?.toList());
  writeNotNull(
      'publishers', instance.publishers?.map((e) => e?.toJson())?.toList());
  writeNotNull('users', instance.users?.map((e) => e?.toJson())?.toList());
  writeNotNull('defaultUser', instance.defaultUser);
  return val;
}

TestPackage _$TestPackageFromJson(Map<String, dynamic> json) {
  return TestPackage(
    name: json['name'] as String,
    uploaders: (json['uploaders'] as List)?.map((e) => e as String)?.toList(),
    publisher: json['publisher'] as String,
    versions: (json['versions'] as List)?.map((e) => e as String)?.toList(),
    isDiscontinued: json['isDiscontinued'] as bool,
    replacedBy: json['replacedBy'] as String,
    isUnlisted: json['isUnlisted'] as bool,
  );
}

Map<String, dynamic> _$TestPackageToJson(TestPackage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('uploaders', instance.uploaders);
  writeNotNull('publisher', instance.publisher);
  writeNotNull('versions', instance.versions);
  writeNotNull('isDiscontinued', instance.isDiscontinued);
  writeNotNull('replacedBy', instance.replacedBy);
  writeNotNull('isUnlisted', instance.isUnlisted);
  return val;
}

TestPublisher _$TestPublisherFromJson(Map<String, dynamic> json) {
  return TestPublisher(
    name: json['name'] as String,
    created: json['created'] == null
        ? null
        : DateTime.parse(json['created'] as String),
    updated: json['updated'] == null
        ? null
        : DateTime.parse(json['updated'] as String),
    members: (json['members'] as List)
        ?.map((e) =>
            e == null ? null : TestMember.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TestPublisherToJson(TestPublisher instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('created', instance.created?.toIso8601String());
  writeNotNull('updated', instance.updated?.toIso8601String());
  writeNotNull('members', instance.members?.map((e) => e?.toJson())?.toList());
  return val;
}

TestMember _$TestMemberFromJson(Map<String, dynamic> json) {
  return TestMember(
    email: json['email'] as String,
    role: json['role'] as String,
    created: json['created'] == null
        ? null
        : DateTime.parse(json['created'] as String),
    updated: json['updated'] == null
        ? null
        : DateTime.parse(json['updated'] as String),
  );
}

Map<String, dynamic> _$TestMemberToJson(TestMember instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('email', instance.email);
  writeNotNull('role', instance.role);
  writeNotNull('created', instance.created?.toIso8601String());
  writeNotNull('updated', instance.updated?.toIso8601String());
  return val;
}

TestUser _$TestUserFromJson(Map<String, dynamic> json) {
  return TestUser(
    email: json['email'] as String,
    oauthUserId: json['oauthUserId'] as String,
    created: json['created'] == null
        ? null
        : DateTime.parse(json['created'] as String),
    isDeleted: json['isDeleted'] as bool,
    isBlocked: json['isBlocked'] as bool,
    likes: (json['likes'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$TestUserToJson(TestUser instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('email', instance.email);
  writeNotNull('oauthUserId', instance.oauthUserId);
  writeNotNull('created', instance.created?.toIso8601String());
  writeNotNull('isDeleted', instance.isDeleted);
  writeNotNull('isBlocked', instance.isBlocked);
  writeNotNull('likes', instance.likes);
  return val;
}

ResolvedVersion _$ResolvedVersionFromJson(Map<String, dynamic> json) {
  return ResolvedVersion(
    package: json['package'] as String,
    version: json['version'] as String,
    created: json['created'] == null
        ? null
        : DateTime.parse(json['created'] as String),
  );
}

Map<String, dynamic> _$ResolvedVersionToJson(ResolvedVersion instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('package', instance.package);
  writeNotNull('version', instance.version);
  writeNotNull('created', instance.created?.toIso8601String());
  return val;
}
