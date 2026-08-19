//
//  Generated code. Do not modify.
//  source: google/protobuf/descriptor.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// The full set of known editions.
class Edition extends $pb.ProtobufEnum {
  static const Edition EDITION_UNKNOWN =
      Edition._(0, _omitEnumNames ? '' : 'EDITION_UNKNOWN');
  static const Edition EDITION_LEGACY =
      Edition._(900, _omitEnumNames ? '' : 'EDITION_LEGACY');
  static const Edition EDITION_PROTO2 =
      Edition._(998, _omitEnumNames ? '' : 'EDITION_PROTO2');
  static const Edition EDITION_PROTO3 =
      Edition._(999, _omitEnumNames ? '' : 'EDITION_PROTO3');
  static const Edition EDITION_2023 =
      Edition._(1000, _omitEnumNames ? '' : 'EDITION_2023');
  static const Edition EDITION_2024 =
      Edition._(1001, _omitEnumNames ? '' : 'EDITION_2024');
  static const Edition EDITION_1_TEST_ONLY =
      Edition._(1, _omitEnumNames ? '' : 'EDITION_1_TEST_ONLY');
  static const Edition EDITION_2_TEST_ONLY =
      Edition._(2, _omitEnumNames ? '' : 'EDITION_2_TEST_ONLY');
  static const Edition EDITION_99997_TEST_ONLY =
      Edition._(99997, _omitEnumNames ? '' : 'EDITION_99997_TEST_ONLY');
  static const Edition EDITION_99998_TEST_ONLY =
      Edition._(99998, _omitEnumNames ? '' : 'EDITION_99998_TEST_ONLY');
  static const Edition EDITION_99999_TEST_ONLY =
      Edition._(99999, _omitEnumNames ? '' : 'EDITION_99999_TEST_ONLY');
  static const Edition EDITION_MAX =
      Edition._(2147483647, _omitEnumNames ? '' : 'EDITION_MAX');

  static const $core.List<Edition> values = <Edition>[
    EDITION_UNKNOWN,
    EDITION_LEGACY,
    EDITION_PROTO2,
    EDITION_PROTO3,
    EDITION_2023,
    EDITION_2024,
    EDITION_1_TEST_ONLY,
    EDITION_2_TEST_ONLY,
    EDITION_99997_TEST_ONLY,
    EDITION_99998_TEST_ONLY,
    EDITION_99999_TEST_ONLY,
    EDITION_MAX,
  ];

  static final $core.Map<$core.int, Edition> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static Edition? valueOf($core.int value) => _byValue[value];

  const Edition._($core.int v, $core.String n) : super(v, n);
}

/// The verification state of the extension range.
class ExtensionRangeOptions_VerificationState extends $pb.ProtobufEnum {
  static const ExtensionRangeOptions_VerificationState DECLARATION =
      ExtensionRangeOptions_VerificationState._(
          0, _omitEnumNames ? '' : 'DECLARATION');
  static const ExtensionRangeOptions_VerificationState UNVERIFIED =
      ExtensionRangeOptions_VerificationState._(
          1, _omitEnumNames ? '' : 'UNVERIFIED');

  static const $core.List<ExtensionRangeOptions_VerificationState> values =
      <ExtensionRangeOptions_VerificationState>[
    DECLARATION,
    UNVERIFIED,
  ];

  static final $core.Map<$core.int, ExtensionRangeOptions_VerificationState>
      _byValue = $pb.ProtobufEnum.initByValue(values);
  static ExtensionRangeOptions_VerificationState? valueOf($core.int value) =>
      _byValue[value];

  const ExtensionRangeOptions_VerificationState._($core.int v, $core.String n)
      : super(v, n);
}

class FieldDescriptorProto_Type extends $pb.ProtobufEnum {
  static const FieldDescriptorProto_Type TYPE_DOUBLE =
      FieldDescriptorProto_Type._(1, _omitEnumNames ? '' : 'TYPE_DOUBLE');
  static const FieldDescriptorProto_Type TYPE_FLOAT =
      FieldDescriptorProto_Type._(2, _omitEnumNames ? '' : 'TYPE_FLOAT');
  static const FieldDescriptorProto_Type TYPE_INT64 =
      FieldDescriptorProto_Type._(3, _omitEnumNames ? '' : 'TYPE_INT64');
  static const FieldDescriptorProto_Type TYPE_UINT64 =
      FieldDescriptorProto_Type._(4, _omitEnumNames ? '' : 'TYPE_UINT64');
  static const FieldDescriptorProto_Type TYPE_INT32 =
      FieldDescriptorProto_Type._(5, _omitEnumNames ? '' : 'TYPE_INT32');
  static const FieldDescriptorProto_Type TYPE_FIXED64 =
      FieldDescriptorProto_Type._(6, _omitEnumNames ? '' : 'TYPE_FIXED64');
  static const FieldDescriptorProto_Type TYPE_FIXED32 =
      FieldDescriptorProto_Type._(7, _omitEnumNames ? '' : 'TYPE_FIXED32');
  static const FieldDescriptorProto_Type TYPE_BOOL =
      FieldDescriptorProto_Type._(8, _omitEnumNames ? '' : 'TYPE_BOOL');
  static const FieldDescriptorProto_Type TYPE_STRING =
      FieldDescriptorProto_Type._(9, _omitEnumNames ? '' : 'TYPE_STRING');
  static const FieldDescriptorProto_Type TYPE_GROUP =
      FieldDescriptorProto_Type._(10, _omitEnumNames ? '' : 'TYPE_GROUP');
  static const FieldDescriptorProto_Type TYPE_MESSAGE =
      FieldDescriptorProto_Type._(11, _omitEnumNames ? '' : 'TYPE_MESSAGE');
  static const FieldDescriptorProto_Type TYPE_BYTES =
      FieldDescriptorProto_Type._(12, _omitEnumNames ? '' : 'TYPE_BYTES');
  static const FieldDescriptorProto_Type TYPE_UINT32 =
      FieldDescriptorProto_Type._(13, _omitEnumNames ? '' : 'TYPE_UINT32');
  static const FieldDescriptorProto_Type TYPE_ENUM =
      FieldDescriptorProto_Type._(14, _omitEnumNames ? '' : 'TYPE_ENUM');
  static const FieldDescriptorProto_Type TYPE_SFIXED32 =
      FieldDescriptorProto_Type._(15, _omitEnumNames ? '' : 'TYPE_SFIXED32');
  static const FieldDescriptorProto_Type TYPE_SFIXED64 =
      FieldDescriptorProto_Type._(16, _omitEnumNames ? '' : 'TYPE_SFIXED64');
  static const FieldDescriptorProto_Type TYPE_SINT32 =
      FieldDescriptorProto_Type._(17, _omitEnumNames ? '' : 'TYPE_SINT32');
  static const FieldDescriptorProto_Type TYPE_SINT64 =
      FieldDescriptorProto_Type._(18, _omitEnumNames ? '' : 'TYPE_SINT64');

  static const $core.List<FieldDescriptorProto_Type> values =
      <FieldDescriptorProto_Type>[
    TYPE_DOUBLE,
    TYPE_FLOAT,
    TYPE_INT64,
    TYPE_UINT64,
    TYPE_INT32,
    TYPE_FIXED64,
    TYPE_FIXED32,
    TYPE_BOOL,
    TYPE_STRING,
    TYPE_GROUP,
    TYPE_MESSAGE,
    TYPE_BYTES,
    TYPE_UINT32,
    TYPE_ENUM,
    TYPE_SFIXED32,
    TYPE_SFIXED64,
    TYPE_SINT32,
    TYPE_SINT64,
  ];

  static final $core.Map<$core.int, FieldDescriptorProto_Type> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static FieldDescriptorProto_Type? valueOf($core.int value) => _byValue[value];

  const FieldDescriptorProto_Type._($core.int v, $core.String n) : super(v, n);
}

class FieldDescriptorProto_Label extends $pb.ProtobufEnum {
  static const FieldDescriptorProto_Label LABEL_OPTIONAL =
      FieldDescriptorProto_Label._(1, _omitEnumNames ? '' : 'LABEL_OPTIONAL');
  static const FieldDescriptorProto_Label LABEL_REPEATED =
      FieldDescriptorProto_Label._(3, _omitEnumNames ? '' : 'LABEL_REPEATED');
  static const FieldDescriptorProto_Label LABEL_REQUIRED =
      FieldDescriptorProto_Label._(2, _omitEnumNames ? '' : 'LABEL_REQUIRED');

  static const $core.List<FieldDescriptorProto_Label> values =
      <FieldDescriptorProto_Label>[
    LABEL_OPTIONAL,
    LABEL_REPEATED,
    LABEL_REQUIRED,
  ];

  static final $core.Map<$core.int, FieldDescriptorProto_Label> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static FieldDescriptorProto_Label? valueOf($core.int value) =>
      _byValue[value];

  const FieldDescriptorProto_Label._($core.int v, $core.String n) : super(v, n);
}

/// Generated classes can be optimized for speed or code size.
class FileOptions_OptimizeMode extends $pb.ProtobufEnum {
  static const FileOptions_OptimizeMode SPEED =
      FileOptions_OptimizeMode._(1, _omitEnumNames ? '' : 'SPEED');
  static const FileOptions_OptimizeMode CODE_SIZE =
      FileOptions_OptimizeMode._(2, _omitEnumNames ? '' : 'CODE_SIZE');
  static const FileOptions_OptimizeMode LITE_RUNTIME =
      FileOptions_OptimizeMode._(3, _omitEnumNames ? '' : 'LITE_RUNTIME');

  static const $core.List<FileOptions_OptimizeMode> values =
      <FileOptions_OptimizeMode>[
    SPEED,
    CODE_SIZE,
    LITE_RUNTIME,
  ];

  static final $core.Map<$core.int, FileOptions_OptimizeMode> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static FileOptions_OptimizeMode? valueOf($core.int value) => _byValue[value];

  const FileOptions_OptimizeMode._($core.int v, $core.String n) : super(v, n);
}

class FieldOptions_CType extends $pb.ProtobufEnum {
  static const FieldOptions_CType STRING =
      FieldOptions_CType._(0, _omitEnumNames ? '' : 'STRING');
  static const FieldOptions_CType CORD =
      FieldOptions_CType._(1, _omitEnumNames ? '' : 'CORD');
  static const FieldOptions_CType STRING_PIECE =
      FieldOptions_CType._(2, _omitEnumNames ? '' : 'STRING_PIECE');

  static const $core.List<FieldOptions_CType> values = <FieldOptions_CType>[
    STRING,
    CORD,
    STRING_PIECE,
  ];

  static final $core.Map<$core.int, FieldOptions_CType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static FieldOptions_CType? valueOf($core.int value) => _byValue[value];

  const FieldOptions_CType._($core.int v, $core.String n) : super(v, n);
}

class FieldOptions_JSType extends $pb.ProtobufEnum {
  static const FieldOptions_JSType JS_NORMAL =
      FieldOptions_JSType._(0, _omitEnumNames ? '' : 'JS_NORMAL');
  static const FieldOptions_JSType JS_STRING =
      FieldOptions_JSType._(1, _omitEnumNames ? '' : 'JS_STRING');
  static const FieldOptions_JSType JS_NUMBER =
      FieldOptions_JSType._(2, _omitEnumNames ? '' : 'JS_NUMBER');

  static const $core.List<FieldOptions_JSType> values = <FieldOptions_JSType>[
    JS_NORMAL,
    JS_STRING,
    JS_NUMBER,
  ];

  static final $core.Map<$core.int, FieldOptions_JSType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static FieldOptions_JSType? valueOf($core.int value) => _byValue[value];

  const FieldOptions_JSType._($core.int v, $core.String n) : super(v, n);
}

/// If set to RETENTION_SOURCE, the option will be omitted from the binary.
/// Note: as of January 2023, support for this is in progress and does not yet
/// have an effect (b/264593489).
class FieldOptions_OptionRetention extends $pb.ProtobufEnum {
  static const FieldOptions_OptionRetention RETENTION_UNKNOWN =
      FieldOptions_OptionRetention._(
          0, _omitEnumNames ? '' : 'RETENTION_UNKNOWN');
  static const FieldOptions_OptionRetention RETENTION_RUNTIME =
      FieldOptions_OptionRetention._(
          1, _omitEnumNames ? '' : 'RETENTION_RUNTIME');
  static const FieldOptions_OptionRetention RETENTION_SOURCE =
      FieldOptions_OptionRetention._(
          2, _omitEnumNames ? '' : 'RETENTION_SOURCE');

  static const $core.List<FieldOptions_OptionRetention> values =
      <FieldOptions_OptionRetention>[
    RETENTION_UNKNOWN,
    RETENTION_RUNTIME,
    RETENTION_SOURCE,
  ];

  static final $core.Map<$core.int, FieldOptions_OptionRetention> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static FieldOptions_OptionRetention? valueOf($core.int value) =>
      _byValue[value];

  const FieldOptions_OptionRetention._($core.int v, $core.String n)
      : super(v, n);
}

/// This indicates the types of entities that the field may apply to when used
/// as an option. If it is unset, then the field may be freely used as an
/// option on any kind of entity. Note: as of January 2023, support for this is
/// in progress and does not yet have an effect (b/264593489).
class FieldOptions_OptionTargetType extends $pb.ProtobufEnum {
  static const FieldOptions_OptionTargetType TARGET_TYPE_UNKNOWN =
      FieldOptions_OptionTargetType._(
          0, _omitEnumNames ? '' : 'TARGET_TYPE_UNKNOWN');
  static const FieldOptions_OptionTargetType TARGET_TYPE_FILE =
      FieldOptions_OptionTargetType._(
          1, _omitEnumNames ? '' : 'TARGET_TYPE_FILE');
  static const FieldOptions_OptionTargetType TARGET_TYPE_EXTENSION_RANGE =
      FieldOptions_OptionTargetType._(
          2, _omitEnumNames ? '' : 'TARGET_TYPE_EXTENSION_RANGE');
  static const FieldOptions_OptionTargetType TARGET_TYPE_MESSAGE =
      FieldOptions_OptionTargetType._(
          3, _omitEnumNames ? '' : 'TARGET_TYPE_MESSAGE');
  static const FieldOptions_OptionTargetType TARGET_TYPE_FIELD =
      FieldOptions_OptionTargetType._(
          4, _omitEnumNames ? '' : 'TARGET_TYPE_FIELD');
  static const FieldOptions_OptionTargetType TARGET_TYPE_ONEOF =
      FieldOptions_OptionTargetType._(
          5, _omitEnumNames ? '' : 'TARGET_TYPE_ONEOF');
  static const FieldOptions_OptionTargetType TARGET_TYPE_ENUM =
      FieldOptions_OptionTargetType._(
          6, _omitEnumNames ? '' : 'TARGET_TYPE_ENUM');
  static const FieldOptions_OptionTargetType TARGET_TYPE_ENUM_ENTRY =
      FieldOptions_OptionTargetType._(
          7, _omitEnumNames ? '' : 'TARGET_TYPE_ENUM_ENTRY');
  static const FieldOptions_OptionTargetType TARGET_TYPE_SERVICE =
      FieldOptions_OptionTargetType._(
          8, _omitEnumNames ? '' : 'TARGET_TYPE_SERVICE');
  static const FieldOptions_OptionTargetType TARGET_TYPE_METHOD =
      FieldOptions_OptionTargetType._(
          9, _omitEnumNames ? '' : 'TARGET_TYPE_METHOD');

  static const $core.List<FieldOptions_OptionTargetType> values =
      <FieldOptions_OptionTargetType>[
    TARGET_TYPE_UNKNOWN,
    TARGET_TYPE_FILE,
    TARGET_TYPE_EXTENSION_RANGE,
    TARGET_TYPE_MESSAGE,
    TARGET_TYPE_FIELD,
    TARGET_TYPE_ONEOF,
    TARGET_TYPE_ENUM,
    TARGET_TYPE_ENUM_ENTRY,
    TARGET_TYPE_SERVICE,
    TARGET_TYPE_METHOD,
  ];

  static final $core.Map<$core.int, FieldOptions_OptionTargetType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static FieldOptions_OptionTargetType? valueOf($core.int value) =>
      _byValue[value];

  const FieldOptions_OptionTargetType._($core.int v, $core.String n)
      : super(v, n);
}

/// Is this method side-effect-free (or safe in HTTP parlance), or idempotent,
/// or neither? HTTP based RPC implementation may choose GET verb for safe
/// methods, and PUT verb for idempotent methods instead of the default POST.
class MethodOptions_IdempotencyLevel extends $pb.ProtobufEnum {
  static const MethodOptions_IdempotencyLevel IDEMPOTENCY_UNKNOWN =
      MethodOptions_IdempotencyLevel._(
          0, _omitEnumNames ? '' : 'IDEMPOTENCY_UNKNOWN');
  static const MethodOptions_IdempotencyLevel NO_SIDE_EFFECTS =
      MethodOptions_IdempotencyLevel._(
          1, _omitEnumNames ? '' : 'NO_SIDE_EFFECTS');
  static const MethodOptions_IdempotencyLevel IDEMPOTENT =
      MethodOptions_IdempotencyLevel._(2, _omitEnumNames ? '' : 'IDEMPOTENT');

  static const $core.List<MethodOptions_IdempotencyLevel> values =
      <MethodOptions_IdempotencyLevel>[
    IDEMPOTENCY_UNKNOWN,
    NO_SIDE_EFFECTS,
    IDEMPOTENT,
  ];

  static final $core.Map<$core.int, MethodOptions_IdempotencyLevel> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static MethodOptions_IdempotencyLevel? valueOf($core.int value) =>
      _byValue[value];

  const MethodOptions_IdempotencyLevel._($core.int v, $core.String n)
      : super(v, n);
}

class FeatureSet_FieldPresence extends $pb.ProtobufEnum {
  static const FeatureSet_FieldPresence FIELD_PRESENCE_UNKNOWN =
      FeatureSet_FieldPresence._(
          0, _omitEnumNames ? '' : 'FIELD_PRESENCE_UNKNOWN');
  static const FeatureSet_FieldPresence EXPLICIT =
      FeatureSet_FieldPresence._(1, _omitEnumNames ? '' : 'EXPLICIT');
  static const FeatureSet_FieldPresence IMPLICIT =
      FeatureSet_FieldPresence._(2, _omitEnumNames ? '' : 'IMPLICIT');
  static const FeatureSet_FieldPresence LEGACY_REQUIRED =
      FeatureSet_FieldPresence._(3, _omitEnumNames ? '' : 'LEGACY_REQUIRED');

  static const $core.List<FeatureSet_FieldPresence> values =
      <FeatureSet_FieldPresence>[
    FIELD_PRESENCE_UNKNOWN,
    EXPLICIT,
    IMPLICIT,
    LEGACY_REQUIRED,
  ];

  static final $core.Map<$core.int, FeatureSet_FieldPresence> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static FeatureSet_FieldPresence? valueOf($core.int value) => _byValue[value];

  const FeatureSet_FieldPresence._($core.int v, $core.String n) : super(v, n);
}

class FeatureSet_EnumType extends $pb.ProtobufEnum {
  static const FeatureSet_EnumType ENUM_TYPE_UNKNOWN =
      FeatureSet_EnumType._(0, _omitEnumNames ? '' : 'ENUM_TYPE_UNKNOWN');
  static const FeatureSet_EnumType OPEN =
      FeatureSet_EnumType._(1, _omitEnumNames ? '' : 'OPEN');
  static const FeatureSet_EnumType CLOSED =
      FeatureSet_EnumType._(2, _omitEnumNames ? '' : 'CLOSED');

  static const $core.List<FeatureSet_EnumType> values = <FeatureSet_EnumType>[
    ENUM_TYPE_UNKNOWN,
    OPEN,
    CLOSED,
  ];

  static final $core.Map<$core.int, FeatureSet_EnumType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static FeatureSet_EnumType? valueOf($core.int value) => _byValue[value];

  const FeatureSet_EnumType._($core.int v, $core.String n) : super(v, n);
}

class FeatureSet_RepeatedFieldEncoding extends $pb.ProtobufEnum {
  static const FeatureSet_RepeatedFieldEncoding
      REPEATED_FIELD_ENCODING_UNKNOWN = FeatureSet_RepeatedFieldEncoding._(
          0, _omitEnumNames ? '' : 'REPEATED_FIELD_ENCODING_UNKNOWN');
  static const FeatureSet_RepeatedFieldEncoding PACKED =
      FeatureSet_RepeatedFieldEncoding._(1, _omitEnumNames ? '' : 'PACKED');
  static const FeatureSet_RepeatedFieldEncoding EXPANDED =
      FeatureSet_RepeatedFieldEncoding._(2, _omitEnumNames ? '' : 'EXPANDED');

  static const $core.List<FeatureSet_RepeatedFieldEncoding> values =
      <FeatureSet_RepeatedFieldEncoding>[
    REPEATED_FIELD_ENCODING_UNKNOWN,
    PACKED,
    EXPANDED,
  ];

  static final $core.Map<$core.int, FeatureSet_RepeatedFieldEncoding> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static FeatureSet_RepeatedFieldEncoding? valueOf($core.int value) =>
      _byValue[value];

  const FeatureSet_RepeatedFieldEncoding._($core.int v, $core.String n)
      : super(v, n);
}

class FeatureSet_Utf8Validation extends $pb.ProtobufEnum {
  static const FeatureSet_Utf8Validation UTF8_VALIDATION_UNKNOWN =
      FeatureSet_Utf8Validation._(
          0, _omitEnumNames ? '' : 'UTF8_VALIDATION_UNKNOWN');
  static const FeatureSet_Utf8Validation VERIFY =
      FeatureSet_Utf8Validation._(2, _omitEnumNames ? '' : 'VERIFY');
  static const FeatureSet_Utf8Validation NONE =
      FeatureSet_Utf8Validation._(3, _omitEnumNames ? '' : 'NONE');

  static const $core.List<FeatureSet_Utf8Validation> values =
      <FeatureSet_Utf8Validation>[
    UTF8_VALIDATION_UNKNOWN,
    VERIFY,
    NONE,
  ];

  static final $core.Map<$core.int, FeatureSet_Utf8Validation> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static FeatureSet_Utf8Validation? valueOf($core.int value) => _byValue[value];

  const FeatureSet_Utf8Validation._($core.int v, $core.String n) : super(v, n);
}

class FeatureSet_MessageEncoding extends $pb.ProtobufEnum {
  static const FeatureSet_MessageEncoding MESSAGE_ENCODING_UNKNOWN =
      FeatureSet_MessageEncoding._(
          0, _omitEnumNames ? '' : 'MESSAGE_ENCODING_UNKNOWN');
  static const FeatureSet_MessageEncoding LENGTH_PREFIXED =
      FeatureSet_MessageEncoding._(1, _omitEnumNames ? '' : 'LENGTH_PREFIXED');
  static const FeatureSet_MessageEncoding DELIMITED =
      FeatureSet_MessageEncoding._(2, _omitEnumNames ? '' : 'DELIMITED');

  static const $core.List<FeatureSet_MessageEncoding> values =
      <FeatureSet_MessageEncoding>[
    MESSAGE_ENCODING_UNKNOWN,
    LENGTH_PREFIXED,
    DELIMITED,
  ];

  static final $core.Map<$core.int, FeatureSet_MessageEncoding> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static FeatureSet_MessageEncoding? valueOf($core.int value) =>
      _byValue[value];

  const FeatureSet_MessageEncoding._($core.int v, $core.String n) : super(v, n);
}

class FeatureSet_JsonFormat extends $pb.ProtobufEnum {
  static const FeatureSet_JsonFormat JSON_FORMAT_UNKNOWN =
      FeatureSet_JsonFormat._(0, _omitEnumNames ? '' : 'JSON_FORMAT_UNKNOWN');
  static const FeatureSet_JsonFormat ALLOW =
      FeatureSet_JsonFormat._(1, _omitEnumNames ? '' : 'ALLOW');
  static const FeatureSet_JsonFormat LEGACY_BEST_EFFORT =
      FeatureSet_JsonFormat._(2, _omitEnumNames ? '' : 'LEGACY_BEST_EFFORT');

  static const $core.List<FeatureSet_JsonFormat> values =
      <FeatureSet_JsonFormat>[
    JSON_FORMAT_UNKNOWN,
    ALLOW,
    LEGACY_BEST_EFFORT,
  ];

  static final $core.Map<$core.int, FeatureSet_JsonFormat> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static FeatureSet_JsonFormat? valueOf($core.int value) => _byValue[value];

  const FeatureSet_JsonFormat._($core.int v, $core.String n) : super(v, n);
}

/// Represents the identified object's effect on the element in the original
/// .proto file.
class GeneratedCodeInfo_Annotation_Semantic extends $pb.ProtobufEnum {
  static const GeneratedCodeInfo_Annotation_Semantic NONE =
      GeneratedCodeInfo_Annotation_Semantic._(0, _omitEnumNames ? '' : 'NONE');
  static const GeneratedCodeInfo_Annotation_Semantic SET =
      GeneratedCodeInfo_Annotation_Semantic._(1, _omitEnumNames ? '' : 'SET');
  static const GeneratedCodeInfo_Annotation_Semantic ALIAS =
      GeneratedCodeInfo_Annotation_Semantic._(2, _omitEnumNames ? '' : 'ALIAS');

  static const $core.List<GeneratedCodeInfo_Annotation_Semantic> values =
      <GeneratedCodeInfo_Annotation_Semantic>[
    NONE,
    SET,
    ALIAS,
  ];

  static final $core.Map<$core.int, GeneratedCodeInfo_Annotation_Semantic>
      _byValue = $pb.ProtobufEnum.initByValue(values);
  static GeneratedCodeInfo_Annotation_Semantic? valueOf($core.int value) =>
      _byValue[value];

  const GeneratedCodeInfo_Annotation_Semantic._($core.int v, $core.String n)
      : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
