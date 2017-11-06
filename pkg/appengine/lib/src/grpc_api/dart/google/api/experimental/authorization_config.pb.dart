///
//  Generated code. Do not modify.
///
library google.api_authorization_config;

import 'package:protobuf/protobuf.dart';

class AuthorizationConfig extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('AuthorizationConfig')
    ..a/*<String>*/(1, 'provider', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  AuthorizationConfig() : super();
  AuthorizationConfig.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  AuthorizationConfig.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  AuthorizationConfig clone() => new AuthorizationConfig()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static AuthorizationConfig create() => new AuthorizationConfig();
  static PbList<AuthorizationConfig> createRepeated() => new PbList<AuthorizationConfig>();
  static AuthorizationConfig getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyAuthorizationConfig();
    return _defaultInstance;
  }
  static AuthorizationConfig _defaultInstance;
  static void $checkItem(AuthorizationConfig v) {
    if (v is !AuthorizationConfig) checkItemFailed(v, 'AuthorizationConfig');
  }

  String get provider => $_get(0, 1, '');
  void set provider(String v) { $_setString(0, 1, v); }
  bool hasProvider() => $_has(0, 1);
  void clearProvider() => clearField(1);
}

class _ReadonlyAuthorizationConfig extends AuthorizationConfig with ReadonlyMessageMixin {}

