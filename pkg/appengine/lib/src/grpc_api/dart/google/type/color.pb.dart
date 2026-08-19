//
//  Generated code. Do not modify.
//  source: google/type/color.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../protobuf/wrappers.pb.dart' as $73;

///  Represents a color in the RGBA color space. This representation is designed
///  for simplicity of conversion to/from color representations in various
///  languages over compactness. For example, the fields of this representation
///  can be trivially provided to the constructor of `java.awt.Color` in Java; it
///  can also be trivially provided to UIColor's `+colorWithRed:green:blue:alpha`
///  method in iOS; and, with just a little work, it can be easily formatted into
///  a CSS `rgba()` string in JavaScript.
///
///  This reference page doesn't carry information about the absolute color
///  space
///  that should be used to interpret the RGB value (e.g. sRGB, Adobe RGB,
///  DCI-P3, BT.2020, etc.). By default, applications should assume the sRGB color
///  space.
///
///  When color equality needs to be decided, implementations, unless
///  documented otherwise, treat two colors as equal if all their red,
///  green, blue, and alpha values each differ by at most 1e-5.
///
///  Example (Java):
///
///       import com.google.type.Color;
///
///       // ...
///       public static java.awt.Color fromProto(Color protocolor) {
///         float alpha = protocolor.hasAlpha()
///             ? protocolor.getAlpha().getValue()
///             : 1.0;
///
///         return new java.awt.Color(
///             protocolor.getRed(),
///             protocolor.getGreen(),
///             protocolor.getBlue(),
///             alpha);
///       }
///
///       public static Color toProto(java.awt.Color color) {
///         float red = (float) color.getRed();
///         float green = (float) color.getGreen();
///         float blue = (float) color.getBlue();
///         float denominator = 255.0;
///         Color.Builder resultBuilder =
///             Color
///                 .newBuilder()
///                 .setRed(red / denominator)
///                 .setGreen(green / denominator)
///                 .setBlue(blue / denominator);
///         int alpha = color.getAlpha();
///         if (alpha != 255) {
///           result.setAlpha(
///               FloatValue
///                   .newBuilder()
///                   .setValue(((float) alpha) / denominator)
///                   .build());
///         }
///         return resultBuilder.build();
///       }
///       // ...
///
///  Example (iOS / Obj-C):
///
///       // ...
///       static UIColor* fromProto(Color* protocolor) {
///          float red = [protocolor red];
///          float green = [protocolor green];
///          float blue = [protocolor blue];
///          FloatValue* alpha_wrapper = [protocolor alpha];
///          float alpha = 1.0;
///          if (alpha_wrapper != nil) {
///            alpha = [alpha_wrapper value];
///          }
///          return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
///       }
///
///       static Color* toProto(UIColor* color) {
///           CGFloat red, green, blue, alpha;
///           if (![color getRed:&red green:&green blue:&blue alpha:&alpha]) {
///             return nil;
///           }
///           Color* result = [[Color alloc] init];
///           [result setRed:red];
///           [result setGreen:green];
///           [result setBlue:blue];
///           if (alpha <= 0.9999) {
///             [result setAlpha:floatWrapperWithValue(alpha)];
///           }
///           [result autorelease];
///           return result;
///      }
///      // ...
///
///   Example (JavaScript):
///
///      // ...
///
///      var protoToCssColor = function(rgb_color) {
///         var redFrac = rgb_color.red || 0.0;
///         var greenFrac = rgb_color.green || 0.0;
///         var blueFrac = rgb_color.blue || 0.0;
///         var red = Math.floor(redFrac * 255);
///         var green = Math.floor(greenFrac * 255);
///         var blue = Math.floor(blueFrac * 255);
///
///         if (!('alpha' in rgb_color)) {
///            return rgbToCssColor(red, green, blue);
///         }
///
///         var alphaFrac = rgb_color.alpha.value || 0.0;
///         var rgbParams = [red, green, blue].join(',');
///         return ['rgba(', rgbParams, ',', alphaFrac, ')'].join('');
///      };
///
///      var rgbToCssColor = function(red, green, blue) {
///        var rgbNumber = new Number((red << 16) | (green << 8) | blue);
///        var hexString = rgbNumber.toString(16);
///        var missingZeros = 6 - hexString.length;
///        var resultBuilder = ['#'];
///        for (var i = 0; i < missingZeros; i++) {
///           resultBuilder.push('0');
///        }
///        resultBuilder.push(hexString);
///        return resultBuilder.join('');
///      };
///
///      // ...
class Color extends $pb.GeneratedMessage {
  factory Color({
    $core.double? red,
    $core.double? green,
    $core.double? blue,
    $73.FloatValue? alpha,
  }) {
    final $result = create();
    if (red != null) {
      $result.red = red;
    }
    if (green != null) {
      $result.green = green;
    }
    if (blue != null) {
      $result.blue = blue;
    }
    if (alpha != null) {
      $result.alpha = alpha;
    }
    return $result;
  }
  Color._() : super();
  factory Color.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Color.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Color',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'google.type'),
      createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'red', $pb.PbFieldType.OF)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'green', $pb.PbFieldType.OF)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'blue', $pb.PbFieldType.OF)
    ..aOM<$73.FloatValue>(4, _omitFieldNames ? '' : 'alpha',
        subBuilder: $73.FloatValue.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Color clone() => Color()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Color copyWith(void Function(Color) updates) =>
      super.copyWith((message) => updates(message as Color)) as Color;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Color create() => Color._();
  Color createEmptyInstance() => create();
  static $pb.PbList<Color> createRepeated() => $pb.PbList<Color>();
  @$core.pragma('dart2js:noInline')
  static Color getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Color>(create);
  static Color? _defaultInstance;

  /// The amount of red in the color as a value in the interval [0, 1].
  @$pb.TagNumber(1)
  $core.double get red => $_getN(0);
  @$pb.TagNumber(1)
  set red($core.double v) {
    $_setFloat(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasRed() => $_has(0);
  @$pb.TagNumber(1)
  void clearRed() => clearField(1);

  /// The amount of green in the color as a value in the interval [0, 1].
  @$pb.TagNumber(2)
  $core.double get green => $_getN(1);
  @$pb.TagNumber(2)
  set green($core.double v) {
    $_setFloat(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasGreen() => $_has(1);
  @$pb.TagNumber(2)
  void clearGreen() => clearField(2);

  /// The amount of blue in the color as a value in the interval [0, 1].
  @$pb.TagNumber(3)
  $core.double get blue => $_getN(2);
  @$pb.TagNumber(3)
  set blue($core.double v) {
    $_setFloat(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasBlue() => $_has(2);
  @$pb.TagNumber(3)
  void clearBlue() => clearField(3);

  ///  The fraction of this color that should be applied to the pixel. That is,
  ///  the final pixel color is defined by the equation:
  ///
  ///    `pixel color = alpha * (this color) + (1.0 - alpha) * (background color)`
  ///
  ///  This means that a value of 1.0 corresponds to a solid color, whereas
  ///  a value of 0.0 corresponds to a completely transparent color. This
  ///  uses a wrapper message rather than a simple float scalar so that it is
  ///  possible to distinguish between a default value and the value being unset.
  ///  If omitted, this color object is rendered as a solid color
  ///  (as if the alpha value had been explicitly given a value of 1.0).
  @$pb.TagNumber(4)
  $73.FloatValue get alpha => $_getN(3);
  @$pb.TagNumber(4)
  set alpha($73.FloatValue v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasAlpha() => $_has(3);
  @$pb.TagNumber(4)
  void clearAlpha() => clearField(4);
  @$pb.TagNumber(4)
  $73.FloatValue ensureAlpha() => $_ensure(3);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
