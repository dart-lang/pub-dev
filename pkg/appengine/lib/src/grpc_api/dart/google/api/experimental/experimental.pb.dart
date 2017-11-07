///
//  Generated code. Do not modify.
///
library google.api_experimental;

import 'package:protobuf/protobuf.dart';

import 'authorization_config.pb.dart';

class Experimental extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Experimental')
    ..a/*<AuthorizationConfig>*/(8, 'authorization', PbFieldType.OM, AuthorizationConfig.getDefault, AuthorizationConfig.create)
    ..hasRequiredFields = false
  ;

  Experimental() : super();
  Experimental.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Experimental.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Experimental clone() => new Experimental()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Experimental create() => new Experimental();
  static PbList<Experimental> createRepeated() => new PbList<Experimental>();
  static Experimental getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyExperimental();
    return _defaultInstance;
  }
  static Experimental _defaultInstance;
  static void $checkItem(Experimental v) {
    if (v is !Experimental) checkItemFailed(v, 'Experimental');
  }

  AuthorizationConfig get authorization => $_get(0, 8, null);
  void set authorization(AuthorizationConfig v) { setField(8, v); }
  bool hasAuthorization() => $_has(0, 8);
  void clearAuthorization() => clearField(8);
}

class _ReadonlyExperimental extends Experimental with ReadonlyMessageMixin {}

