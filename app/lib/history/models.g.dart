// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryUnion _$HistoryUnionFromJson(Map<String, dynamic> json) {
  return HistoryUnion(
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
              json['analysisCompleted'] as Map<String, dynamic>));
}

Map<String, dynamic> _$HistoryUnionToJson(HistoryUnion instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('packageUploaded', instance.packageUploaded?.toJson());
  writeNotNull('uploaderChanged', instance.uploaderChanged?.toJson());
  writeNotNull('uploaderInvited', instance.uploaderInvited?.toJson());
  writeNotNull('analysisCompleted', instance.analysisCompleted?.toJson());
  return val;
}

PackageUploaded _$PackageUploadedFromJson(Map<String, dynamic> json) {
  return PackageUploaded(
      packageName: json['packageName'] as String,
      packageVersion: json['packageVersion'] as String,
      uploaderEmail: json['uploaderEmail'] as String,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String));
}

Map<String, dynamic> _$PackageUploadedToJson(PackageUploaded instance) =>
    <String, dynamic>{
      'packageName': instance.packageName,
      'packageVersion': instance.packageVersion,
      'uploaderEmail': instance.uploaderEmail,
      'timestamp': instance.timestamp?.toIso8601String()
    };

UploaderChanged _$UploaderChangedFromJson(Map<String, dynamic> json) {
  return UploaderChanged(
      packageName: json['packageName'] as String,
      currentUserEmail: json['currentUserEmail'] as String,
      addedUploaderEmails: (json['addedUploaderEmails'] as List)
          ?.map((e) => e as String)
          ?.toList(),
      removedUploaderEmails: (json['removedUploaderEmails'] as List)
          ?.map((e) => e as String)
          ?.toList(),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String));
}

Map<String, dynamic> _$UploaderChangedToJson(UploaderChanged instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('packageName', instance.packageName);
  writeNotNull('currentUserEmail', instance.currentUserEmail);
  writeNotNull('addedUploaderEmails', instance.addedUploaderEmails);
  writeNotNull('removedUploaderEmails', instance.removedUploaderEmails);
  writeNotNull('timestamp', instance.timestamp?.toIso8601String());
  return val;
}

UploaderInvited _$UploaderInvitedFromJson(Map<String, dynamic> json) {
  return UploaderInvited(
      packageName: json['packageName'] as String,
      currentUserEmail: json['currentUserEmail'] as String,
      uploaderUserEmail: json['uploaderUserEmail'] as String,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String));
}

Map<String, dynamic> _$UploaderInvitedToJson(UploaderInvited instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('packageName', instance.packageName);
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
          : DateTime.parse(json['timestamp'] as String));
}

Map<String, dynamic> _$AnalysisCompletedToJson(AnalysisCompleted instance) =>
    <String, dynamic>{
      'packageName': instance.packageName,
      'packageVersion': instance.packageVersion,
      'hasErrors': instance.hasErrors,
      'hasPlatforms': instance.hasPlatforms,
      'timestamp': instance.timestamp?.toIso8601String()
    };
