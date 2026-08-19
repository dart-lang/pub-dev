//
//  Generated code. Do not modify.
//  source: google/appengine/v1beta/appengine.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Fields that should be returned when [Version][google.appengine.v1beta.Version] resources
/// are retrieved.
class VersionView extends $pb.ProtobufEnum {
  static const VersionView BASIC =
      VersionView._(0, _omitEnumNames ? '' : 'BASIC');
  static const VersionView FULL =
      VersionView._(1, _omitEnumNames ? '' : 'FULL');

  static const $core.List<VersionView> values = <VersionView>[
    BASIC,
    FULL,
  ];

  static final $core.Map<$core.int, VersionView> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static VersionView? valueOf($core.int value) => _byValue[value];

  const VersionView._($core.int v, $core.String n) : super(v, n);
}

/// Fields that should be returned when an AuthorizedCertificate resource is
/// retrieved.
class AuthorizedCertificateView extends $pb.ProtobufEnum {
  static const AuthorizedCertificateView BASIC_CERTIFICATE =
      AuthorizedCertificateView._(0, _omitEnumNames ? '' : 'BASIC_CERTIFICATE');
  static const AuthorizedCertificateView FULL_CERTIFICATE =
      AuthorizedCertificateView._(1, _omitEnumNames ? '' : 'FULL_CERTIFICATE');

  static const $core.List<AuthorizedCertificateView> values =
      <AuthorizedCertificateView>[
    BASIC_CERTIFICATE,
    FULL_CERTIFICATE,
  ];

  static final $core.Map<$core.int, AuthorizedCertificateView> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static AuthorizedCertificateView? valueOf($core.int value) => _byValue[value];

  const AuthorizedCertificateView._($core.int v, $core.String n) : super(v, n);
}

/// Override strategy for mutating an existing mapping.
class DomainOverrideStrategy extends $pb.ProtobufEnum {
  static const DomainOverrideStrategy UNSPECIFIED_DOMAIN_OVERRIDE_STRATEGY =
      DomainOverrideStrategy._(
          0, _omitEnumNames ? '' : 'UNSPECIFIED_DOMAIN_OVERRIDE_STRATEGY');
  static const DomainOverrideStrategy STRICT =
      DomainOverrideStrategy._(1, _omitEnumNames ? '' : 'STRICT');
  static const DomainOverrideStrategy OVERRIDE =
      DomainOverrideStrategy._(2, _omitEnumNames ? '' : 'OVERRIDE');

  static const $core.List<DomainOverrideStrategy> values =
      <DomainOverrideStrategy>[
    UNSPECIFIED_DOMAIN_OVERRIDE_STRATEGY,
    STRICT,
    OVERRIDE,
  ];

  static final $core.Map<$core.int, DomainOverrideStrategy> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static DomainOverrideStrategy? valueOf($core.int value) => _byValue[value];

  const DomainOverrideStrategy._($core.int v, $core.String n) : super(v, n);
}

const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
