//
//  Generated code. Do not modify.
//  source: google/iam/admin/v1/iam.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Supported key algorithms.
class ServiceAccountKeyAlgorithm extends $pb.ProtobufEnum {
  static const ServiceAccountKeyAlgorithm KEY_ALG_UNSPECIFIED =
      ServiceAccountKeyAlgorithm._(
          0, _omitEnumNames ? '' : 'KEY_ALG_UNSPECIFIED');
  static const ServiceAccountKeyAlgorithm KEY_ALG_RSA_1024 =
      ServiceAccountKeyAlgorithm._(1, _omitEnumNames ? '' : 'KEY_ALG_RSA_1024');
  static const ServiceAccountKeyAlgorithm KEY_ALG_RSA_2048 =
      ServiceAccountKeyAlgorithm._(2, _omitEnumNames ? '' : 'KEY_ALG_RSA_2048');

  static const $core.List<ServiceAccountKeyAlgorithm> values =
      <ServiceAccountKeyAlgorithm>[
    KEY_ALG_UNSPECIFIED,
    KEY_ALG_RSA_1024,
    KEY_ALG_RSA_2048,
  ];

  static final $core.Map<$core.int, ServiceAccountKeyAlgorithm> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static ServiceAccountKeyAlgorithm? valueOf($core.int value) =>
      _byValue[value];

  const ServiceAccountKeyAlgorithm._($core.int v, $core.String n) : super(v, n);
}

/// Supported private key output formats.
class ServiceAccountPrivateKeyType extends $pb.ProtobufEnum {
  static const ServiceAccountPrivateKeyType TYPE_UNSPECIFIED =
      ServiceAccountPrivateKeyType._(
          0, _omitEnumNames ? '' : 'TYPE_UNSPECIFIED');
  static const ServiceAccountPrivateKeyType TYPE_PKCS12_FILE =
      ServiceAccountPrivateKeyType._(
          1, _omitEnumNames ? '' : 'TYPE_PKCS12_FILE');
  static const ServiceAccountPrivateKeyType TYPE_GOOGLE_CREDENTIALS_FILE =
      ServiceAccountPrivateKeyType._(
          2, _omitEnumNames ? '' : 'TYPE_GOOGLE_CREDENTIALS_FILE');

  static const $core.List<ServiceAccountPrivateKeyType> values =
      <ServiceAccountPrivateKeyType>[
    TYPE_UNSPECIFIED,
    TYPE_PKCS12_FILE,
    TYPE_GOOGLE_CREDENTIALS_FILE,
  ];

  static final $core.Map<$core.int, ServiceAccountPrivateKeyType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static ServiceAccountPrivateKeyType? valueOf($core.int value) =>
      _byValue[value];

  const ServiceAccountPrivateKeyType._($core.int v, $core.String n)
      : super(v, n);
}

/// Supported public key output formats.
class ServiceAccountPublicKeyType extends $pb.ProtobufEnum {
  static const ServiceAccountPublicKeyType TYPE_NONE =
      ServiceAccountPublicKeyType._(0, _omitEnumNames ? '' : 'TYPE_NONE');
  static const ServiceAccountPublicKeyType TYPE_X509_PEM_FILE =
      ServiceAccountPublicKeyType._(
          1, _omitEnumNames ? '' : 'TYPE_X509_PEM_FILE');
  static const ServiceAccountPublicKeyType TYPE_RAW_PUBLIC_KEY =
      ServiceAccountPublicKeyType._(
          2, _omitEnumNames ? '' : 'TYPE_RAW_PUBLIC_KEY');

  static const $core.List<ServiceAccountPublicKeyType> values =
      <ServiceAccountPublicKeyType>[
    TYPE_NONE,
    TYPE_X509_PEM_FILE,
    TYPE_RAW_PUBLIC_KEY,
  ];

  static final $core.Map<$core.int, ServiceAccountPublicKeyType> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static ServiceAccountPublicKeyType? valueOf($core.int value) =>
      _byValue[value];

  const ServiceAccountPublicKeyType._($core.int v, $core.String n)
      : super(v, n);
}

/// Service Account Key Origin.
class ServiceAccountKeyOrigin extends $pb.ProtobufEnum {
  static const ServiceAccountKeyOrigin ORIGIN_UNSPECIFIED =
      ServiceAccountKeyOrigin._(0, _omitEnumNames ? '' : 'ORIGIN_UNSPECIFIED');
  static const ServiceAccountKeyOrigin USER_PROVIDED =
      ServiceAccountKeyOrigin._(1, _omitEnumNames ? '' : 'USER_PROVIDED');
  static const ServiceAccountKeyOrigin GOOGLE_PROVIDED =
      ServiceAccountKeyOrigin._(2, _omitEnumNames ? '' : 'GOOGLE_PROVIDED');

  static const $core.List<ServiceAccountKeyOrigin> values =
      <ServiceAccountKeyOrigin>[
    ORIGIN_UNSPECIFIED,
    USER_PROVIDED,
    GOOGLE_PROVIDED,
  ];

  static final $core.Map<$core.int, ServiceAccountKeyOrigin> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static ServiceAccountKeyOrigin? valueOf($core.int value) => _byValue[value];

  const ServiceAccountKeyOrigin._($core.int v, $core.String n) : super(v, n);
}

/// A view for Role objects.
class RoleView extends $pb.ProtobufEnum {
  static const RoleView BASIC = RoleView._(0, _omitEnumNames ? '' : 'BASIC');
  static const RoleView FULL = RoleView._(1, _omitEnumNames ? '' : 'FULL');

  static const $core.List<RoleView> values = <RoleView>[
    BASIC,
    FULL,
  ];

  static final $core.Map<$core.int, RoleView> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static RoleView? valueOf($core.int value) => _byValue[value];

  const RoleView._($core.int v, $core.String n) : super(v, n);
}

/// `KeyType` filters to selectively retrieve certain varieties
/// of keys.
class ListServiceAccountKeysRequest_KeyType extends $pb.ProtobufEnum {
  static const ListServiceAccountKeysRequest_KeyType KEY_TYPE_UNSPECIFIED =
      ListServiceAccountKeysRequest_KeyType._(
          0, _omitEnumNames ? '' : 'KEY_TYPE_UNSPECIFIED');
  static const ListServiceAccountKeysRequest_KeyType USER_MANAGED =
      ListServiceAccountKeysRequest_KeyType._(
          1, _omitEnumNames ? '' : 'USER_MANAGED');
  static const ListServiceAccountKeysRequest_KeyType SYSTEM_MANAGED =
      ListServiceAccountKeysRequest_KeyType._(
          2, _omitEnumNames ? '' : 'SYSTEM_MANAGED');

  static const $core.List<ListServiceAccountKeysRequest_KeyType> values =
      <ListServiceAccountKeysRequest_KeyType>[
    KEY_TYPE_UNSPECIFIED,
    USER_MANAGED,
    SYSTEM_MANAGED,
  ];

  static final $core.Map<$core.int, ListServiceAccountKeysRequest_KeyType>
      _byValue = $pb.ProtobufEnum.initByValue(values);
  static ListServiceAccountKeysRequest_KeyType? valueOf($core.int value) =>
      _byValue[value];

  const ListServiceAccountKeysRequest_KeyType._($core.int v, $core.String n)
      : super(v, n);
}

/// A stage representing a role's lifecycle phase.
class Role_RoleLaunchStage extends $pb.ProtobufEnum {
  static const Role_RoleLaunchStage ALPHA =
      Role_RoleLaunchStage._(0, _omitEnumNames ? '' : 'ALPHA');
  static const Role_RoleLaunchStage BETA =
      Role_RoleLaunchStage._(1, _omitEnumNames ? '' : 'BETA');
  static const Role_RoleLaunchStage GA =
      Role_RoleLaunchStage._(2, _omitEnumNames ? '' : 'GA');
  static const Role_RoleLaunchStage DEPRECATED =
      Role_RoleLaunchStage._(4, _omitEnumNames ? '' : 'DEPRECATED');
  static const Role_RoleLaunchStage DISABLED =
      Role_RoleLaunchStage._(5, _omitEnumNames ? '' : 'DISABLED');
  static const Role_RoleLaunchStage EAP =
      Role_RoleLaunchStage._(6, _omitEnumNames ? '' : 'EAP');

  static const $core.List<Role_RoleLaunchStage> values = <Role_RoleLaunchStage>[
    ALPHA,
    BETA,
    GA,
    DEPRECATED,
    DISABLED,
    EAP,
  ];

  static final $core.Map<$core.int, Role_RoleLaunchStage> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static Role_RoleLaunchStage? valueOf($core.int value) => _byValue[value];

  const Role_RoleLaunchStage._($core.int v, $core.String n) : super(v, n);
}

/// A stage representing a permission's lifecycle phase.
class Permission_PermissionLaunchStage extends $pb.ProtobufEnum {
  static const Permission_PermissionLaunchStage ALPHA =
      Permission_PermissionLaunchStage._(0, _omitEnumNames ? '' : 'ALPHA');
  static const Permission_PermissionLaunchStage BETA =
      Permission_PermissionLaunchStage._(1, _omitEnumNames ? '' : 'BETA');
  static const Permission_PermissionLaunchStage GA =
      Permission_PermissionLaunchStage._(2, _omitEnumNames ? '' : 'GA');
  static const Permission_PermissionLaunchStage DEPRECATED =
      Permission_PermissionLaunchStage._(3, _omitEnumNames ? '' : 'DEPRECATED');

  static const $core.List<Permission_PermissionLaunchStage> values =
      <Permission_PermissionLaunchStage>[
    ALPHA,
    BETA,
    GA,
    DEPRECATED,
  ];

  static final $core.Map<$core.int, Permission_PermissionLaunchStage> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static Permission_PermissionLaunchStage? valueOf($core.int value) =>
      _byValue[value];

  const Permission_PermissionLaunchStage._($core.int v, $core.String n)
      : super(v, n);
}

/// The state of the permission with regards to custom roles.
class Permission_CustomRolesSupportLevel extends $pb.ProtobufEnum {
  static const Permission_CustomRolesSupportLevel SUPPORTED =
      Permission_CustomRolesSupportLevel._(
          0, _omitEnumNames ? '' : 'SUPPORTED');
  static const Permission_CustomRolesSupportLevel TESTING =
      Permission_CustomRolesSupportLevel._(1, _omitEnumNames ? '' : 'TESTING');
  static const Permission_CustomRolesSupportLevel NOT_SUPPORTED =
      Permission_CustomRolesSupportLevel._(
          2, _omitEnumNames ? '' : 'NOT_SUPPORTED');

  static const $core.List<Permission_CustomRolesSupportLevel> values =
      <Permission_CustomRolesSupportLevel>[
    SUPPORTED,
    TESTING,
    NOT_SUPPORTED,
  ];

  static final $core.Map<$core.int, Permission_CustomRolesSupportLevel>
      _byValue = $pb.ProtobufEnum.initByValue(values);
  static Permission_CustomRolesSupportLevel? valueOf($core.int value) =>
      _byValue[value];

  const Permission_CustomRolesSupportLevel._($core.int v, $core.String n)
      : super(v, n);
}

/// Possible Level values of a validation unit corresponding to its domain
/// of discourse.
class LintResult_Level extends $pb.ProtobufEnum {
  static const LintResult_Level LEVEL_UNSPECIFIED =
      LintResult_Level._(0, _omitEnumNames ? '' : 'LEVEL_UNSPECIFIED');
  static const LintResult_Level CONDITION =
      LintResult_Level._(3, _omitEnumNames ? '' : 'CONDITION');

  static const $core.List<LintResult_Level> values = <LintResult_Level>[
    LEVEL_UNSPECIFIED,
    CONDITION,
  ];

  static final $core.Map<$core.int, LintResult_Level> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static LintResult_Level? valueOf($core.int value) => _byValue[value];

  const LintResult_Level._($core.int v, $core.String n) : super(v, n);
}

/// Possible Severity values of an issued result.
class LintResult_Severity extends $pb.ProtobufEnum {
  static const LintResult_Severity SEVERITY_UNSPECIFIED =
      LintResult_Severity._(0, _omitEnumNames ? '' : 'SEVERITY_UNSPECIFIED');
  static const LintResult_Severity ERROR =
      LintResult_Severity._(1, _omitEnumNames ? '' : 'ERROR');
  static const LintResult_Severity WARNING =
      LintResult_Severity._(2, _omitEnumNames ? '' : 'WARNING');
  static const LintResult_Severity NOTICE =
      LintResult_Severity._(3, _omitEnumNames ? '' : 'NOTICE');
  static const LintResult_Severity INFO =
      LintResult_Severity._(4, _omitEnumNames ? '' : 'INFO');
  static const LintResult_Severity DEPRECATED =
      LintResult_Severity._(5, _omitEnumNames ? '' : 'DEPRECATED');

  static const $core.List<LintResult_Severity> values = <LintResult_Severity>[
    SEVERITY_UNSPECIFIED,
    ERROR,
    WARNING,
    NOTICE,
    INFO,
    DEPRECATED,
  ];

  static final $core.Map<$core.int, LintResult_Severity> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static LintResult_Severity? valueOf($core.int value) => _byValue[value];

  const LintResult_Severity._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
