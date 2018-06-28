// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class Color {
  static const black = const Color(0, 0, 0);
  static const blue = const Color(0, 0, 255);
  static const green = const Color(0, 255, 0);
  static const peach = const Color(255, 229, 180);
  static const red = const Color(255, 0, 0);
  static const silver = const Color(192, 192, 192);
  static const slateGray = const Color(112, 128, 144);
  static const white = const Color(255, 255, 255);

  final int r;
  final int g;
  final int b;
  final double a;

  const Color(this.r, this.g, this.b, [this.a = 1.0]);

  Color change({int r, int g, int b, double a}) =>
      new Color(r ?? this.r, g ?? this.g, b ?? this.b, a ?? this.a);

  Color interpolateTo(Color to, double value) {
    final red = ((to.r - r) * value).round() + r;
    final green = ((to.g - g) * value).round() + g;
    final blue = ((to.b - b) * value).round() + b;
    final alpha = ((to.a - a) * value) + a;
    return new Color(red, green, blue, alpha);
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

class Brush {
  final Color background;
  final Color color;
  final Color shadow;

  const Brush({this.background, this.color, this.shadow});

  Brush interpolateTo(Brush to, double value) {
    return new Brush(
      background: background.interpolateTo(to.background, value),
      color: color.interpolateTo(to.color, value),
      shadow: shadow.interpolateTo(to.shadow, value),
    );
  }

  Brush change({Color background, Color color, Color shadow}) {
    return new Brush(
        background: background ?? this.background,
        color: color ?? this.color,
        shadow: shadow ?? this.shadow);
  }
}

final _blackShadow = Color.black.change(a: 0.5);
final _scoreBoxMissing = new Color(204, 204, 204);
final _scoreBoxSolid = new Color(1, 117, 194);
final _scoreBoxGood = new Color(0, 196, 179);
final _scoreBoxRotten = new Color(187, 36, 0);

final _defaultBrush = new Brush(
    background: _scoreBoxMissing, color: Color.white, shadow: _blackShadow);

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

Brush genericScoreBrush(double score) {
  if (score == null) {
    return _defaultBrush;
  }
  final bg = Color.slateGray.interpolateTo(Color.silver, score);
  return _defaultBrush.change(background: bg);
}
