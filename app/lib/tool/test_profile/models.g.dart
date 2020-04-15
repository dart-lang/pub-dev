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
  return val;
}

TestPublisher _$TestPublisherFromJson(Map<String, dynamic> json) {
  return TestPublisher(
    name: json['name'] as String,
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
  writeNotNull('members', instance.members?.map((e) => e?.toJson())?.toList());
  return val;
}

TestMember _$TestMemberFromJson(Map<String, dynamic> json) {
  return TestMember(
    email: json['email'] as String,
    role: json['role'] as String,
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
  return val;
}

TestUser _$TestUserFromJson(Map<String, dynamic> json) {
  return TestUser(
    email: json['email'] as String,
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
  writeNotNull('likes', instance.likes);
  return val;
}
