// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RateLimitRequestCounter _$RateLimitRequestCounterFromJson(
        Map<String, dynamic> json) =>
    RateLimitRequestCounter(
      started: DateTime.parse(json['started'] as String),
      value: (json['value'] as num).toInt(),
    );

Map<String, dynamic> _$RateLimitRequestCounterToJson(
        RateLimitRequestCounter instance) =>
    <String, dynamic>{
      'started': instance.started.toIso8601String(),
      'value': instance.value,
    };
