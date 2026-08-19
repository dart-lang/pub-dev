//
//  Generated code. Do not modify.
//  source: google/api/expr/conformance/v1alpha1/conformance_service.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Severities of issues.
class IssueDetails_Severity extends $pb.ProtobufEnum {
  static const IssueDetails_Severity SEVERITY_UNSPECIFIED =
      IssueDetails_Severity._(0, _omitEnumNames ? '' : 'SEVERITY_UNSPECIFIED');
  static const IssueDetails_Severity DEPRECATION =
      IssueDetails_Severity._(1, _omitEnumNames ? '' : 'DEPRECATION');
  static const IssueDetails_Severity WARNING =
      IssueDetails_Severity._(2, _omitEnumNames ? '' : 'WARNING');
  static const IssueDetails_Severity ERROR =
      IssueDetails_Severity._(3, _omitEnumNames ? '' : 'ERROR');

  static const $core.List<IssueDetails_Severity> values =
      <IssueDetails_Severity>[
    SEVERITY_UNSPECIFIED,
    DEPRECATION,
    WARNING,
    ERROR,
  ];

  static final $core.Map<$core.int, IssueDetails_Severity> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static IssueDetails_Severity? valueOf($core.int value) => _byValue[value];

  const IssueDetails_Severity._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
