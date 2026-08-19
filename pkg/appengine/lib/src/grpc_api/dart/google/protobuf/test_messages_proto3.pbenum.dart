//
//  Generated code. Do not modify.
//  source: google/protobuf/test_messages_proto3.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ForeignEnum extends $pb.ProtobufEnum {
  static const ForeignEnum FOREIGN_FOO =
      ForeignEnum._(0, _omitEnumNames ? '' : 'FOREIGN_FOO');
  static const ForeignEnum FOREIGN_BAR =
      ForeignEnum._(1, _omitEnumNames ? '' : 'FOREIGN_BAR');
  static const ForeignEnum FOREIGN_BAZ =
      ForeignEnum._(2, _omitEnumNames ? '' : 'FOREIGN_BAZ');

  static const $core.List<ForeignEnum> values = <ForeignEnum>[
    FOREIGN_FOO,
    FOREIGN_BAR,
    FOREIGN_BAZ,
  ];

  static final $core.Map<$core.int, ForeignEnum> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static ForeignEnum? valueOf($core.int value) => _byValue[value];

  const ForeignEnum._($core.int v, $core.String n) : super(v, n);
}

class TestAllTypesProto3_NestedEnum extends $pb.ProtobufEnum {
  static const TestAllTypesProto3_NestedEnum FOO =
      TestAllTypesProto3_NestedEnum._(0, _omitEnumNames ? '' : 'FOO');
  static const TestAllTypesProto3_NestedEnum BAR =
      TestAllTypesProto3_NestedEnum._(1, _omitEnumNames ? '' : 'BAR');
  static const TestAllTypesProto3_NestedEnum BAZ =
      TestAllTypesProto3_NestedEnum._(2, _omitEnumNames ? '' : 'BAZ');
  static const TestAllTypesProto3_NestedEnum NEG =
      TestAllTypesProto3_NestedEnum._(-1, _omitEnumNames ? '' : 'NEG');

  static const $core.List<TestAllTypesProto3_NestedEnum> values =
      <TestAllTypesProto3_NestedEnum>[
    FOO,
    BAR,
    BAZ,
    NEG,
  ];

  static final $core.Map<$core.int, TestAllTypesProto3_NestedEnum> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static TestAllTypesProto3_NestedEnum? valueOf($core.int value) =>
      _byValue[value];

  const TestAllTypesProto3_NestedEnum._($core.int v, $core.String n)
      : super(v, n);
}

class TestAllTypesProto3_AliasedEnum extends $pb.ProtobufEnum {
  static const TestAllTypesProto3_AliasedEnum ALIAS_FOO =
      TestAllTypesProto3_AliasedEnum._(0, _omitEnumNames ? '' : 'ALIAS_FOO');
  static const TestAllTypesProto3_AliasedEnum ALIAS_BAR =
      TestAllTypesProto3_AliasedEnum._(1, _omitEnumNames ? '' : 'ALIAS_BAR');
  static const TestAllTypesProto3_AliasedEnum ALIAS_BAZ =
      TestAllTypesProto3_AliasedEnum._(2, _omitEnumNames ? '' : 'ALIAS_BAZ');

  static const TestAllTypesProto3_AliasedEnum MOO = ALIAS_BAZ;
  static const TestAllTypesProto3_AliasedEnum moo = ALIAS_BAZ;
  static const TestAllTypesProto3_AliasedEnum bAz = ALIAS_BAZ;

  static const $core.List<TestAllTypesProto3_AliasedEnum> values =
      <TestAllTypesProto3_AliasedEnum>[
    ALIAS_FOO,
    ALIAS_BAR,
    ALIAS_BAZ,
  ];

  static final $core.Map<$core.int, TestAllTypesProto3_AliasedEnum> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static TestAllTypesProto3_AliasedEnum? valueOf($core.int value) =>
      _byValue[value];

  const TestAllTypesProto3_AliasedEnum._($core.int v, $core.String n)
      : super(v, n);
}

class EnumOnlyProto3_Bool extends $pb.ProtobufEnum {
  static const EnumOnlyProto3_Bool kFalse =
      EnumOnlyProto3_Bool._(0, _omitEnumNames ? '' : 'kFalse');
  static const EnumOnlyProto3_Bool kTrue =
      EnumOnlyProto3_Bool._(1, _omitEnumNames ? '' : 'kTrue');

  static const $core.List<EnumOnlyProto3_Bool> values = <EnumOnlyProto3_Bool>[
    kFalse,
    kTrue,
  ];

  static final $core.Map<$core.int, EnumOnlyProto3_Bool> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static EnumOnlyProto3_Bool? valueOf($core.int value) => _byValue[value];

  const EnumOnlyProto3_Bool._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
