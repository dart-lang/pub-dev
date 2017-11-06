///
//  Generated code. Do not modify.
///
library google.type_latlng;

import 'package:protobuf/protobuf.dart';

class LatLng extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LatLng')
    ..a/*<double>*/(1, 'latitude', PbFieldType.OD)
    ..a/*<double>*/(2, 'longitude', PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  LatLng() : super();
  LatLng.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LatLng.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LatLng clone() => new LatLng()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static LatLng create() => new LatLng();
  static PbList<LatLng> createRepeated() => new PbList<LatLng>();
  static LatLng getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyLatLng();
    return _defaultInstance;
  }
  static LatLng _defaultInstance;
  static void $checkItem(LatLng v) {
    if (v is !LatLng) checkItemFailed(v, 'LatLng');
  }

  double get latitude => $_get(0, 1, null);
  void set latitude(double v) { $_setDouble(0, 1, v); }
  bool hasLatitude() => $_has(0, 1);
  void clearLatitude() => clearField(1);

  double get longitude => $_get(1, 2, null);
  void set longitude(double v) { $_setDouble(1, 2, v); }
  bool hasLongitude() => $_has(1, 2);
  void clearLongitude() => clearField(2);
}

class _ReadonlyLatLng extends LatLng with ReadonlyMessageMixin {}

