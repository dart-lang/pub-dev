// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mirror_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MirrorConfig _$MirrorConfigFromJson(Map<String, dynamic> json) {
  return MirrorConfig(
    packages: (json['packages'] as List)
        ?.map((e) =>
            e == null ? null : Package.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    publishers: (json['publishers'] as List)
        ?.map((e) =>
            e == null ? null : Publisher.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    users: (json['users'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    defaultUser: json['defaultUser'] as String,
  );
}

Map<String, dynamic> _$MirrorConfigToJson(MirrorConfig instance) {
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

Package _$PackageFromJson(Map<String, dynamic> json) {
  return Package(
    name: json['name'] as String,
    uploaders: (json['uploaders'] as List)?.map((e) => e as String)?.toList(),
    publisher: json['publisher'] as String,
    versions: (json['versions'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$PackageToJson(Package instance) {
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

Publisher _$PublisherFromJson(Map<String, dynamic> json) {
  return Publisher(
    name: json['name'] as String,
    members: (json['members'] as List)
        ?.map((e) =>
            e == null ? null : Member.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    packages: (json['packages'] as List)
        ?.map((e) =>
            e == null ? null : Package.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    admins: (json['admins'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$PublisherToJson(Publisher instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('members', instance.members?.map((e) => e?.toJson())?.toList());
  writeNotNull(
      'packages', instance.packages?.map((e) => e?.toJson())?.toList());
  writeNotNull('admins', instance.admins);
  return val;
}

Member _$MemberFromJson(Map<String, dynamic> json) {
  return Member(
    email: json['email'] as String,
    role: json['role'] as String,
  );
}

Map<String, dynamic> _$MemberToJson(Member instance) {
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

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    email: json['email'] as String,
    likes: (json['likes'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$UserToJson(User instance) {
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
