// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Represents an RGBA color code.
class Color {
  static const black = Color(0, 0, 0);
  static const blue = Color(0, 0, 255);
  static const green = Color(0, 255, 0);
  static const peach = Color(255, 229, 180);
  static const red = Color(255, 0, 0);
  static const silver = Color(192, 192, 192);
  static const slateGray = Color(112, 128, 144);
  static const white = Color(255, 255, 255);

  final int r;
  final int g;
  final int b;
  final double a;

  const Color(this.r, this.g, this.b, [this.a = 1.0]);

  Color change({int r, int g, int b, double a}) =>
      Color(r ?? this.r, g ?? this.g, b ?? this.b, a ?? this.a);

  Color interpolateTo(Color to, double value) {
    final red = ((to.r - r) * value).round() + r;
    final green = ((to.g - g) * value).round() + g;
    final blue = ((to.b - b) * value).round() + b;
    final alpha = ((to.a - a) * value) + a;
    return Color(red, green, blue, alpha);
  }

  Color multipleValues(double value) {
    return change(
      r: (r * value).round(),
      g: (g * value).round(),
      b: (b * value).round(),
    );
  }

  @override
  String toString() => a == 1.0
      ? 'rgb($r, $g, $b)'
      : 'rgba($r, $g, $b, ${a.toStringAsFixed(4)})';
}

/// Represents the selection of colors that will be used to draw a specific shape.
class Brush {
  final Color background;
  final Color color;
  final Color shadow;

  const Brush({this.background, this.color, this.shadow});

  Brush interpolateTo(Brush to, double value) {
    return Brush(
      background: background.interpolateTo(to.background, value),
      color: color.interpolateTo(to.color, value),
      shadow: shadow.interpolateTo(to.shadow, value),
    );
  }

  Brush change({Color background, Color color, Color shadow}) {
    return Brush(
        background: background ?? this.background,
        color: color ?? this.color,
        shadow: shadow ?? this.shadow);
  }
}

/// A semi-transparent black for using as a non-intrusive shadow.
final _blackShadow = Color.black.change(a: 0.5);

/// Color to use when the analysis/score is missing (skipped or not done yet).
final _scoreBoxMissing = Color(204, 204, 204);

/// Color to use when the analysis result was top of the range (70+).
final _scoreBoxSolid = Color(1, 117, 194);

/// Color to use when the analysis result was in the middle of the range (40-70)
final _scoreBoxGood = Color(0, 196, 179);

/// Color to use when the analysis result was in the lower range (0-40)
final _scoreBoxRotten = Color(187, 36, 0);

/// The default set of colors to use.
final _defaultBrush = Brush(
    background: _scoreBoxMissing, color: Color.white, shadow: _blackShadow);

/// Get the [Brush] that will be used to render the overall score progress bar.
Brush overallScoreBrush(double score) {
  if (score == null) {
    return _defaultBrush;
  }
  if (score <= 0.4) {
    return _defaultBrush.change(background: _scoreBoxRotten);
  }
  if (score <= 0.7) {
    return _defaultBrush.change(background: _scoreBoxGood);
  }
  return _defaultBrush.change(background: _scoreBoxSolid);
}

/// Get the [Brush] that will be used to render the generic score progress bars
/// (e.g. popularity or health score).
Brush genericScoreBrush(double score) {
  if (score == null) {
    return _defaultBrush;
  }
  final bg = Color.slateGray.interpolateTo(Color.silver, score);
  return _defaultBrush.change(background: bg);
}
