//
//  Generated code. Do not modify.
//  source: google/appengine/v1beta/application.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../protobuf/duration.pb.dart' as $51;
import 'application.pbenum.dart';

export 'application.pbenum.dart';

/// Identity-Aware Proxy
class Application_IdentityAwareProxy extends $pb.GeneratedMessage {
  factory Application_IdentityAwareProxy({
    $core.bool? enabled,
    $core.String? oauth2ClientId,
    $core.String? oauth2ClientSecret,
    $core.String? oauth2ClientSecretSha256,
  }) {
    final $result = create();
    if (enabled != null) {
      $result.enabled = enabled;
    }
    if (oauth2ClientId != null) {
      $result.oauth2ClientId = oauth2ClientId;
    }
    if (oauth2ClientSecret != null) {
      $result.oauth2ClientSecret = oauth2ClientSecret;
    }
    if (oauth2ClientSecretSha256 != null) {
      $result.oauth2ClientSecretSha256 = oauth2ClientSecretSha256;
    }
    return $result;
  }
  Application_IdentityAwareProxy._() : super();
  factory Application_IdentityAwareProxy.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Application_IdentityAwareProxy.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Application.IdentityAwareProxy',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'enabled')
    ..aOS(2, _omitFieldNames ? '' : 'oauth2ClientId')
    ..aOS(3, _omitFieldNames ? '' : 'oauth2ClientSecret')
    ..aOS(4, _omitFieldNames ? '' : 'oauth2ClientSecretSha256')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Application_IdentityAwareProxy clone() =>
      Application_IdentityAwareProxy()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Application_IdentityAwareProxy copyWith(
          void Function(Application_IdentityAwareProxy) updates) =>
      super.copyWith(
              (message) => updates(message as Application_IdentityAwareProxy))
          as Application_IdentityAwareProxy;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Application_IdentityAwareProxy create() =>
      Application_IdentityAwareProxy._();
  Application_IdentityAwareProxy createEmptyInstance() => create();
  static $pb.PbList<Application_IdentityAwareProxy> createRepeated() =>
      $pb.PbList<Application_IdentityAwareProxy>();
  @$core.pragma('dart2js:noInline')
  static Application_IdentityAwareProxy getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Application_IdentityAwareProxy>(create);
  static Application_IdentityAwareProxy? _defaultInstance;

  ///  Whether the serving infrastructure will authenticate and
  ///  authorize all incoming requests.
  ///
  ///  If true, the `oauth2_client_id` and `oauth2_client_secret`
  ///  fields must be non-empty.
  @$pb.TagNumber(1)
  $core.bool get enabled => $_getBF(0);
  @$pb.TagNumber(1)
  set enabled($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasEnabled() => $_has(0);
  @$pb.TagNumber(1)
  void clearEnabled() => clearField(1);

  /// OAuth2 client ID to use for the authentication flow.
  @$pb.TagNumber(2)
  $core.String get oauth2ClientId => $_getSZ(1);
  @$pb.TagNumber(2)
  set oauth2ClientId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasOauth2ClientId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOauth2ClientId() => clearField(2);

  ///  OAuth2 client secret to use for the authentication flow.
  ///
  ///  For security reasons, this value cannot be retrieved via the API.
  ///  Instead, the SHA-256 hash of the value is returned in the
  ///  `oauth2_client_secret_sha256` field.
  ///
  ///  @InputOnly
  @$pb.TagNumber(3)
  $core.String get oauth2ClientSecret => $_getSZ(2);
  @$pb.TagNumber(3)
  set oauth2ClientSecret($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasOauth2ClientSecret() => $_has(2);
  @$pb.TagNumber(3)
  void clearOauth2ClientSecret() => clearField(3);

  ///  Hex-encoded SHA-256 hash of the client secret.
  ///
  ///  @OutputOnly
  @$pb.TagNumber(4)
  $core.String get oauth2ClientSecretSha256 => $_getSZ(3);
  @$pb.TagNumber(4)
  set oauth2ClientSecretSha256($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasOauth2ClientSecretSha256() => $_has(3);
  @$pb.TagNumber(4)
  void clearOauth2ClientSecretSha256() => clearField(4);
}

/// The feature specific settings to be used in the application. These define
/// behaviors that are user configurable.
class Application_FeatureSettings extends $pb.GeneratedMessage {
  factory Application_FeatureSettings({
    $core.bool? splitHealthChecks,
    $core.bool? useContainerOptimizedOs,
  }) {
    final $result = create();
    if (splitHealthChecks != null) {
      $result.splitHealthChecks = splitHealthChecks;
    }
    if (useContainerOptimizedOs != null) {
      $result.useContainerOptimizedOs = useContainerOptimizedOs;
    }
    return $result;
  }
  Application_FeatureSettings._() : super();
  factory Application_FeatureSettings.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Application_FeatureSettings.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Application.FeatureSettings',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'splitHealthChecks')
    ..aOB(2, _omitFieldNames ? '' : 'useContainerOptimizedOs')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Application_FeatureSettings clone() =>
      Application_FeatureSettings()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Application_FeatureSettings copyWith(
          void Function(Application_FeatureSettings) updates) =>
      super.copyWith(
              (message) => updates(message as Application_FeatureSettings))
          as Application_FeatureSettings;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Application_FeatureSettings create() =>
      Application_FeatureSettings._();
  Application_FeatureSettings createEmptyInstance() => create();
  static $pb.PbList<Application_FeatureSettings> createRepeated() =>
      $pb.PbList<Application_FeatureSettings>();
  @$core.pragma('dart2js:noInline')
  static Application_FeatureSettings getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Application_FeatureSettings>(create);
  static Application_FeatureSettings? _defaultInstance;

  /// Boolean value indicating if split health checks should be used instead
  /// of the legacy health checks. At an app.yaml level, this means defaulting
  /// to 'readiness_check' and 'liveness_check' values instead of
  /// 'health_check' ones. Once the legacy 'health_check' behavior is
  /// deprecated, and this value is always true, this setting can
  /// be removed.
  @$pb.TagNumber(1)
  $core.bool get splitHealthChecks => $_getBF(0);
  @$pb.TagNumber(1)
  set splitHealthChecks($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSplitHealthChecks() => $_has(0);
  @$pb.TagNumber(1)
  void clearSplitHealthChecks() => clearField(1);

  /// If true, use [Container-Optimized OS](https://cloud.google.com/container-optimized-os/)
  /// base image for VMs, rather than a base Debian image.
  @$pb.TagNumber(2)
  $core.bool get useContainerOptimizedOs => $_getBF(1);
  @$pb.TagNumber(2)
  set useContainerOptimizedOs($core.bool v) {
    $_setBool(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasUseContainerOptimizedOs() => $_has(1);
  @$pb.TagNumber(2)
  void clearUseContainerOptimizedOs() => clearField(2);
}

/// An Application resource contains the top-level configuration of an App
/// Engine application.
class Application extends $pb.GeneratedMessage {
  factory Application({
    $core.String? name,
    $core.String? id,
    $core.Iterable<UrlDispatchRule>? dispatchRules,
    $core.String? authDomain,
    $core.String? locationId,
    $core.String? codeBucket,
    $51.Duration? defaultCookieExpiration,
    Application_ServingStatus? servingStatus,
    $core.String? defaultHostname,
    $core.String? defaultBucket,
    Application_IdentityAwareProxy? iap,
    $core.String? gcrDomain,
    Application_DatabaseType? databaseType,
    Application_FeatureSettings? featureSettings,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (id != null) {
      $result.id = id;
    }
    if (dispatchRules != null) {
      $result.dispatchRules.addAll(dispatchRules);
    }
    if (authDomain != null) {
      $result.authDomain = authDomain;
    }
    if (locationId != null) {
      $result.locationId = locationId;
    }
    if (codeBucket != null) {
      $result.codeBucket = codeBucket;
    }
    if (defaultCookieExpiration != null) {
      $result.defaultCookieExpiration = defaultCookieExpiration;
    }
    if (servingStatus != null) {
      $result.servingStatus = servingStatus;
    }
    if (defaultHostname != null) {
      $result.defaultHostname = defaultHostname;
    }
    if (defaultBucket != null) {
      $result.defaultBucket = defaultBucket;
    }
    if (iap != null) {
      $result.iap = iap;
    }
    if (gcrDomain != null) {
      $result.gcrDomain = gcrDomain;
    }
    if (databaseType != null) {
      $result.databaseType = databaseType;
    }
    if (featureSettings != null) {
      $result.featureSettings = featureSettings;
    }
    return $result;
  }
  Application._() : super();
  factory Application.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Application.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Application',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'id')
    ..pc<UrlDispatchRule>(
        3, _omitFieldNames ? '' : 'dispatchRules', $pb.PbFieldType.PM,
        subBuilder: UrlDispatchRule.create)
    ..aOS(6, _omitFieldNames ? '' : 'authDomain')
    ..aOS(7, _omitFieldNames ? '' : 'locationId')
    ..aOS(8, _omitFieldNames ? '' : 'codeBucket')
    ..aOM<$51.Duration>(9, _omitFieldNames ? '' : 'defaultCookieExpiration',
        subBuilder: $51.Duration.create)
    ..e<Application_ServingStatus>(
        10, _omitFieldNames ? '' : 'servingStatus', $pb.PbFieldType.OE,
        defaultOrMaker: Application_ServingStatus.UNSPECIFIED,
        valueOf: Application_ServingStatus.valueOf,
        enumValues: Application_ServingStatus.values)
    ..aOS(11, _omitFieldNames ? '' : 'defaultHostname')
    ..aOS(12, _omitFieldNames ? '' : 'defaultBucket')
    ..aOM<Application_IdentityAwareProxy>(14, _omitFieldNames ? '' : 'iap',
        subBuilder: Application_IdentityAwareProxy.create)
    ..aOS(16, _omitFieldNames ? '' : 'gcrDomain')
    ..e<Application_DatabaseType>(
        17, _omitFieldNames ? '' : 'databaseType', $pb.PbFieldType.OE,
        defaultOrMaker: Application_DatabaseType.DATABASE_TYPE_UNSPECIFIED,
        valueOf: Application_DatabaseType.valueOf,
        enumValues: Application_DatabaseType.values)
    ..aOM<Application_FeatureSettings>(
        18, _omitFieldNames ? '' : 'featureSettings',
        subBuilder: Application_FeatureSettings.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Application clone() => Application()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Application copyWith(void Function(Application) updates) =>
      super.copyWith((message) => updates(message as Application))
          as Application;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Application create() => Application._();
  Application createEmptyInstance() => create();
  static $pb.PbList<Application> createRepeated() => $pb.PbList<Application>();
  @$core.pragma('dart2js:noInline')
  static Application getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Application>(create);
  static Application? _defaultInstance;

  ///  Full path to the Application resource in the API.
  ///  Example: `apps/myapp`.
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

  /// Identifier of the Application resource. This identifier is equivalent
  /// to the project ID of the Google Cloud Platform project where you want to
  /// deploy your application.
  /// Example: `myapp`.
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

  /// HTTP path dispatch rules for requests to the application that do not
  /// explicitly target a service or version. Rules are order-dependent.
  /// Up to 20 dispatch rules can be supported.
  @$pb.TagNumber(3)
  $core.List<UrlDispatchRule> get dispatchRules => $_getList(2);

  ///  Google Apps authentication domain that controls which users can access
  ///  this application.
  ///
  ///  Defaults to open access for any Google Account.
  @$pb.TagNumber(6)
  $core.String get authDomain => $_getSZ(3);
  @$pb.TagNumber(6)
  set authDomain($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasAuthDomain() => $_has(3);
  @$pb.TagNumber(6)
  void clearAuthDomain() => clearField(6);

  ///  Location from which this application runs. Application instances
  ///  run out of the data centers in the specified location, which is also where
  ///  all of the application's end user content is stored.
  ///
  ///  Defaults to `us-central`.
  ///
  ///  View the list of
  ///  [supported locations](https://cloud.google.com/appengine/docs/locations).
  @$pb.TagNumber(7)
  $core.String get locationId => $_getSZ(4);
  @$pb.TagNumber(7)
  set locationId($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(7)
  $core.bool hasLocationId() => $_has(4);
  @$pb.TagNumber(7)
  void clearLocationId() => clearField(7);

  ///  Google Cloud Storage bucket that can be used for storing files
  ///  associated with this application. This bucket is associated with the
  ///  application and can be used by the gcloud deployment commands.
  ///
  ///  @OutputOnly
  @$pb.TagNumber(8)
  $core.String get codeBucket => $_getSZ(5);
  @$pb.TagNumber(8)
  set codeBucket($core.String v) {
    $_setString(5, v);
  }

  @$pb.TagNumber(8)
  $core.bool hasCodeBucket() => $_has(5);
  @$pb.TagNumber(8)
  void clearCodeBucket() => clearField(8);

  /// Cookie expiration policy for this application.
  @$pb.TagNumber(9)
  $51.Duration get defaultCookieExpiration => $_getN(6);
  @$pb.TagNumber(9)
  set defaultCookieExpiration($51.Duration v) {
    setField(9, v);
  }

  @$pb.TagNumber(9)
  $core.bool hasDefaultCookieExpiration() => $_has(6);
  @$pb.TagNumber(9)
  void clearDefaultCookieExpiration() => clearField(9);
  @$pb.TagNumber(9)
  $51.Duration ensureDefaultCookieExpiration() => $_ensure(6);

  /// Serving status of this application.
  @$pb.TagNumber(10)
  Application_ServingStatus get servingStatus => $_getN(7);
  @$pb.TagNumber(10)
  set servingStatus(Application_ServingStatus v) {
    setField(10, v);
  }

  @$pb.TagNumber(10)
  $core.bool hasServingStatus() => $_has(7);
  @$pb.TagNumber(10)
  void clearServingStatus() => clearField(10);

  ///  Hostname used to reach this application, as resolved by App Engine.
  ///
  ///  @OutputOnly
  @$pb.TagNumber(11)
  $core.String get defaultHostname => $_getSZ(8);
  @$pb.TagNumber(11)
  set defaultHostname($core.String v) {
    $_setString(8, v);
  }

  @$pb.TagNumber(11)
  $core.bool hasDefaultHostname() => $_has(8);
  @$pb.TagNumber(11)
  void clearDefaultHostname() => clearField(11);

  ///  Google Cloud Storage bucket that can be used by this application to store
  ///  content.
  ///
  ///  @OutputOnly
  @$pb.TagNumber(12)
  $core.String get defaultBucket => $_getSZ(9);
  @$pb.TagNumber(12)
  set defaultBucket($core.String v) {
    $_setString(9, v);
  }

  @$pb.TagNumber(12)
  $core.bool hasDefaultBucket() => $_has(9);
  @$pb.TagNumber(12)
  void clearDefaultBucket() => clearField(12);

  @$pb.TagNumber(14)
  Application_IdentityAwareProxy get iap => $_getN(10);
  @$pb.TagNumber(14)
  set iap(Application_IdentityAwareProxy v) {
    setField(14, v);
  }

  @$pb.TagNumber(14)
  $core.bool hasIap() => $_has(10);
  @$pb.TagNumber(14)
  void clearIap() => clearField(14);
  @$pb.TagNumber(14)
  Application_IdentityAwareProxy ensureIap() => $_ensure(10);

  /// The Google Container Registry domain used for storing managed build docker
  /// images for this application.
  @$pb.TagNumber(16)
  $core.String get gcrDomain => $_getSZ(11);
  @$pb.TagNumber(16)
  set gcrDomain($core.String v) {
    $_setString(11, v);
  }

  @$pb.TagNumber(16)
  $core.bool hasGcrDomain() => $_has(11);
  @$pb.TagNumber(16)
  void clearGcrDomain() => clearField(16);

  /// The type of the Cloud Firestore or Cloud Datastore database associated with
  /// this application.
  @$pb.TagNumber(17)
  Application_DatabaseType get databaseType => $_getN(12);
  @$pb.TagNumber(17)
  set databaseType(Application_DatabaseType v) {
    setField(17, v);
  }

  @$pb.TagNumber(17)
  $core.bool hasDatabaseType() => $_has(12);
  @$pb.TagNumber(17)
  void clearDatabaseType() => clearField(17);

  /// The feature specific settings to be used in the application.
  @$pb.TagNumber(18)
  Application_FeatureSettings get featureSettings => $_getN(13);
  @$pb.TagNumber(18)
  set featureSettings(Application_FeatureSettings v) {
    setField(18, v);
  }

  @$pb.TagNumber(18)
  $core.bool hasFeatureSettings() => $_has(13);
  @$pb.TagNumber(18)
  void clearFeatureSettings() => clearField(18);
  @$pb.TagNumber(18)
  Application_FeatureSettings ensureFeatureSettings() => $_ensure(13);
}

/// Rules to match an HTTP request and dispatch that request to a service.
class UrlDispatchRule extends $pb.GeneratedMessage {
  factory UrlDispatchRule({
    $core.String? domain,
    $core.String? path,
    $core.String? service,
  }) {
    final $result = create();
    if (domain != null) {
      $result.domain = domain;
    }
    if (path != null) {
      $result.path = path;
    }
    if (service != null) {
      $result.service = service;
    }
    return $result;
  }
  UrlDispatchRule._() : super();
  factory UrlDispatchRule.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory UrlDispatchRule.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UrlDispatchRule',
      package: const $pb.PackageName(
          _omitMessageNames ? '' : 'google.appengine.v1beta'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'domain')
    ..aOS(2, _omitFieldNames ? '' : 'path')
    ..aOS(3, _omitFieldNames ? '' : 'service')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  UrlDispatchRule clone() => UrlDispatchRule()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  UrlDispatchRule copyWith(void Function(UrlDispatchRule) updates) =>
      super.copyWith((message) => updates(message as UrlDispatchRule))
          as UrlDispatchRule;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UrlDispatchRule create() => UrlDispatchRule._();
  UrlDispatchRule createEmptyInstance() => create();
  static $pb.PbList<UrlDispatchRule> createRepeated() =>
      $pb.PbList<UrlDispatchRule>();
  @$core.pragma('dart2js:noInline')
  static UrlDispatchRule getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UrlDispatchRule>(create);
  static UrlDispatchRule? _defaultInstance;

  ///  Domain name to match against. The wildcard "`*`" is supported if
  ///  specified before a period: "`*.`".
  ///
  ///  Defaults to matching all domains: "`*`".
  @$pb.TagNumber(1)
  $core.String get domain => $_getSZ(0);
  @$pb.TagNumber(1)
  set domain($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasDomain() => $_has(0);
  @$pb.TagNumber(1)
  void clearDomain() => clearField(1);

  ///  Pathname within the host. Must start with a "`/`". A
  ///  single "`*`" can be included at the end of the path.
  ///
  ///  The sum of the lengths of the domain and path may not
  ///  exceed 100 characters.
  @$pb.TagNumber(2)
  $core.String get path => $_getSZ(1);
  @$pb.TagNumber(2)
  set path($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearPath() => clearField(2);

  /// Resource ID of a service in this application that should
  /// serve the matched request. The service must already
  /// exist. Example: `default`.
  @$pb.TagNumber(3)
  $core.String get service => $_getSZ(2);
  @$pb.TagNumber(3)
  set service($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasService() => $_has(2);
  @$pb.TagNumber(3)
  void clearService() => clearField(3);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
