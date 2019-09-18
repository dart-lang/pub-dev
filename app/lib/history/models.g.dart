// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryUnion _$HistoryUnionFromJson(Map<String, dynamic> json) {
  return HistoryUnion(
    packageOptionsChanged: json['packageOptionsChanged'] == null
        ? null
        : PackageOptionsChanged.fromJson(
            json['packageOptionsChanged'] as Map<String, dynamic>),
    packageTransferred: json['packageTransferred'] == null
        ? null
        : PackageTransferred.fromJson(
            json['packageTransferred'] as Map<String, dynamic>),
    packageUploaded: json['packageUploaded'] == null
        ? null
        : PackageUploaded.fromJson(
            json['packageUploaded'] as Map<String, dynamic>),
    uploaderChanged: json['uploaderChanged'] == null
        ? null
        : UploaderChanged.fromJson(
            json['uploaderChanged'] as Map<String, dynamic>),
    uploaderInvited: json['uploaderInvited'] == null
        ? null
        : UploaderInvited.fromJson(
            json['uploaderInvited'] as Map<String, dynamic>),
    analysisCompleted: json['analysisCompleted'] == null
        ? null
        : AnalysisCompleted.fromJson(
            json['analysisCompleted'] as Map<String, dynamic>),
    publisherCreated: json['publisherCreated'] == null
        ? null
        : PublisherCreated.fromJson(
            json['publisherCreated'] as Map<String, dynamic>),
    memberInvited: json['memberInvited'] == null
        ? null
        : MemberInvited.fromJson(json['memberInvited'] as Map<String, dynamic>),
    memberJoined: json['memberJoined'] == null
        ? null
        : MemberJoined.fromJson(json['memberJoined'] as Map<String, dynamic>),
    memberRemoved: json['memberRemoved'] == null
        ? null
        : MemberRemoved.fromJson(json['memberRemoved'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HistoryUnionToJson(HistoryUnion instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'packageOptionsChanged', instance.packageOptionsChanged?.toJson());
  writeNotNull('packageTransferred', instance.packageTransferred?.toJson());
  writeNotNull('packageUploaded', instance.packageUploaded?.toJson());
  writeNotNull('uploaderChanged', instance.uploaderChanged?.toJson());
  writeNotNull('uploaderInvited', instance.uploaderInvited?.toJson());
  writeNotNull('analysisCompleted', instance.analysisCompleted?.toJson());
  writeNotNull('publisherCreated', instance.publisherCreated?.toJson());
  writeNotNull('memberInvited', instance.memberInvited?.toJson());
  writeNotNull('memberJoined', instance.memberJoined?.toJson());
  writeNotNull('memberRemoved', instance.memberRemoved?.toJson());
  return val;
}

PackageOptionsChanged _$PackageOptionsChangedFromJson(
    Map<String, dynamic> json) {
  return PackageOptionsChanged(
    packageName: json['packageName'] as String,
    userId: json['userId'] as String,
    userEmail: json['userEmail'] as String,
    isDiscontinued: json['isDiscontinued'] as bool,
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
  );
}

Map<String, dynamic> _$PackageOptionsChangedToJson(
    PackageOptionsChanged instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('packageName', instance.packageName);
  writeNotNull('userId', instance.userId);
  writeNotNull('userEmail', instance.userEmail);
  writeNotNull('isDiscontinued', instance.isDiscontinued);
  writeNotNull('timestamp', instance.timestamp?.toIso8601String());
  return val;
}

PackageTransferred _$PackageTransferredFromJson(Map<String, dynamic> json) {
  return PackageTransferred(
    packageName: json['packageName'] as String,
    fromPublisherId: json['fromPublisherId'] as String,
    toPublisherId: json['toPublisherId'] as String,
    userId: json['userId'] as String,
    userEmail: json['userEmail'] as String,
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
  );
}

Map<String, dynamic> _$PackageTransferredToJson(PackageTransferred instance) =>
    <String, dynamic>{
      'packageName': instance.packageName,
      'fromPublisherId': instance.fromPublisherId,
      'toPublisherId': instance.toPublisherId,
      'userId': instance.userId,
      'userEmail': instance.userEmail,
      'timestamp': instance.timestamp?.toIso8601String(),
    };

PackageUploaded _$PackageUploadedFromJson(Map<String, dynamic> json) {
  return PackageUploaded(
    packageName: json['packageName'] as String,
    packageVersion: json['packageVersion'] as String,
    uploaderId: json['uploaderId'] as String,
    uploaderEmail: json['uploaderEmail'] as String,
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
  );
}

Map<String, dynamic> _$PackageUploadedToJson(PackageUploaded instance) =>
    <String, dynamic>{
      'packageName': instance.packageName,
      'packageVersion': instance.packageVersion,
      'uploaderId': instance.uploaderId,
      'uploaderEmail': instance.uploaderEmail,
      'timestamp': instance.timestamp?.toIso8601String(),
    };

UploaderChanged _$UploaderChangedFromJson(Map<String, dynamic> json) {
  return UploaderChanged(
    packageName: json['packageName'] as String,
    currentUserId: json['currentUserId'] as String,
    currentUserEmail: json['currentUserEmail'] as String,
    addedUploaderIds:
        (json['addedUploaderIds'] as List)?.map((e) => e as String)?.toList(),
    addedUploaderEmails: (json['addedUploaderEmails'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    removedUploaderIds:
        (json['removedUploaderIds'] as List)?.map((e) => e as String)?.toList(),
    removedUploaderEmails: (json['removedUploaderEmails'] as List)
        ?.map((e) => e as String)
        ?.toList(),
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
  );
}

Map<String, dynamic> _$UploaderChangedToJson(UploaderChanged instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('packageName', instance.packageName);
  writeNotNull('currentUserId', instance.currentUserId);
  writeNotNull('currentUserEmail', instance.currentUserEmail);
  writeNotNull('addedUploaderIds', instance.addedUploaderIds);
  writeNotNull('addedUploaderEmails', instance.addedUploaderEmails);
  writeNotNull('removedUploaderIds', instance.removedUploaderIds);
  writeNotNull('removedUploaderEmails', instance.removedUploaderEmails);
  writeNotNull('timestamp', instance.timestamp?.toIso8601String());
  return val;
}

UploaderInvited _$UploaderInvitedFromJson(Map<String, dynamic> json) {
  return UploaderInvited(
    packageName: json['packageName'] as String,
    currentUserId: json['currentUserId'] as String,
    currentUserEmail: json['currentUserEmail'] as String,
    uploaderUserEmail: json['uploaderUserEmail'] as String,
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
  );
}

Map<String, dynamic> _$UploaderInvitedToJson(UploaderInvited instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('packageName', instance.packageName);
  writeNotNull('currentUserId', instance.currentUserId);
  writeNotNull('currentUserEmail', instance.currentUserEmail);
  writeNotNull('uploaderUserEmail', instance.uploaderUserEmail);
  writeNotNull('timestamp', instance.timestamp?.toIso8601String());
  return val;
}

AnalysisCompleted _$AnalysisCompletedFromJson(Map<String, dynamic> json) {
  return AnalysisCompleted(
    packageName: json['packageName'] as String,
    packageVersion: json['packageVersion'] as String,
    hasErrors: json['hasErrors'] as bool,
    hasPlatforms: json['hasPlatforms'] as bool,
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
  );
}

Map<String, dynamic> _$AnalysisCompletedToJson(AnalysisCompleted instance) =>
    <String, dynamic>{
      'packageName': instance.packageName,
      'packageVersion': instance.packageVersion,
      'hasErrors': instance.hasErrors,
      'hasPlatforms': instance.hasPlatforms,
      'timestamp': instance.timestamp?.toIso8601String(),
    };

PublisherCreated _$PublisherCreatedFromJson(Map<String, dynamic> json) {
  return PublisherCreated(
    publisherId: json['publisherId'] as String,
    userId: json['userId'] as String,
    userEmail: json['userEmail'] as String,
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
  );
}

Map<String, dynamic> _$PublisherCreatedToJson(PublisherCreated instance) =>
    <String, dynamic>{
      'publisherId': instance.publisherId,
      'userId': instance.userId,
      'userEmail': instance.userEmail,
      'timestamp': instance.timestamp?.toIso8601String(),
    };

MemberInvited _$MemberInvitedFromJson(Map<String, dynamic> json) {
  return MemberInvited(
    publisherId: json['publisherId'] as String,
    currentUserId: json['currentUserId'] as String,
    currentUserEmail: json['currentUserEmail'] as String,
    invitedUserId: json['invitedUserId'] as String,
    invitedUserEmail: json['invitedUserEmail'] as String,
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
  );
}

Map<String, dynamic> _$MemberInvitedToJson(MemberInvited instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('publisherId', instance.publisherId);
  writeNotNull('currentUserId', instance.currentUserId);
  writeNotNull('currentUserEmail', instance.currentUserEmail);
  writeNotNull('invitedUserId', instance.invitedUserId);
  writeNotNull('invitedUserEmail', instance.invitedUserEmail);
  writeNotNull('timestamp', instance.timestamp?.toIso8601String());
  return val;
}

MemberJoined _$MemberJoinedFromJson(Map<String, dynamic> json) {
  return MemberJoined(
    publisherId: json['publisherId'] as String,
    userId: json['userId'] as String,
    userEmail: json['userEmail'] as String,
    role: json['role'] as String,
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
  );
}

Map<String, dynamic> _$MemberJoinedToJson(MemberJoined instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('publisherId', instance.publisherId);
  writeNotNull('userId', instance.userId);
  writeNotNull('userEmail', instance.userEmail);
  writeNotNull('role', instance.role);
  writeNotNull('timestamp', instance.timestamp?.toIso8601String());
  return val;
}

MemberRemoved _$MemberRemovedFromJson(Map<String, dynamic> json) {
  return MemberRemoved(
    publisherId: json['publisherId'] as String,
    currentUserId: json['currentUserId'] as String,
    currentUserEmail: json['currentUserEmail'] as String,
    removedUserId: json['removedUserId'] as String,
    removedUserEmail: json['removedUserEmail'] as String,
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
  );
}

Map<String, dynamic> _$MemberRemovedToJson(MemberRemoved instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('publisherId', instance.publisherId);
  writeNotNull('currentUserId', instance.currentUserId);
  writeNotNull('currentUserEmail', instance.currentUserEmail);
  writeNotNull('removedUserId', instance.removedUserId);
  writeNotNull('removedUserEmail', instance.removedUserEmail);
  writeNotNull('timestamp', instance.timestamp?.toIso8601String());
  return val;
}
