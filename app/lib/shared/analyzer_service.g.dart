// GENERATED CODE - DO NOT MODIFY BY HAND

part of pub_dartlang_org.shared.analyzer_service;

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

AnalysisData _$AnalysisDataFromJson(Map<String, dynamic> json) =>
    new AnalysisData(
        packageName: json['packageName'] as String,
        packageVersion: json['packageVersion'] as String,
        analysis: json['analysis'] as int,
        timestamp: json['timestamp'] == null
            ? null
            : DateTime.parse(json['timestamp'] as String),
        panaVersion: json['panaVersion'] as String,
        flutterVersion: json['flutterVersion'] as String,
        analysisStatus: json['analysisStatus'] == null
            ? null
            : AnalysisStatus.values.singleWhere((x) =>
                x.toString() == "AnalysisStatus.${json['analysisStatus']}"),
        analysisContent: json['analysisContent'] as Map<String, dynamic>);

abstract class _$AnalysisDataSerializerMixin {
  String get packageName;
  String get packageVersion;
  int get analysis;
  DateTime get timestamp;
  String get panaVersion;
  String get flutterVersion;
  AnalysisStatus get analysisStatus;
  Map<dynamic, dynamic> get analysisContent;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'packageName': packageName,
        'packageVersion': packageVersion,
        'analysis': analysis,
        'timestamp': timestamp?.toIso8601String(),
        'panaVersion': panaVersion,
        'flutterVersion': flutterVersion,
        'analysisStatus': analysisStatus == null
            ? null
            : analysisStatus.toString().split('.')[1],
        'analysisContent': analysisContent
      };
}
