//
//  Generated code. Do not modify.
//  source: google/api/expr/v1alpha1/syntax.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// CEL component specifier.
class SourceInfo_Extension_Component extends $pb.ProtobufEnum {
  static const SourceInfo_Extension_Component COMPONENT_UNSPECIFIED =
      SourceInfo_Extension_Component._(
          0, _omitEnumNames ? '' : 'COMPONENT_UNSPECIFIED');
  static const SourceInfo_Extension_Component COMPONENT_PARSER =
      SourceInfo_Extension_Component._(
          1, _omitEnumNames ? '' : 'COMPONENT_PARSER');
  static const SourceInfo_Extension_Component COMPONENT_TYPE_CHECKER =
      SourceInfo_Extension_Component._(
          2, _omitEnumNames ? '' : 'COMPONENT_TYPE_CHECKER');
  static const SourceInfo_Extension_Component COMPONENT_RUNTIME =
      SourceInfo_Extension_Component._(
          3, _omitEnumNames ? '' : 'COMPONENT_RUNTIME');

  static const $core.List<SourceInfo_Extension_Component> values =
      <SourceInfo_Extension_Component>[
    COMPONENT_UNSPECIFIED,
    COMPONENT_PARSER,
    COMPONENT_TYPE_CHECKER,
    COMPONENT_RUNTIME,
  ];

  static final $core.Map<$core.int, SourceInfo_Extension_Component> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static SourceInfo_Extension_Component? valueOf($core.int value) =>
      _byValue[value];

  const SourceInfo_Extension_Component._($core.int v, $core.String n)
      : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
