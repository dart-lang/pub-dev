//
//  Generated code. Do not modify.
//  source: google/logging/v2/logging_metrics.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Logging API version.
class LogMetric_ApiVersion extends $pb.ProtobufEnum {
  static const LogMetric_ApiVersion V2 =
      LogMetric_ApiVersion._(0, _omitEnumNames ? '' : 'V2');
  static const LogMetric_ApiVersion V1 =
      LogMetric_ApiVersion._(1, _omitEnumNames ? '' : 'V1');

  static const $core.List<LogMetric_ApiVersion> values = <LogMetric_ApiVersion>[
    V2,
    V1,
  ];

  static final $core.Map<$core.int, LogMetric_ApiVersion> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static LogMetric_ApiVersion? valueOf($core.int value) => _byValue[value];

  const LogMetric_ApiVersion._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
