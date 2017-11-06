///
//  Generated code. Do not modify.
///
library google.api_auth;

import 'package:protobuf/protobuf.dart';

class Authentication extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Authentication')
    ..pp/*<AuthenticationRule>*/(3, 'rules', PbFieldType.PM, AuthenticationRule.$checkItem, AuthenticationRule.create)
    ..pp/*<AuthProvider>*/(4, 'providers', PbFieldType.PM, AuthProvider.$checkItem, AuthProvider.create)
    ..hasRequiredFields = false
  ;

  Authentication() : super();
  Authentication.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Authentication.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Authentication clone() => new Authentication()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Authentication create() => new Authentication();
  static PbList<Authentication> createRepeated() => new PbList<Authentication>();
  static Authentication getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAuthentication();
    return _defaultInstance;
  }
  static Authentication _defaultInstance;
  static void $checkItem(Authentication v) {
    if (v is !Authentication) checkItemFailed(v, 'Authentication');
  }

  List<AuthenticationRule> get rules => $_get(0, 3, null);

  List<AuthProvider> get providers => $_get(1, 4, null);
}

class _ReadonlyAuthentication extends Authentication with ReadonlyMessageMixin {}

class AuthenticationRule extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AuthenticationRule')
    ..a/*<String>*/(1, 'selector', PbFieldType.OS)
    ..a/*<OAuthRequirements>*/(2, 'oauth', PbFieldType.OM, OAuthRequirements.getDefault, OAuthRequirements.create)
    ..a/*<bool>*/(5, 'allowWithoutCredential', PbFieldType.OB)
    ..pp/*<AuthRequirement>*/(7, 'requirements', PbFieldType.PM, AuthRequirement.$checkItem, AuthRequirement.create)
    ..hasRequiredFields = false
  ;

  AuthenticationRule() : super();
  AuthenticationRule.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AuthenticationRule.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AuthenticationRule clone() => new AuthenticationRule()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AuthenticationRule create() => new AuthenticationRule();
  static PbList<AuthenticationRule> createRepeated() => new PbList<AuthenticationRule>();
  static AuthenticationRule getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAuthenticationRule();
    return _defaultInstance;
  }
  static AuthenticationRule _defaultInstance;
  static void $checkItem(AuthenticationRule v) {
    if (v is !AuthenticationRule) checkItemFailed(v, 'AuthenticationRule');
  }

  String get selector => $_get(0, 1, '');
  void set selector(String v) { $_setString(0, 1, v); }
  bool hasSelector() => $_has(0, 1);
  void clearSelector() => clearField(1);

  OAuthRequirements get oauth => $_get(1, 2, null);
  void set oauth(OAuthRequirements v) { setField(2, v); }
  bool hasOauth() => $_has(1, 2);
  void clearOauth() => clearField(2);

  bool get allowWithoutCredential => $_get(2, 5, false);
  void set allowWithoutCredential(bool v) { $_setBool(2, 5, v); }
  bool hasAllowWithoutCredential() => $_has(2, 5);
  void clearAllowWithoutCredential() => clearField(5);

  List<AuthRequirement> get requirements => $_get(3, 7, null);
}

class _ReadonlyAuthenticationRule extends AuthenticationRule with ReadonlyMessageMixin {}

class AuthProvider extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AuthProvider')
    ..a/*<String>*/(1, 'id', PbFieldType.OS)
    ..a/*<String>*/(2, 'issuer', PbFieldType.OS)
    ..a/*<String>*/(3, 'jwksUri', PbFieldType.OS)
    ..a/*<String>*/(4, 'audiences', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  AuthProvider() : super();
  AuthProvider.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AuthProvider.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AuthProvider clone() => new AuthProvider()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AuthProvider create() => new AuthProvider();
  static PbList<AuthProvider> createRepeated() => new PbList<AuthProvider>();
  static AuthProvider getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAuthProvider();
    return _defaultInstance;
  }
  static AuthProvider _defaultInstance;
  static void $checkItem(AuthProvider v) {
    if (v is !AuthProvider) checkItemFailed(v, 'AuthProvider');
  }

  String get id => $_get(0, 1, '');
  void set id(String v) { $_setString(0, 1, v); }
  bool hasId() => $_has(0, 1);
  void clearId() => clearField(1);

  String get issuer => $_get(1, 2, '');
  void set issuer(String v) { $_setString(1, 2, v); }
  bool hasIssuer() => $_has(1, 2);
  void clearIssuer() => clearField(2);

  String get jwksUri => $_get(2, 3, '');
  void set jwksUri(String v) { $_setString(2, 3, v); }
  bool hasJwksUri() => $_has(2, 3);
  void clearJwksUri() => clearField(3);

  String get audiences => $_get(3, 4, '');
  void set audiences(String v) { $_setString(3, 4, v); }
  bool hasAudiences() => $_has(3, 4);
  void clearAudiences() => clearField(4);
}

class _ReadonlyAuthProvider extends AuthProvider with ReadonlyMessageMixin {}

class OAuthRequirements extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('OAuthRequirements')
    ..a/*<String>*/(1, 'canonicalScopes', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  OAuthRequirements() : super();
  OAuthRequirements.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  OAuthRequirements.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  OAuthRequirements clone() => new OAuthRequirements()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static OAuthRequirements create() => new OAuthRequirements();
  static PbList<OAuthRequirements> createRepeated() => new PbList<OAuthRequirements>();
  static OAuthRequirements getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyOAuthRequirements();
    return _defaultInstance;
  }
  static OAuthRequirements _defaultInstance;
  static void $checkItem(OAuthRequirements v) {
    if (v is !OAuthRequirements) checkItemFailed(v, 'OAuthRequirements');
  }

  String get canonicalScopes => $_get(0, 1, '');
  void set canonicalScopes(String v) { $_setString(0, 1, v); }
  bool hasCanonicalScopes() => $_has(0, 1);
  void clearCanonicalScopes() => clearField(1);
}

class _ReadonlyOAuthRequirements extends OAuthRequirements with ReadonlyMessageMixin {}

class AuthRequirement extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AuthRequirement')
    ..a/*<String>*/(1, 'providerId', PbFieldType.OS)
    ..a/*<String>*/(2, 'audiences', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  AuthRequirement() : super();
  AuthRequirement.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AuthRequirement.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AuthRequirement clone() => new AuthRequirement()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AuthRequirement create() => new AuthRequirement();
  static PbList<AuthRequirement> createRepeated() => new PbList<AuthRequirement>();
  static AuthRequirement getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAuthRequirement();
    return _defaultInstance;
  }
  static AuthRequirement _defaultInstance;
  static void $checkItem(AuthRequirement v) {
    if (v is !AuthRequirement) checkItemFailed(v, 'AuthRequirement');
  }

  String get providerId => $_get(0, 1, '');
  void set providerId(String v) { $_setString(0, 1, v); }
  bool hasProviderId() => $_has(0, 1);
  void clearProviderId() => clearField(1);

  String get audiences => $_get(1, 2, '');
  void set audiences(String v) { $_setString(1, 2, v); }
  bool hasAudiences() => $_has(1, 2);
  void clearAudiences() => clearField(2);
}

class _ReadonlyAuthRequirement extends AuthRequirement with ReadonlyMessageMixin {}

