//
//  Generated code. Do not modify.
//  source: google/iam/credentials/v1/common.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../../protobuf/duration.pb.dart' as $51;
import '../../../protobuf/timestamp.pb.dart' as $50;

class GenerateAccessTokenRequest extends $pb.GeneratedMessage {
  factory GenerateAccessTokenRequest({
    $core.String? name,
    $core.Iterable<$core.String>? delegates,
    $core.Iterable<$core.String>? scope,
    $51.Duration? lifetime,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (delegates != null) {
      $result.delegates.addAll(delegates);
    }
    if (scope != null) {
      $result.scope.addAll(scope);
    }
    if (lifetime != null) {
      $result.lifetime = lifetime;
    }
    return $result;
  }
  GenerateAccessTokenRequest._() : super();
  factory GenerateAccessTokenRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GenerateAccessTokenRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GenerateAccessTokenRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.iam.credentials.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..pPS(2, _omitFieldNames ? '' : 'delegates')
    ..pPS(4, _omitFieldNames ? '' : 'scope')
    ..aOM<$51.Duration>(7, _omitFieldNames ? '' : 'lifetime',
        subBuilder: $51.Duration.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GenerateAccessTokenRequest clone() =>
      GenerateAccessTokenRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GenerateAccessTokenRequest copyWith(
          void Function(GenerateAccessTokenRequest) updates) =>
      super.copyWith(
              (message) => updates(message as GenerateAccessTokenRequest))
          as GenerateAccessTokenRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateAccessTokenRequest create() => GenerateAccessTokenRequest._();
  GenerateAccessTokenRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateAccessTokenRequest> createRepeated() =>
      $pb.PbList<GenerateAccessTokenRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateAccessTokenRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GenerateAccessTokenRequest>(create);
  static GenerateAccessTokenRequest? _defaultInstance;

  /// Required. The resource name of the service account for which the credentials
  /// are requested, in the following format:
  /// `projects/-/serviceAccounts/{ACCOUNT_EMAIL_OR_UNIQUEID}`. The `-` wildcard
  /// character is required; replacing it with a project ID is invalid.
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

  ///  The sequence of service accounts in a delegation chain. Each service
  ///  account must be granted the `roles/iam.serviceAccountTokenCreator` role
  ///  on its next service account in the chain. The last service account in the
  ///  chain must be granted the `roles/iam.serviceAccountTokenCreator` role
  ///  on the service account that is specified in the `name` field of the
  ///  request.
  ///
  ///  The delegates must have the following format:
  ///  `projects/-/serviceAccounts/{ACCOUNT_EMAIL_OR_UNIQUEID}`. The `-` wildcard
  ///  character is required; replacing it with a project ID is invalid.
  @$pb.TagNumber(2)
  $core.List<$core.String> get delegates => $_getList(1);

  /// Required. Code to identify the scopes to be included in the OAuth 2.0 access token.
  /// See https://developers.google.com/identity/protocols/googlescopes for more
  /// information.
  /// At least one value required.
  @$pb.TagNumber(4)
  $core.List<$core.String> get scope => $_getList(2);

  /// The desired lifetime duration of the access token in seconds.
  /// Must be set to a value less than or equal to 3600 (1 hour). If a value is
  /// not specified, the token's lifetime will be set to a default value of one
  /// hour.
  @$pb.TagNumber(7)
  $51.Duration get lifetime => $_getN(3);
  @$pb.TagNumber(7)
  set lifetime($51.Duration v) {
    setField(7, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasLifetime() => $_has(3);
  @$pb.TagNumber(7)
  void clearLifetime() => clearField(7);
  @$pb.TagNumber(7)
  $51.Duration ensureLifetime() => $_ensure(3);
}

class GenerateAccessTokenResponse extends $pb.GeneratedMessage {
  factory GenerateAccessTokenResponse({
    $core.String? accessToken,
    $50.Timestamp? expireTime,
  }) {
    final $result = create();
    if (accessToken != null) {
      $result.accessToken = accessToken;
    }
    if (expireTime != null) {
      $result.expireTime = expireTime;
    }
    return $result;
  }
  GenerateAccessTokenResponse._() : super();
  factory GenerateAccessTokenResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GenerateAccessTokenResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GenerateAccessTokenResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.iam.credentials.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'accessToken')
    ..aOM<$50.Timestamp>(3, _omitFieldNames ? '' : 'expireTime',
        subBuilder: $50.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GenerateAccessTokenResponse clone() =>
      GenerateAccessTokenResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GenerateAccessTokenResponse copyWith(
          void Function(GenerateAccessTokenResponse) updates) =>
      super.copyWith(
              (message) => updates(message as GenerateAccessTokenResponse))
          as GenerateAccessTokenResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateAccessTokenResponse create() =>
      GenerateAccessTokenResponse._();
  GenerateAccessTokenResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateAccessTokenResponse> createRepeated() =>
      $pb.PbList<GenerateAccessTokenResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateAccessTokenResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GenerateAccessTokenResponse>(create);
  static GenerateAccessTokenResponse? _defaultInstance;

  /// The OAuth 2.0 access token.
  @$pb.TagNumber(1)
  $core.String get accessToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set accessToken($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasAccessToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccessToken() => clearField(1);

  /// Token expiration time.
  /// The expiration time is always set.
  @$pb.TagNumber(3)
  $50.Timestamp get expireTime => $_getN(1);
  @$pb.TagNumber(3)
  set expireTime($50.Timestamp v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasExpireTime() => $_has(1);
  @$pb.TagNumber(3)
  void clearExpireTime() => clearField(3);
  @$pb.TagNumber(3)
  $50.Timestamp ensureExpireTime() => $_ensure(1);
}

class SignBlobRequest extends $pb.GeneratedMessage {
  factory SignBlobRequest({
    $core.String? name,
    $core.Iterable<$core.String>? delegates,
    $core.List<$core.int>? payload,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (delegates != null) {
      $result.delegates.addAll(delegates);
    }
    if (payload != null) {
      $result.payload = payload;
    }
    return $result;
  }
  SignBlobRequest._() : super();
  factory SignBlobRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SignBlobRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignBlobRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.iam.credentials.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..pPS(3, _omitFieldNames ? '' : 'delegates')
    ..a<$core.List<$core.int>>(
        5, _omitFieldNames ? '' : 'payload', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SignBlobRequest clone() => SignBlobRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SignBlobRequest copyWith(void Function(SignBlobRequest) updates) =>
      super.copyWith((message) => updates(message as SignBlobRequest))
          as SignBlobRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignBlobRequest create() => SignBlobRequest._();
  SignBlobRequest createEmptyInstance() => create();
  static $pb.PbList<SignBlobRequest> createRepeated() =>
      $pb.PbList<SignBlobRequest>();
  @$core.pragma('dart2js:noInline')
  static SignBlobRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SignBlobRequest>(create);
  static SignBlobRequest? _defaultInstance;

  /// Required. The resource name of the service account for which the credentials
  /// are requested, in the following format:
  /// `projects/-/serviceAccounts/{ACCOUNT_EMAIL_OR_UNIQUEID}`. The `-` wildcard
  /// character is required; replacing it with a project ID is invalid.
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

  ///  The sequence of service accounts in a delegation chain. Each service
  ///  account must be granted the `roles/iam.serviceAccountTokenCreator` role
  ///  on its next service account in the chain. The last service account in the
  ///  chain must be granted the `roles/iam.serviceAccountTokenCreator` role
  ///  on the service account that is specified in the `name` field of the
  ///  request.
  ///
  ///  The delegates must have the following format:
  ///  `projects/-/serviceAccounts/{ACCOUNT_EMAIL_OR_UNIQUEID}`. The `-` wildcard
  ///  character is required; replacing it with a project ID is invalid.
  @$pb.TagNumber(3)
  $core.List<$core.String> get delegates => $_getList(1);

  /// Required. The bytes to sign.
  @$pb.TagNumber(5)
  $core.List<$core.int> get payload => $_getN(2);
  @$pb.TagNumber(5)
  set payload($core.List<$core.int> v) {
    $_setBytes(2, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasPayload() => $_has(2);
  @$pb.TagNumber(5)
  void clearPayload() => clearField(5);
}

class SignBlobResponse extends $pb.GeneratedMessage {
  factory SignBlobResponse({
    $core.String? keyId,
    $core.List<$core.int>? signedBlob,
  }) {
    final $result = create();
    if (keyId != null) {
      $result.keyId = keyId;
    }
    if (signedBlob != null) {
      $result.signedBlob = signedBlob;
    }
    return $result;
  }
  SignBlobResponse._() : super();
  factory SignBlobResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SignBlobResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignBlobResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.iam.credentials.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'keyId')
    ..a<$core.List<$core.int>>(
        4, _omitFieldNames ? '' : 'signedBlob', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SignBlobResponse clone() => SignBlobResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SignBlobResponse copyWith(void Function(SignBlobResponse) updates) =>
      super.copyWith((message) => updates(message as SignBlobResponse))
          as SignBlobResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignBlobResponse create() => SignBlobResponse._();
  SignBlobResponse createEmptyInstance() => create();
  static $pb.PbList<SignBlobResponse> createRepeated() =>
      $pb.PbList<SignBlobResponse>();
  @$core.pragma('dart2js:noInline')
  static SignBlobResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SignBlobResponse>(create);
  static SignBlobResponse? _defaultInstance;

  /// The ID of the key used to sign the blob.
  @$pb.TagNumber(1)
  $core.String get keyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set keyId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasKeyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearKeyId() => clearField(1);

  /// The signed blob.
  @$pb.TagNumber(4)
  $core.List<$core.int> get signedBlob => $_getN(1);
  @$pb.TagNumber(4)
  set signedBlob($core.List<$core.int> v) {
    $_setBytes(1, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasSignedBlob() => $_has(1);
  @$pb.TagNumber(4)
  void clearSignedBlob() => clearField(4);
}

class SignJwtRequest extends $pb.GeneratedMessage {
  factory SignJwtRequest({
    $core.String? name,
    $core.Iterable<$core.String>? delegates,
    $core.String? payload,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (delegates != null) {
      $result.delegates.addAll(delegates);
    }
    if (payload != null) {
      $result.payload = payload;
    }
    return $result;
  }
  SignJwtRequest._() : super();
  factory SignJwtRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SignJwtRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignJwtRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.iam.credentials.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..pPS(3, _omitFieldNames ? '' : 'delegates')
    ..aOS(5, _omitFieldNames ? '' : 'payload')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SignJwtRequest clone() => SignJwtRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SignJwtRequest copyWith(void Function(SignJwtRequest) updates) =>
      super.copyWith((message) => updates(message as SignJwtRequest))
          as SignJwtRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignJwtRequest create() => SignJwtRequest._();
  SignJwtRequest createEmptyInstance() => create();
  static $pb.PbList<SignJwtRequest> createRepeated() =>
      $pb.PbList<SignJwtRequest>();
  @$core.pragma('dart2js:noInline')
  static SignJwtRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SignJwtRequest>(create);
  static SignJwtRequest? _defaultInstance;

  /// Required. The resource name of the service account for which the credentials
  /// are requested, in the following format:
  /// `projects/-/serviceAccounts/{ACCOUNT_EMAIL_OR_UNIQUEID}`. The `-` wildcard
  /// character is required; replacing it with a project ID is invalid.
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

  ///  The sequence of service accounts in a delegation chain. Each service
  ///  account must be granted the `roles/iam.serviceAccountTokenCreator` role
  ///  on its next service account in the chain. The last service account in the
  ///  chain must be granted the `roles/iam.serviceAccountTokenCreator` role
  ///  on the service account that is specified in the `name` field of the
  ///  request.
  ///
  ///  The delegates must have the following format:
  ///  `projects/-/serviceAccounts/{ACCOUNT_EMAIL_OR_UNIQUEID}`. The `-` wildcard
  ///  character is required; replacing it with a project ID is invalid.
  @$pb.TagNumber(3)
  $core.List<$core.String> get delegates => $_getList(1);

  /// Required. The JWT payload to sign: a JSON object that contains a JWT Claims Set.
  @$pb.TagNumber(5)
  $core.String get payload => $_getSZ(2);
  @$pb.TagNumber(5)
  set payload($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasPayload() => $_has(2);
  @$pb.TagNumber(5)
  void clearPayload() => clearField(5);
}

class SignJwtResponse extends $pb.GeneratedMessage {
  factory SignJwtResponse({
    $core.String? keyId,
    $core.String? signedJwt,
  }) {
    final $result = create();
    if (keyId != null) {
      $result.keyId = keyId;
    }
    if (signedJwt != null) {
      $result.signedJwt = signedJwt;
    }
    return $result;
  }
  SignJwtResponse._() : super();
  factory SignJwtResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory SignJwtResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignJwtResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.iam.credentials.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'keyId')
    ..aOS(2, _omitFieldNames ? '' : 'signedJwt')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  SignJwtResponse clone() => SignJwtResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  SignJwtResponse copyWith(void Function(SignJwtResponse) updates) =>
      super.copyWith((message) => updates(message as SignJwtResponse))
          as SignJwtResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignJwtResponse create() => SignJwtResponse._();
  SignJwtResponse createEmptyInstance() => create();
  static $pb.PbList<SignJwtResponse> createRepeated() =>
      $pb.PbList<SignJwtResponse>();
  @$core.pragma('dart2js:noInline')
  static SignJwtResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SignJwtResponse>(create);
  static SignJwtResponse? _defaultInstance;

  /// The ID of the key used to sign the JWT.
  @$pb.TagNumber(1)
  $core.String get keyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set keyId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasKeyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearKeyId() => clearField(1);

  /// The signed JWT.
  @$pb.TagNumber(2)
  $core.String get signedJwt => $_getSZ(1);
  @$pb.TagNumber(2)
  set signedJwt($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasSignedJwt() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignedJwt() => clearField(2);
}

class GenerateIdTokenRequest extends $pb.GeneratedMessage {
  factory GenerateIdTokenRequest({
    $core.String? name,
    $core.Iterable<$core.String>? delegates,
    $core.String? audience,
    $core.bool? includeEmail,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (delegates != null) {
      $result.delegates.addAll(delegates);
    }
    if (audience != null) {
      $result.audience = audience;
    }
    if (includeEmail != null) {
      $result.includeEmail = includeEmail;
    }
    return $result;
  }
  GenerateIdTokenRequest._() : super();
  factory GenerateIdTokenRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GenerateIdTokenRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GenerateIdTokenRequest',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.iam.credentials.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..pPS(2, _omitFieldNames ? '' : 'delegates')
    ..aOS(3, _omitFieldNames ? '' : 'audience')
    ..aOB(4, _omitFieldNames ? '' : 'includeEmail')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GenerateIdTokenRequest clone() =>
      GenerateIdTokenRequest()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GenerateIdTokenRequest copyWith(
          void Function(GenerateIdTokenRequest) updates) =>
      super.copyWith((message) => updates(message as GenerateIdTokenRequest))
          as GenerateIdTokenRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateIdTokenRequest create() => GenerateIdTokenRequest._();
  GenerateIdTokenRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateIdTokenRequest> createRepeated() =>
      $pb.PbList<GenerateIdTokenRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateIdTokenRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GenerateIdTokenRequest>(create);
  static GenerateIdTokenRequest? _defaultInstance;

  /// Required. The resource name of the service account for which the credentials
  /// are requested, in the following format:
  /// `projects/-/serviceAccounts/{ACCOUNT_EMAIL_OR_UNIQUEID}`. The `-` wildcard
  /// character is required; replacing it with a project ID is invalid.
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

  ///  The sequence of service accounts in a delegation chain. Each service
  ///  account must be granted the `roles/iam.serviceAccountTokenCreator` role
  ///  on its next service account in the chain. The last service account in the
  ///  chain must be granted the `roles/iam.serviceAccountTokenCreator` role
  ///  on the service account that is specified in the `name` field of the
  ///  request.
  ///
  ///  The delegates must have the following format:
  ///  `projects/-/serviceAccounts/{ACCOUNT_EMAIL_OR_UNIQUEID}`. The `-` wildcard
  ///  character is required; replacing it with a project ID is invalid.
  @$pb.TagNumber(2)
  $core.List<$core.String> get delegates => $_getList(1);

  /// Required. The audience for the token, such as the API or account that this token
  /// grants access to.
  @$pb.TagNumber(3)
  $core.String get audience => $_getSZ(2);
  @$pb.TagNumber(3)
  set audience($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasAudience() => $_has(2);
  @$pb.TagNumber(3)
  void clearAudience() => clearField(3);

  /// Include the service account email in the token. If set to `true`, the
  /// token will contain `email` and `email_verified` claims.
  @$pb.TagNumber(4)
  $core.bool get includeEmail => $_getBF(3);
  @$pb.TagNumber(4)
  set includeEmail($core.bool v) {
    $_setBool(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasIncludeEmail() => $_has(3);
  @$pb.TagNumber(4)
  void clearIncludeEmail() => clearField(4);
}

class GenerateIdTokenResponse extends $pb.GeneratedMessage {
  factory GenerateIdTokenResponse({
    $core.String? token,
  }) {
    final $result = create();
    if (token != null) {
      $result.token = token;
    }
    return $result;
  }
  GenerateIdTokenResponse._() : super();
  factory GenerateIdTokenResponse.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory GenerateIdTokenResponse.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GenerateIdTokenResponse',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.iam.credentials.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  GenerateIdTokenResponse clone() =>
      GenerateIdTokenResponse()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  GenerateIdTokenResponse copyWith(
          void Function(GenerateIdTokenResponse) updates) =>
      super.copyWith((message) => updates(message as GenerateIdTokenResponse))
          as GenerateIdTokenResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateIdTokenResponse create() => GenerateIdTokenResponse._();
  GenerateIdTokenResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateIdTokenResponse> createRepeated() =>
      $pb.PbList<GenerateIdTokenResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateIdTokenResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GenerateIdTokenResponse>(create);
  static GenerateIdTokenResponse? _defaultInstance;

  /// The OpenId Connect ID token.
  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => clearField(1);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
