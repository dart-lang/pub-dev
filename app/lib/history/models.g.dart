// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageVersionUploaded _$PackageVersionUploadedFromJson(
    Map<String, dynamic> json) {
  return PackageVersionUploaded(uploaderEmail: json['uploaderEmail'] as String);
}

Map<String, dynamic> _$PackageVersionUploadedToJson(
        PackageVersionUploaded instance) =>
    <String, dynamic>{'uploaderEmail': instance.uploaderEmail};

UploaderChanged _$UploaderChangedFromJson(Map<String, dynamic> json) {
  return UploaderChanged(
      currentUserEmail: json['currentUserEmail'] as String,
      addedUploaderEmails: (json['addedUploaderEmails'] as List)
          ?.map((e) => e as String)
          ?.toList(),
      removedUploaderEmails: (json['removedUploaderEmails'] as List)
          ?.map((e) => e as String)
          ?.toList());
}

Map<String, dynamic> _$UploaderChangedToJson(UploaderChanged instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('currentUserEmail', instance.currentUserEmail);
  writeNotNull('addedUploaderEmails', instance.addedUploaderEmails);
  writeNotNull('removedUploaderEmails', instance.removedUploaderEmails);
  return val;
}

AnalysisCompleted _$AnalysisCompletedFromJson(Map<String, dynamic> json) {
  return AnalysisCompleted(
      hasErrors: json['hasErrors'] as bool,
      hasPlatforms: json['hasPlatforms'] as bool);
}

Map<String, dynamic> _$AnalysisCompletedToJson(AnalysisCompleted instance) =>
    <String, dynamic>{
      'hasErrors': instance.hasErrors,
      'hasPlatforms': instance.hasPlatforms
    };
