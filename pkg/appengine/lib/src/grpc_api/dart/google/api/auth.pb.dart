//
//  Generated code. Do not modify.
//  source: google/api/auth.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

///  `Authentication` defines the authentication configuration for API methods
///  provided by an API service.
///
///  Example:
///
///      name: calendar.googleapis.com
///      authentication:
///        providers:
///        - id: google_calendar_auth
///          jwks_uri: https://www.googleapis.com/oauth2/v1/certs
///          issuer: https://securetoken.google.com
///        rules:
///        - selector: "*"
///          requirements:
///            provider_id: google_calendar_auth
///        - selector: google.calendar.Delegate
///          oauth:
///            canonical_scopes: https://www.googleapis.com/auth/calendar.read
class Authentication extends $pb.GeneratedMessage {
  factory Authentication({
    $core.Iterable<AuthenticationRule>? rules,
    $core.Iterable<AuthProvider>? providers,
  }) {
    final $result = create();
    if (rules != null) {
      $result.rules.addAll(rules);
    }
    if (providers != null) {
      $result.providers.addAll(providers);
    }
    return $result;
  }
  Authentication._() : super();
  factory Authentication.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Authentication.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Authentication',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..pc<AuthenticationRule>(
        3, _omitFieldNames ? '' : 'rules', $pb.PbFieldType.PM,
        subBuilder: AuthenticationRule.create)
    ..pc<AuthProvider>(
        4, _omitFieldNames ? '' : 'providers', $pb.PbFieldType.PM,
        subBuilder: AuthProvider.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Authentication clone() => Authentication()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Authentication copyWith(void Function(Authentication) updates) =>
      super.copyWith((message) => updates(message as Authentication))
          as Authentication;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Authentication create() => Authentication._();
  Authentication createEmptyInstance() => create();
  static $pb.PbList<Authentication> createRepeated() =>
      $pb.PbList<Authentication>();
  @$core.pragma('dart2js:noInline')
  static Authentication getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Authentication>(create);
  static Authentication? _defaultInstance;

  ///  A list of authentication rules that apply to individual API methods.
  ///
  ///  **NOTE:** All service configuration rules follow "last one wins" order.
  @$pb.TagNumber(3)
  $core.List<AuthenticationRule> get rules => $_getList(0);

  /// Defines a set of authentication providers that a service supports.
  @$pb.TagNumber(4)
  $core.List<AuthProvider> get providers => $_getList(1);
}

///  Authentication rules for the service.
///
///  By default, if a method has any authentication requirements, every request
///  must include a valid credential matching one of the requirements.
///  It's an error to include more than one kind of credential in a single
///  request.
///
///  If a method doesn't have any auth requirements, request credentials will be
///  ignored.
class AuthenticationRule extends $pb.GeneratedMessage {
  factory AuthenticationRule({
    $core.String? selector,
    OAuthRequirements? oauth,
    $core.bool? allowWithoutCredential,
    $core.Iterable<AuthRequirement>? requirements,
  }) {
    final $result = create();
    if (selector != null) {
      $result.selector = selector;
    }
    if (oauth != null) {
      $result.oauth = oauth;
    }
    if (allowWithoutCredential != null) {
      $result.allowWithoutCredential = allowWithoutCredential;
    }
    if (requirements != null) {
      $result.requirements.addAll(requirements);
    }
    return $result;
  }
  AuthenticationRule._() : super();
  factory AuthenticationRule.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AuthenticationRule.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuthenticationRule',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'selector')
    ..aOM<OAuthRequirements>(2, _omitFieldNames ? '' : 'oauth',
        subBuilder: OAuthRequirements.create)
    ..aOB(5, _omitFieldNames ? '' : 'allowWithoutCredential')
    ..pc<AuthRequirement>(
        7, _omitFieldNames ? '' : 'requirements', $pb.PbFieldType.PM,
        subBuilder: AuthRequirement.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AuthenticationRule clone() => AuthenticationRule()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AuthenticationRule copyWith(void Function(AuthenticationRule) updates) =>
      super.copyWith((message) => updates(message as AuthenticationRule))
          as AuthenticationRule;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuthenticationRule create() => AuthenticationRule._();
  AuthenticationRule createEmptyInstance() => create();
  static $pb.PbList<AuthenticationRule> createRepeated() =>
      $pb.PbList<AuthenticationRule>();
  @$core.pragma('dart2js:noInline')
  static AuthenticationRule getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AuthenticationRule>(create);
  static AuthenticationRule? _defaultInstance;

  ///  Selects the methods to which this rule applies.
  ///
  ///  Refer to [selector][google.api.DocumentationRule.selector] for syntax
  ///  details.
  @$pb.TagNumber(1)
  $core.String get selector => $_getSZ(0);
  @$pb.TagNumber(1)
  set selector($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasSelector() => $_has(0);
  @$pb.TagNumber(1)
  void clearSelector() => clearField(1);

  /// The requirements for OAuth credentials.
  @$pb.TagNumber(2)
  OAuthRequirements get oauth => $_getN(1);
  @$pb.TagNumber(2)
  set oauth(OAuthRequirements v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasOauth() => $_has(1);
  @$pb.TagNumber(2)
  void clearOauth() => clearField(2);
  @$pb.TagNumber(2)
  OAuthRequirements ensureOauth() => $_ensure(1);

  /// If true, the service accepts API keys without any other credential.
  /// This flag only applies to HTTP and gRPC requests.
  @$pb.TagNumber(5)
  $core.bool get allowWithoutCredential => $_getBF(2);
  @$pb.TagNumber(5)
  set allowWithoutCredential($core.bool v) {
    $_setBool(2, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasAllowWithoutCredential() => $_has(2);
  @$pb.TagNumber(5)
  void clearAllowWithoutCredential() => clearField(5);

  /// Requirements for additional authentication providers.
  @$pb.TagNumber(7)
  $core.List<AuthRequirement> get requirements => $_getList(3);
}

enum JwtLocation_In { header, query, cookie, notSet }

/// Specifies a location to extract JWT from an API request.
class JwtLocation extends $pb.GeneratedMessage {
  factory JwtLocation({
    $core.String? header,
    $core.String? query,
    $core.String? valuePrefix,
    $core.String? cookie,
  }) {
    final $result = create();
    if (header != null) {
      $result.header = header;
    }
    if (query != null) {
      $result.query = query;
    }
    if (valuePrefix != null) {
      $result.valuePrefix = valuePrefix;
    }
    if (cookie != null) {
      $result.cookie = cookie;
    }
    return $result;
  }
  JwtLocation._() : super();
  factory JwtLocation.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory JwtLocation.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, JwtLocation_In> _JwtLocation_InByTag = {
    1: JwtLocation_In.header,
    2: JwtLocation_In.query,
    4: JwtLocation_In.cookie,
    0: JwtLocation_In.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JwtLocation',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 4])
    ..aOS(1, _omitFieldNames ? '' : 'header')
    ..aOS(2, _omitFieldNames ? '' : 'query')
    ..aOS(3, _omitFieldNames ? '' : 'valuePrefix')
    ..aOS(4, _omitFieldNames ? '' : 'cookie')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  JwtLocation clone() => JwtLocation()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  JwtLocation copyWith(void Function(JwtLocation) updates) =>
      super.copyWith((message) => updates(message as JwtLocation))
          as JwtLocation;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JwtLocation create() => JwtLocation._();
  JwtLocation createEmptyInstance() => create();
  static $pb.PbList<JwtLocation> createRepeated() => $pb.PbList<JwtLocation>();
  @$core.pragma('dart2js:noInline')
  static JwtLocation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<JwtLocation>(create);
  static JwtLocation? _defaultInstance;

  JwtLocation_In whichIn() => _JwtLocation_InByTag[$_whichOneof(0)]!;
  void clearIn() => clearField($_whichOneof(0));

  /// Specifies HTTP header name to extract JWT token.
  @$pb.TagNumber(1)
  $core.String get header => $_getSZ(0);
  @$pb.TagNumber(1)
  set header($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasHeader() => $_has(0);
  @$pb.TagNumber(1)
  void clearHeader() => clearField(1);

  /// Specifies URL query parameter name to extract JWT token.
  @$pb.TagNumber(2)
  $core.String get query => $_getSZ(1);
  @$pb.TagNumber(2)
  set query($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuery() => clearField(2);

  ///  The value prefix. The value format is "value_prefix{token}"
  ///  Only applies to "in" header type. Must be empty for "in" query type.
  ///  If not empty, the header value has to match (case sensitive) this prefix.
  ///  If not matched, JWT will not be extracted. If matched, JWT will be
  ///  extracted after the prefix is removed.
  ///
  ///  For example, for "Authorization: Bearer {JWT}",
  ///  value_prefix="Bearer " with a space at the end.
  @$pb.TagNumber(3)
  $core.String get valuePrefix => $_getSZ(2);
  @$pb.TagNumber(3)
  set valuePrefix($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasValuePrefix() => $_has(2);
  @$pb.TagNumber(3)
  void clearValuePrefix() => clearField(3);

  /// Specifies cookie name to extract JWT token.
  @$pb.TagNumber(4)
  $core.String get cookie => $_getSZ(3);
  @$pb.TagNumber(4)
  set cookie($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasCookie() => $_has(3);
  @$pb.TagNumber(4)
  void clearCookie() => clearField(4);
}

/// Configuration for an authentication provider, including support for
/// [JSON Web Token
/// (JWT)](https://tools.ietf.org/html/draft-ietf-oauth-json-web-token-32).
class AuthProvider extends $pb.GeneratedMessage {
  factory AuthProvider({
    $core.String? id,
    $core.String? issuer,
    $core.String? jwksUri,
    $core.String? audiences,
    $core.String? authorizationUrl,
    $core.Iterable<JwtLocation>? jwtLocations,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (issuer != null) {
      $result.issuer = issuer;
    }
    if (jwksUri != null) {
      $result.jwksUri = jwksUri;
    }
    if (audiences != null) {
      $result.audiences = audiences;
    }
    if (authorizationUrl != null) {
      $result.authorizationUrl = authorizationUrl;
    }
    if (jwtLocations != null) {
      $result.jwtLocations.addAll(jwtLocations);
    }
    return $result;
  }
  AuthProvider._() : super();
  factory AuthProvider.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AuthProvider.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuthProvider',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'issuer')
    ..aOS(3, _omitFieldNames ? '' : 'jwksUri')
    ..aOS(4, _omitFieldNames ? '' : 'audiences')
    ..aOS(5, _omitFieldNames ? '' : 'authorizationUrl')
    ..pc<JwtLocation>(
        6, _omitFieldNames ? '' : 'jwtLocations', $pb.PbFieldType.PM,
        subBuilder: JwtLocation.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AuthProvider clone() => AuthProvider()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AuthProvider copyWith(void Function(AuthProvider) updates) =>
      super.copyWith((message) => updates(message as AuthProvider))
          as AuthProvider;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuthProvider create() => AuthProvider._();
  AuthProvider createEmptyInstance() => create();
  static $pb.PbList<AuthProvider> createRepeated() =>
      $pb.PbList<AuthProvider>();
  @$core.pragma('dart2js:noInline')
  static AuthProvider getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AuthProvider>(create);
  static AuthProvider? _defaultInstance;

  ///  The unique identifier of the auth provider. It will be referred to by
  ///  `AuthRequirement.provider_id`.
  ///
  ///  Example: "bookstore_auth".
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  ///  Identifies the principal that issued the JWT. See
  ///  https://tools.ietf.org/html/draft-ietf-oauth-json-web-token-32#section-4.1.1
  ///  Usually a URL or an email address.
  ///
  ///  Example: https://securetoken.google.com
  ///  Example: 1234567-compute@developer.gserviceaccount.com
  @$pb.TagNumber(2)
  $core.String get issuer => $_getSZ(1);
  @$pb.TagNumber(2)
  set issuer($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasIssuer() => $_has(1);
  @$pb.TagNumber(2)
  void clearIssuer() => clearField(2);

  ///  URL of the provider's public key set to validate signature of the JWT. See
  ///  [OpenID
  ///  Discovery](https://openid.net/specs/openid-connect-discovery-1_0.html#ProviderMetadata).
  ///  Optional if the key set document:
  ///   - can be retrieved from
  ///     [OpenID
  ///     Discovery](https://openid.net/specs/openid-connect-discovery-1_0.html)
  ///     of the issuer.
  ///   - can be inferred from the email domain of the issuer (e.g. a Google
  ///   service account).
  ///
  ///  Example: https://www.googleapis.com/oauth2/v1/certs
  @$pb.TagNumber(3)
  $core.String get jwksUri => $_getSZ(2);
  @$pb.TagNumber(3)
  set jwksUri($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasJwksUri() => $_has(2);
  @$pb.TagNumber(3)
  void clearJwksUri() => clearField(3);

  ///  The list of JWT
  ///  [audiences](https://tools.ietf.org/html/draft-ietf-oauth-json-web-token-32#section-4.1.3).
  ///  that are allowed to access. A JWT containing any of these audiences will
  ///  be accepted. When this setting is absent, JWTs with audiences:
  ///    - "https://[service.name]/[google.protobuf.Api.name]"
  ///    - "https://[service.name]/"
  ///  will be accepted.
  ///  For example, if no audiences are in the setting, LibraryService API will
  ///  accept JWTs with the following audiences:
  ///    -
  ///    https://library-example.googleapis.com/google.example.library.v1.LibraryService
  ///    - https://library-example.googleapis.com/
  ///
  ///  Example:
  ///
  ///      audiences: bookstore_android.apps.googleusercontent.com,
  ///                 bookstore_web.apps.googleusercontent.com
  @$pb.TagNumber(4)
  $core.String get audiences => $_getSZ(3);
  @$pb.TagNumber(4)
  set audiences($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasAudiences() => $_has(3);
  @$pb.TagNumber(4)
  void clearAudiences() => clearField(4);

  /// Redirect URL if JWT token is required but not present or is expired.
  /// Implement authorizationUrl of securityDefinitions in OpenAPI spec.
  @$pb.TagNumber(5)
  $core.String get authorizationUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set authorizationUrl($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasAuthorizationUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearAuthorizationUrl() => clearField(5);

  ///  Defines the locations to extract the JWT.  For now it is only used by the
  ///  Cloud Endpoints to store the OpenAPI extension [x-google-jwt-locations]
  ///  (https://cloud.google.com/endpoints/docs/openapi/openapi-extensions#x-google-jwt-locations)
  ///
  ///  JWT locations can be one of HTTP headers, URL query parameters or
  ///  cookies. The rule is that the first match wins.
  ///
  ///  If not specified,  default to use following 3 locations:
  ///     1) Authorization: Bearer
  ///     2) x-goog-iap-jwt-assertion
  ///     3) access_token query parameter
  ///
  ///  Default locations can be specified as followings:
  ///     jwt_locations:
  ///     - header: Authorization
  ///       value_prefix: "Bearer "
  ///     - header: x-goog-iap-jwt-assertion
  ///     - query: access_token
  @$pb.TagNumber(6)
  $core.List<JwtLocation> get jwtLocations => $_getList(5);
}

///  OAuth scopes are a way to define data and permissions on data. For example,
///  there are scopes defined for "Read-only access to Google Calendar" and
///  "Access to Cloud Platform". Users can consent to a scope for an application,
///  giving it permission to access that data on their behalf.
///
///  OAuth scope specifications should be fairly coarse grained; a user will need
///  to see and understand the text description of what your scope means.
///
///  In most cases: use one or at most two OAuth scopes for an entire family of
///  products. If your product has multiple APIs, you should probably be sharing
///  the OAuth scope across all of those APIs.
///
///  When you need finer grained OAuth consent screens: talk with your product
///  management about how developers will use them in practice.
///
///  Please note that even though each of the canonical scopes is enough for a
///  request to be accepted and passed to the backend, a request can still fail
///  due to the backend requiring additional scopes or permissions.
class OAuthRequirements extends $pb.GeneratedMessage {
  factory OAuthRequirements({
    $core.String? canonicalScopes,
  }) {
    final $result = create();
    if (canonicalScopes != null) {
      $result.canonicalScopes = canonicalScopes;
    }
    return $result;
  }
  OAuthRequirements._() : super();
  factory OAuthRequirements.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory OAuthRequirements.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'OAuthRequirements',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'canonicalScopes')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  OAuthRequirements clone() => OAuthRequirements()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  OAuthRequirements copyWith(void Function(OAuthRequirements) updates) =>
      super.copyWith((message) => updates(message as OAuthRequirements))
          as OAuthRequirements;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OAuthRequirements create() => OAuthRequirements._();
  OAuthRequirements createEmptyInstance() => create();
  static $pb.PbList<OAuthRequirements> createRepeated() =>
      $pb.PbList<OAuthRequirements>();
  @$core.pragma('dart2js:noInline')
  static OAuthRequirements getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<OAuthRequirements>(create);
  static OAuthRequirements? _defaultInstance;

  ///  The list of publicly documented OAuth scopes that are allowed access. An
  ///  OAuth token containing any of these scopes will be accepted.
  ///
  ///  Example:
  ///
  ///       canonical_scopes: https://www.googleapis.com/auth/calendar,
  ///                         https://www.googleapis.com/auth/calendar.read
  @$pb.TagNumber(1)
  $core.String get canonicalScopes => $_getSZ(0);
  @$pb.TagNumber(1)
  set canonicalScopes($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasCanonicalScopes() => $_has(0);
  @$pb.TagNumber(1)
  void clearCanonicalScopes() => clearField(1);
}

/// User-defined authentication requirements, including support for
/// [JSON Web Token
/// (JWT)](https://tools.ietf.org/html/draft-ietf-oauth-json-web-token-32).
class AuthRequirement extends $pb.GeneratedMessage {
  factory AuthRequirement({
    $core.String? providerId,
    $core.String? audiences,
  }) {
    final $result = create();
    if (providerId != null) {
      $result.providerId = providerId;
    }
    if (audiences != null) {
      $result.audiences = audiences;
    }
    return $result;
  }
  AuthRequirement._() : super();
  factory AuthRequirement.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory AuthRequirement.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AuthRequirement',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.api'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'providerId')
    ..aOS(2, _omitFieldNames ? '' : 'audiences')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  AuthRequirement clone() => AuthRequirement()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  AuthRequirement copyWith(void Function(AuthRequirement) updates) =>
      super.copyWith((message) => updates(message as AuthRequirement))
          as AuthRequirement;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AuthRequirement create() => AuthRequirement._();
  AuthRequirement createEmptyInstance() => create();
  static $pb.PbList<AuthRequirement> createRepeated() =>
      $pb.PbList<AuthRequirement>();
  @$core.pragma('dart2js:noInline')
  static AuthRequirement getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AuthRequirement>(create);
  static AuthRequirement? _defaultInstance;

  ///  [id][google.api.AuthProvider.id] from authentication provider.
  ///
  ///  Example:
  ///
  ///      provider_id: bookstore_auth
  @$pb.TagNumber(1)
  $core.String get providerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set providerId($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasProviderId() => $_has(0);
  @$pb.TagNumber(1)
  void clearProviderId() => clearField(1);

  ///  NOTE: This will be deprecated soon, once AuthProvider.audiences is
  ///  implemented and accepted in all the runtime components.
  ///
  ///  The list of JWT
  ///  [audiences](https://tools.ietf.org/html/draft-ietf-oauth-json-web-token-32#section-4.1.3).
  ///  that are allowed to access. A JWT containing any of these audiences will
  ///  be accepted. When this setting is absent, only JWTs with audience
  ///  "https://[Service_name][google.api.Service.name]/[API_name][google.protobuf.Api.name]"
  ///  will be accepted. For example, if no audiences are in the setting,
  ///  LibraryService API will only accept JWTs with the following audience
  ///  "https://library-example.googleapis.com/google.example.library.v1.LibraryService".
  ///
  ///  Example:
  ///
  ///      audiences: bookstore_android.apps.googleusercontent.com,
  ///                 bookstore_web.apps.googleusercontent.com
  @$pb.TagNumber(2)
  $core.String get audiences => $_getSZ(1);
  @$pb.TagNumber(2)
  set audiences($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasAudiences() => $_has(1);
  @$pb.TagNumber(2)
  void clearAudiences() => clearField(2);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
