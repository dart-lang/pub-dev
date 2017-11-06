///
//  Generated code. Do not modify.
///
library google.appengine.v1_application;

import 'package:protobuf/protobuf.dart';

import '../../protobuf/duration.pb.dart' as google$protobuf;

class Application extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Application')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..a/*<String>*/(2, 'id', PbFieldType.OS)
    ..pp/*<UrlDispatchRule>*/(3, 'dispatchRules', PbFieldType.PM, UrlDispatchRule.$checkItem, UrlDispatchRule.create)
    ..a/*<String>*/(6, 'authDomain', PbFieldType.OS)
    ..a/*<String>*/(7, 'locationId', PbFieldType.OS)
    ..a/*<String>*/(8, 'codeBucket', PbFieldType.OS)
    ..a/*<google$protobuf.Duration>*/(9, 'defaultCookieExpiration', PbFieldType.OM, google$protobuf.Duration.getDefault, google$protobuf.Duration.create)
    ..a/*<String>*/(11, 'defaultHostname', PbFieldType.OS)
    ..a/*<String>*/(12, 'defaultBucket', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  Application() : super();
  Application.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Application.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Application clone() => new Application()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Application create() => new Application();
  static PbList<Application> createRepeated() => new PbList<Application>();
  static Application getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyApplication();
    return _defaultInstance;
  }
  static Application _defaultInstance;
  static void $checkItem(Application v) {
    if (v is !Application) checkItemFailed(v, 'Application');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  String get id => $_get(1, 2, '');
  void set id(String v) { $_setString(1, 2, v); }
  bool hasId() => $_has(1, 2);
  void clearId() => clearField(2);

  List<UrlDispatchRule> get dispatchRules => $_get(2, 3, null);

  String get authDomain => $_get(3, 6, '');
  void set authDomain(String v) { $_setString(3, 6, v); }
  bool hasAuthDomain() => $_has(3, 6);
  void clearAuthDomain() => clearField(6);

  String get locationId => $_get(4, 7, '');
  void set locationId(String v) { $_setString(4, 7, v); }
  bool hasLocationId() => $_has(4, 7);
  void clearLocationId() => clearField(7);

  String get codeBucket => $_get(5, 8, '');
  void set codeBucket(String v) { $_setString(5, 8, v); }
  bool hasCodeBucket() => $_has(5, 8);
  void clearCodeBucket() => clearField(8);

  google$protobuf.Duration get defaultCookieExpiration => $_get(6, 9, null);
  void set defaultCookieExpiration(google$protobuf.Duration v) { setField(9, v); }
  bool hasDefaultCookieExpiration() => $_has(6, 9);
  void clearDefaultCookieExpiration() => clearField(9);

  String get defaultHostname => $_get(7, 11, '');
  void set defaultHostname(String v) { $_setString(7, 11, v); }
  bool hasDefaultHostname() => $_has(7, 11);
  void clearDefaultHostname() => clearField(11);

  String get defaultBucket => $_get(8, 12, '');
  void set defaultBucket(String v) { $_setString(8, 12, v); }
  bool hasDefaultBucket() => $_has(8, 12);
  void clearDefaultBucket() => clearField(12);
}

class _ReadonlyApplication extends Application with ReadonlyMessageMixin {}

class UrlDispatchRule extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('UrlDispatchRule')
    ..a/*<String>*/(1, 'domain', PbFieldType.OS)
    ..a/*<String>*/(2, 'path', PbFieldType.OS)
    ..a/*<String>*/(3, 'service', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  UrlDispatchRule() : super();
  UrlDispatchRule.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  UrlDispatchRule.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  UrlDispatchRule clone() => new UrlDispatchRule()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static UrlDispatchRule create() => new UrlDispatchRule();
  static PbList<UrlDispatchRule> createRepeated() => new PbList<UrlDispatchRule>();
  static UrlDispatchRule getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyUrlDispatchRule();
    return _defaultInstance;
  }
  static UrlDispatchRule _defaultInstance;
  static void $checkItem(UrlDispatchRule v) {
    if (v is !UrlDispatchRule) checkItemFailed(v, 'UrlDispatchRule');
  }

  String get domain => $_get(0, 1, '');
  void set domain(String v) { $_setString(0, 1, v); }
  bool hasDomain() => $_has(0, 1);
  void clearDomain() => clearField(1);

  String get path => $_get(1, 2, '');
  void set path(String v) { $_setString(1, 2, v); }
  bool hasPath() => $_has(1, 2);
  void clearPath() => clearField(2);

  String get service => $_get(2, 3, '');
  void set service(String v) { $_setString(2, 3, v); }
  bool hasService() => $_has(2, 3);
  void clearService() => clearField(3);
}

class _ReadonlyUrlDispatchRule extends UrlDispatchRule with ReadonlyMessageMixin {}

