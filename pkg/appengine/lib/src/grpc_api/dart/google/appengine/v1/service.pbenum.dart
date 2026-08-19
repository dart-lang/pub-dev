//
//  Generated code. Do not modify.
//  source: google/appengine/v1/service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Available sharding mechanisms.
class TrafficSplit_ShardBy extends $pb.ProtobufEnum {
  static const TrafficSplit_ShardBy UNSPECIFIED =
      TrafficSplit_ShardBy._(0, _omitEnumNames ? '' : 'UNSPECIFIED');
  static const TrafficSplit_ShardBy COOKIE =
      TrafficSplit_ShardBy._(1, _omitEnumNames ? '' : 'COOKIE');
  static const TrafficSplit_ShardBy IP =
      TrafficSplit_ShardBy._(2, _omitEnumNames ? '' : 'IP');
  static const TrafficSplit_ShardBy RANDOM =
      TrafficSplit_ShardBy._(3, _omitEnumNames ? '' : 'RANDOM');

  static const $core.List<TrafficSplit_ShardBy> values = <TrafficSplit_ShardBy>[
    UNSPECIFIED,
    COOKIE,
    IP,
    RANDOM,
  ];

  static final $core.Map<$core.int, TrafficSplit_ShardBy> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static TrafficSplit_ShardBy? valueOf($core.int value) => _byValue[value];

  const TrafficSplit_ShardBy._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
