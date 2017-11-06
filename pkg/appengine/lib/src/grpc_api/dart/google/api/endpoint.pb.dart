///
//  Generated code. Do not modify.
///
library google.api_endpoint;

import 'package:protobuf/protobuf.dart';

class Endpoint extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Endpoint')
    ..a/*<String>*/(1, 'name', PbFieldType.OS)
    ..p/*<String>*/(2, 'aliases', PbFieldType.PS)
    ..p/*<String>*/(3, 'apis', PbFieldType.PS)
    ..p/*<String>*/(4, 'features', PbFieldType.PS)
    ..a/*<bool>*/(5, 'allowCors', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  Endpoint() : super();
  Endpoint.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Endpoint.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Endpoint clone() => new Endpoint()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Endpoint create() => new Endpoint();
  static PbList<Endpoint> createRepeated() => new PbList<Endpoint>();
  static Endpoint getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyEndpoint();
    return _defaultInstance;
  }
  static Endpoint _defaultInstance;
  static void $checkItem(Endpoint v) {
    if (v is !Endpoint) checkItemFailed(v, 'Endpoint');
  }

  String get name => $_get(0, 1, '');
  void set name(String v) { $_setString(0, 1, v); }
  bool hasName() => $_has(0, 1);
  void clearName() => clearField(1);

  List<String> get aliases => $_get(1, 2, null);

  List<String> get apis => $_get(2, 3, null);

  List<String> get features => $_get(3, 4, null);

  bool get allowCors => $_get(4, 5, false);
  void set allowCors(bool v) { $_setBool(4, 5, v); }
  bool hasAllowCors() => $_has(4, 5);
  void clearAllowCors() => clearField(5);
}

class _ReadonlyEndpoint extends Endpoint with ReadonlyMessageMixin {}

