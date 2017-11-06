///
//  Generated code. Do not modify.
///
library google.type_color;

import 'package:protobuf/protobuf.dart';

import '../protobuf/wrappers.pb.dart' as google$protobuf;

class Color extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Color')
    ..a/*<double>*/(1, 'red', PbFieldType.OF)
    ..a/*<double>*/(2, 'green', PbFieldType.OF)
    ..a/*<double>*/(3, 'blue', PbFieldType.OF)
    ..a/*<google$protobuf.FloatValue>*/(4, 'alpha', PbFieldType.OM, google$protobuf.FloatValue.getDefault, google$protobuf.FloatValue.create)
    ..hasRequiredFields = false
  ;

  Color() : super();
  Color.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Color.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Color clone() => new Color()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Color create() => new Color();
  static PbList<Color> createRepeated() => new PbList<Color>();
  static Color getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyColor();
    return _defaultInstance;
  }
  static Color _defaultInstance;
  static void $checkItem(Color v) {
    if (v is !Color) checkItemFailed(v, 'Color');
  }

  double get red => $_get(0, 1, null);
  void set red(double v) { $_setFloat(0, 1, v); }
  bool hasRed() => $_has(0, 1);
  void clearRed() => clearField(1);

  double get green => $_get(1, 2, null);
  void set green(double v) { $_setFloat(1, 2, v); }
  bool hasGreen() => $_has(1, 2);
  void clearGreen() => clearField(2);

  double get blue => $_get(2, 3, null);
  void set blue(double v) { $_setFloat(2, 3, v); }
  bool hasBlue() => $_has(2, 3);
  void clearBlue() => clearField(3);

  google$protobuf.FloatValue get alpha => $_get(3, 4, null);
  void set alpha(google$protobuf.FloatValue v) { setField(4, v); }
  bool hasAlpha() => $_has(3, 4);
  void clearAlpha() => clearField(4);
}

class _ReadonlyColor extends Color with ReadonlyMessageMixin {}

