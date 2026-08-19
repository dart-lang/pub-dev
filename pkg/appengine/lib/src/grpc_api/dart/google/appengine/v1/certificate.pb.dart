//
//  Generated code. Do not modify.
//  source: google/appengine/v1/certificate.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../protobuf/timestamp.pb.dart' as $50;
import 'certificate.pbenum.dart';

export 'certificate.pbenum.dart';

/// An SSL certificate that a user has been authorized to administer. A user
/// is authorized to administer any certificate that applies to one of their
/// authorized domains.
class AuthorizedCertificate extends $pb.GeneratedMessage {
  factory AuthorizedCertificate({
    $core.String? name,
    $core.String? id,
    $core.String? displayName,
    $core.Iterable<$core.String>? domainNames,
    $50.Timestamp? expireTime,
    CertificateRawData? certificateRawData,
    ManagedCertificate? managedCertificate,
    $core.Iterable<$core.String>? visibleDomainMappings,
    $core.int? domainMappingsCount,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (id != null) {
      $result.id = id;
    }
    if (displayName != null) {
      $result.displayName = displayName;
    }
    if (domainNames != null) {
      $result.domainNames.addAll(domainNames);
    }
    if (expireTime != null) {
      $result.expireTime = expireTime;
    }
    if (certificateRawData != null) {
      $result.certificateRawData = certificateRawData;
    }
    if (managedCertificate != null) {
      $result.managedCertificate = managedCertificate;
    }
    if (visibleDomainMappings != null) {
      $result.visibleDomainMappings.addAll(visibleDomainMappings);
    }
    if (domainMappingsCount != null) {
      $result.domainMappingsCount = domainMappingsCount;
    }
    return $result;
  }
  AuthorizedCertificate._() : super();
  factory AuthorizedCertificate.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AuthorizedCertificate.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuthorizedCertificate',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.appengine.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'id')
    ..aOS(3, _omitFieldNames ? '' : 'displayName')
    ..pPS(4, _omitFieldNames ? '' : 'domainNames')
    ..aOM<$50.Timestamp>(5, _omitFieldNames ? '' : 'expireTime',
        subBuilder: $50.Timestamp.create)
    ..aOM<CertificateRawData>(6, _omitFieldNames ? '' : 'certificateRawData',
        subBuilder: CertificateRawData.create)
    ..aOM<ManagedCertificate>(7, _omitFieldNames ? '' : 'managedCertificate',
        subBuilder: ManagedCertificate.create)
    ..pPS(8, _omitFieldNames ? '' : 'visibleDomainMappings')
    ..a<$core.int>(
        9, _omitFieldNames ? '' : 'domainMappingsCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AuthorizedCertificate clone() =>
      AuthorizedCertificate()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AuthorizedCertificate copyWith(
          void Function(AuthorizedCertificate) updates) =>
      super.copyWith((message) => updates(message as AuthorizedCertificate))
          as AuthorizedCertificate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuthorizedCertificate create() => AuthorizedCertificate._();
  AuthorizedCertificate createEmptyInstance() => create();
  static $pb.PbList<AuthorizedCertificate> createRepeated() =>
      $pb.PbList<AuthorizedCertificate>();
  @$core.pragma('dart2js:noInline')
  static AuthorizedCertificate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AuthorizedCertificate>(create);
  static AuthorizedCertificate? _defaultInstance;

  ///  Full path to the `AuthorizedCertificate` resource in the API. Example:
  ///  `apps/myapp/authorizedCertificates/12345`.
  ///
  ///  @OutputOnly
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  ///  Relative name of the certificate. This is a unique value autogenerated
  ///  on `AuthorizedCertificate` resource creation. Example: `12345`.
  ///
  ///  @OutputOnly
  @$pb.TagNumber(2)
  $core.String get id => $_getSZ(1);
  @$pb.TagNumber(2)
  set id($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => clearField(2);

  /// The user-specified display name of the certificate. This is not
  /// guaranteed to be unique. Example: `My Certificate`.
  @$pb.TagNumber(3)
  $core.String get displayName => $_getSZ(2);
  @$pb.TagNumber(3)
  set displayName($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDisplayName() => $_has(2);
  @$pb.TagNumber(3)
  void clearDisplayName() => clearField(3);

  ///  Topmost applicable domains of this certificate. This certificate
  ///  applies to these domains and their subdomains. Example: `example.com`.
  ///
  ///  @OutputOnly
  @$pb.TagNumber(4)
  $core.List<$core.String> get domainNames => $_getList(3);

  ///  The time when this certificate expires. To update the renewal time on this
  ///  certificate, upload an SSL certificate with a different expiration time
  ///  using [`AuthorizedCertificates.UpdateAuthorizedCertificate`]().
  ///
  ///  @OutputOnly
  @$pb.TagNumber(5)
  $50.Timestamp get expireTime => $_getN(4);
  @$pb.TagNumber(5)
  set expireTime($50.Timestamp v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasExpireTime() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpireTime() => clearField(5);
  @$pb.TagNumber(5)
  $50.Timestamp ensureExpireTime() => $_ensure(4);

  /// The SSL certificate serving the `AuthorizedCertificate` resource. This
  /// must be obtained independently from a certificate authority.
  @$pb.TagNumber(6)
  CertificateRawData get certificateRawData => $_getN(5);
  @$pb.TagNumber(6)
  set certificateRawData(CertificateRawData v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasCertificateRawData() => $_has(5);
  @$pb.TagNumber(6)
  void clearCertificateRawData() => clearField(6);
  @$pb.TagNumber(6)
  CertificateRawData ensureCertificateRawData() => $_ensure(5);

  ///  Only applicable if this certificate is managed by App Engine. Managed
  ///  certificates are tied to the lifecycle of a `DomainMapping` and cannot be
  ///  updated or deleted via the `AuthorizedCertificates` API. If this
  ///  certificate is manually administered by the user, this field will be empty.
  ///
  ///  @OutputOnly
  @$pb.TagNumber(7)
  ManagedCertificate get managedCertificate => $_getN(6);
  @$pb.TagNumber(7)
  set managedCertificate(ManagedCertificate v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasManagedCertificate() => $_has(6);
  @$pb.TagNumber(7)
  void clearManagedCertificate() => clearField(7);
  @$pb.TagNumber(7)
  ManagedCertificate ensureManagedCertificate() => $_ensure(6);

  ///  The full paths to user visible Domain Mapping resources that have this
  ///  certificate mapped. Example: `apps/myapp/domainMappings/example.com`.
  ///
  ///  This may not represent the full list of mapped domain mappings if the user
  ///  does not have `VIEWER` permissions on all of the applications that have
  ///  this certificate mapped. See `domain_mappings_count` for a complete count.
  ///
  ///  Only returned by `GET` or `LIST` requests when specifically requested by
  ///  the `view=FULL_CERTIFICATE` option.
  ///
  ///  @OutputOnly
  @$pb.TagNumber(8)
  $core.List<$core.String> get visibleDomainMappings => $_getList(7);

  ///  Aggregate count of the domain mappings with this certificate mapped. This
  ///  count includes domain mappings on applications for which the user does not
  ///  have `VIEWER` permissions.
  ///
  ///  Only returned by `GET` or `LIST` requests when specifically requested by
  ///  the `view=FULL_CERTIFICATE` option.
  ///
  ///  @OutputOnly
  @$pb.TagNumber(9)
  $core.int get domainMappingsCount => $_getIZ(8);
  @$pb.TagNumber(9)
  set domainMappingsCount($core.int v) {
    $_setSignedInt32(8, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasDomainMappingsCount() => $_has(8);
  @$pb.TagNumber(9)
  void clearDomainMappingsCount() => clearField(9);
}

/// An SSL certificate obtained from a certificate authority.
class CertificateRawData extends $pb.GeneratedMessage {
  factory CertificateRawData({
    $core.String? publicCertificate,
    $core.String? privateKey,
  }) {
    final $result = create();
    if (publicCertificate != null) {
      $result.publicCertificate = publicCertificate;
    }
    if (privateKey != null) {
      $result.privateKey = privateKey;
    }
    return $result;
  }
  CertificateRawData._() : super();
  factory CertificateRawData.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory CertificateRawData.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CertificateRawData',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.appengine.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'publicCertificate')
    ..aOS(2, _omitFieldNames ? '' : 'privateKey')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  CertificateRawData clone() => CertificateRawData()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  CertificateRawData copyWith(void Function(CertificateRawData) updates) =>
      super.copyWith((message) => updates(message as CertificateRawData))
          as CertificateRawData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CertificateRawData create() => CertificateRawData._();
  CertificateRawData createEmptyInstance() => create();
  static $pb.PbList<CertificateRawData> createRepeated() =>
      $pb.PbList<CertificateRawData>();
  @$core.pragma('dart2js:noInline')
  static CertificateRawData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CertificateRawData>(create);
  static CertificateRawData? _defaultInstance;

  /// PEM encoded x.509 public key certificate. This field is set once on
  /// certificate creation. Must include the header and footer. Example:
  /// <pre>
  /// -----BEGIN CERTIFICATE-----
  /// <certificate_value>
  /// -----END CERTIFICATE-----
  /// </pre>
  @$pb.TagNumber(1)
  $core.String get publicCertificate => $_getSZ(0);
  @$pb.TagNumber(1)
  set publicCertificate($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasPublicCertificate() => $_has(0);
  @$pb.TagNumber(1)
  void clearPublicCertificate() => clearField(1);

  /// Unencrypted PEM encoded RSA private key. This field is set once on
  /// certificate creation and then encrypted. The key size must be 2048
  /// bits or fewer. Must include the header and footer. Example:
  /// <pre>
  /// -----BEGIN RSA PRIVATE KEY-----
  /// <unencrypted_key_value>
  /// -----END RSA PRIVATE KEY-----
  /// </pre>
  /// @InputOnly
  @$pb.TagNumber(2)
  $core.String get privateKey => $_getSZ(1);
  @$pb.TagNumber(2)
  set privateKey($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPrivateKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearPrivateKey() => clearField(2);
}

/// A certificate managed by App Engine.
class ManagedCertificate extends $pb.GeneratedMessage {
  factory ManagedCertificate({
    $50.Timestamp? lastRenewalTime,
    ManagementStatus? status,
  }) {
    final $result = create();
    if (lastRenewalTime != null) {
      $result.lastRenewalTime = lastRenewalTime;
    }
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  ManagedCertificate._() : super();
  factory ManagedCertificate.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory ManagedCertificate.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ManagedCertificate',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'google.appengine.v1'),
      createEmptyInstance: create)
    ..aOM<$50.Timestamp>(1, _omitFieldNames ? '' : 'lastRenewalTime',
        subBuilder: $50.Timestamp.create)
    ..e<ManagementStatus>(
        2, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE,
        defaultOrMaker: ManagementStatus.MANAGEMENT_STATUS_UNSPECIFIED,
        valueOf: ManagementStatus.valueOf,
        enumValues: ManagementStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  ManagedCertificate clone() => ManagedCertificate()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  ManagedCertificate copyWith(void Function(ManagedCertificate) updates) =>
      super.copyWith((message) => updates(message as ManagedCertificate))
          as ManagedCertificate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ManagedCertificate create() => ManagedCertificate._();
  ManagedCertificate createEmptyInstance() => create();
  static $pb.PbList<ManagedCertificate> createRepeated() =>
      $pb.PbList<ManagedCertificate>();
  @$core.pragma('dart2js:noInline')
  static ManagedCertificate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ManagedCertificate>(create);
  static ManagedCertificate? _defaultInstance;

  ///  Time at which the certificate was last renewed. The renewal process is
  ///  fully managed. Certificate renewal will automatically occur before the
  ///  certificate expires. Renewal errors can be tracked via `ManagementStatus`.
  ///
  ///  @OutputOnly
  @$pb.TagNumber(1)
  $50.Timestamp get lastRenewalTime => $_getN(0);
  @$pb.TagNumber(1)
  set lastRenewalTime($50.Timestamp v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasLastRenewalTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearLastRenewalTime() => clearField(1);
  @$pb.TagNumber(1)
  $50.Timestamp ensureLastRenewalTime() => $_ensure(0);

  ///  Status of certificate management. Refers to the most recent certificate
  ///  acquisition or renewal attempt.
  ///
  ///  @OutputOnly
  @$pb.TagNumber(2)
  ManagementStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(ManagementStatus v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => clearField(2);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
