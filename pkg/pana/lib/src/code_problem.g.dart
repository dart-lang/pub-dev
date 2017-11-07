// GENERATED CODE - DO NOT MODIFY BY HAND

part of pana.code_problem;

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

CodeProblem _$CodeProblemFromJson(Map<String, dynamic> json) => new CodeProblem(
    json['severity'] as String,
    json['errorType'] as String,
    json['errorCode'] as String,
    json['description'] as String,
    json['file'] as String,
    json['line'] as int,
    json['col'] as int);

abstract class _$CodeProblemSerializerMixin {
  String get severity;
  String get errorType;
  String get errorCode;
  String get file;
  int get line;
  int get col;
  String get description;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'severity': severity,
        'errorType': errorType,
        'errorCode': errorCode,
        'file': file,
        'line': line,
        'col': col,
        'description': description
      };
}
