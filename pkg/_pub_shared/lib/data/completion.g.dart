// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompletionData _$CompletionDataFromJson(Map<String, dynamic> json) =>
    CompletionData(
      completions: (json['completions'] as List<dynamic>)
          .map((e) => CompletionRule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CompletionDataToJson(CompletionData instance) =>
    <String, dynamic>{
      'completions': instance.completions,
    };

CompletionRule _$CompletionRuleFromJson(Map<String, dynamic> json) =>
    CompletionRule(
      match:
          (json['match'] as List<dynamic>?)?.map((e) => e as String).toSet() ??
              const <String>{},
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      terminal: json['terminal'] as bool? ?? true,
      forcedOnly: json['forcedOnly'] as bool? ?? false,
    );

Map<String, dynamic> _$CompletionRuleToJson(CompletionRule instance) =>
    <String, dynamic>{
      'match': instance.match.toList(),
      'options': instance.options,
      'terminal': instance.terminal,
      'forcedOnly': instance.forcedOnly,
    };
