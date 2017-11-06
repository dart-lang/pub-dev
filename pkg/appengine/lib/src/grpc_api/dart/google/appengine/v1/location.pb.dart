///
//  Generated code. Do not modify.
///
library google.appengine.v1_location;

import 'package:protobuf/protobuf.dart';

class LocationMetadata extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LocationMetadata')
    ..a/*<bool>*/(2, 'standardEnvironmentAvailable', PbFieldType.OB)
    ..a/*<bool>*/(4, 'flexibleEnvironmentAvailable', PbFieldType.OB)
    ..hasRequiredFields = false
  ;

  LocationMetadata() : super();
  LocationMetadata.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LocationMetadata.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LocationMetadata clone() => new LocationMetadata()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static LocationMetadata create() => new LocationMetadata();
  static PbList<LocationMetadata> createRepeated() => new PbList<LocationMetadata>();
  static LocationMetadata getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyLocationMetadata();
    return _defaultInstance;
  }
  static LocationMetadata _defaultInstance;
  static void $checkItem(LocationMetadata v) {
    if (v is !LocationMetadata) checkItemFailed(v, 'LocationMetadata');
  }

  bool get standardEnvironmentAvailable => $_get(0, 2, false);
  void set standardEnvironmentAvailable(bool v) { $_setBool(0, 2, v); }
  bool hasStandardEnvironmentAvailable() => $_has(0, 2);
  void clearStandardEnvironmentAvailable() => clearField(2);

  bool get flexibleEnvironmentAvailable => $_get(1, 4, false);
  void set flexibleEnvironmentAvailable(bool v) { $_setBool(1, 4, v); }
  bool hasFlexibleEnvironmentAvailable() => $_has(1, 4);
  void clearFlexibleEnvironmentAvailable() => clearField(4);
}

class _ReadonlyLocationMetadata extends LocationMetadata with ReadonlyMessageMixin {}

