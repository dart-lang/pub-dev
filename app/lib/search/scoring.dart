// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math' as math;

import 'package:meta/meta.dart' as meta;

const double _popularityWeight = 0.5;
const double _healthWeight = 0.3;
const double _maintenanceWeight = 0.2;

/// Calculates the overall score for a package.
double calculateOverallScore({
  @meta.required double popularity,
  @meta.required double health,
  @meta.required double maintenance,
}) {
  assert(popularity != null && popularity >= 0.0 && popularity <= 1.0);
  assert(health != null && health >= 0.0 && health <= 1.0);
  assert(maintenance != null && maintenance >= 0.0 && maintenance <= 1.0);

  return popularity * _popularityWeight +
      health * _healthWeight +
      maintenance * _maintenanceWeight;
}

class Summary {
  final num max;
  final num min;
  final num mean;

  Summary._(this.max, this.min, this.mean) {
    assert(max >= mean);
    assert(mean >= min);
  }

  factory Summary(Iterable<num> numbers) {
    var total = 0.0;
    num max, min;

    var count = 0;
    for (var i in numbers) {
      //TODO(kevmoo): validate i for Nan/Infinity
      count++;
      total += i;

      max = math.max(i, max ?? i);
      min = math.min(i, min ?? i);
    }

    if (count == 0) {
      throw ArgumentError('`numbers` cannot be empty.');
    }

    return Summary._(max, min, total / count);
  }

  double simpleScore(num value) {
    if (value < min || value > max) {
      throw RangeError("Value '$value' must be >= '$min' and <= '$max'.");
    }

    final scale = max - min;
    assert(scale >= 0);
    if (scale < epsilon) {
      // when the range is this close, call everything a 0.5
      return 0.5;
    }

    return (value - min) / scale;
  }

  double bezierScore(num value) =>
      calculateBezierScore(simpleScore(value), simpleScore(mean));

  @override
  String toString() => [max, mean, min].join(', ');
}

const epsilon = 1e-8;

/// Calculates the score according to a bezier curbe, with the
/// following points: (0,0), (normValue, 0.75), (normValue, 0.75) and (1, 1)
///
/// Mirrors work in npms.io – with great appreciation.
/// github.com/npms-io/npms-analyzer/blob/7832c17f/lib/scoring/score.js#L156
double calculateBezierScore(num normValue, num normAvg) {
  if (normValue < 0 || normValue > 1) {
    throw RangeError.range(normValue, 0, 1, 'normValue');
  }

  if (normAvg < 0 || normAvg > 1) {
    throw RangeError.range(normAvg, 0, 1, 'normAvg');
  }

  final avgY = 0.75;
  final t = solveCubicSpecial(-3 * normAvg, 3 * normAvg, -1 * normValue);

  final t2 = (math.pow(t, 3) - (3 * avgY * math.pow(t, 2)) + (3 * t * avgY))
      .toDouble();

  if (t2 <= epsilon) {
    return 0.0;
  }

  if (t2 >= (1 - epsilon)) {
    return 1.0;
  }

  return t2;
}

/// Special case of [solveCubic] which supports only code paths needed by
/// [calculateBezierScore].
///
/// Inspired by https://stackoverflow.com/a/27176424/39827
double solveCubicSpecial(num b, num c, num d) {
  // Convert to depressed cubic t^3+pt+q = 0 (subst x = t - b/3a)
  final p = (3 * c - b * b) / 3;
  final q = (2 * b * b * b - 9 * b * c + 27 * d) / 27;

  double root;

  assert(p.abs() >= epsilon);

  if (q.abs() < epsilon) {
    assert(p >= 0);
    root = 0.0;
  } else {
    final D = q * q / 4 + p * p * p / 27;
    assert(D.abs() >= epsilon);
    assert(D > 0);
    final u = cubeRoot(-q / 2 - math.sqrt(D));
    root = u - p / (3 * u);
  }

  root -= b / 3;

  return root;
}

// Inspired by https://stackoverflow.com/a/27176424/39827
// **Deprecated**
// ("Kept here for completeness. Use `solveCubicSpecial` for scoring.")
List<num> solveCubic(num a, num b, num c, num d) {
  if (a.abs() < epsilon) {
    // Quadratic case, ax^2+bx+c=0
    a = b;
    b = c;
    c = d;
    if (a.abs() < epsilon) {
      // Linear case, ax+b=0
      a = b;
      b = c;
      if (a.abs() < epsilon) {
        // Degenerate case
        return [];
      }
      return [-b / a];
    }

    final D = b * b - 4 * a * c;
    if (D.abs() < epsilon) {
      return [-b / (2 * a)];
    } else if (D > 0) {
      return [(-b + math.sqrt(D)) / (2 * a), (-b - math.sqrt(D)) / (2 * a)];
    }
    return [];
  }

  // Convert to depressed cubic t^3+pt+q = 0 (subst x = t - b/3a)
  final p = (3 * a * c - b * b) / (3 * a * a);
  final q = (2 * b * b * b - 9 * a * b * c + 27 * a * a * d) / (27 * a * a * a);
  List<num> roots;

  if (p.abs() < epsilon) {
    // p = 0 -> t^3 = -q -> t = -q^1/3
    roots = [cubeRoot(-q)];
  } else if (q.abs() < epsilon) {
    // q = 0 -> t^3 + pt = 0 -> t(t^2+p)=0
    roots = <num>[
      0,
      if (p < 0) ...[math.sqrt(-p), -math.sqrt(-p)]
    ];
  } else {
    final D = q * q / 4 + p * p * p / 27;
    if (D.abs() < epsilon) {
      // D = 0 -> two roots
      roots = [-1.5 * q / p, 3 * q / p];
    } else if (D > 0) {
      // Only one real root
      final u = cubeRoot(-q / 2 - math.sqrt(D));
      roots = [u - p / (3 * u)];
    } else {
      // D < 0, three roots, but needs to use complex numbers/trigonometric solution
      final u = 2 * math.sqrt(-p / 3);
      final t = math.acos(3 * q / p / u) /
          3; // D < 0 implies p < 0 and acos argument in [-1..1]
      final k = 2 * math.pi / 3;
      roots = [u * math.cos(t), u * math.cos(t - k), u * math.cos(t - 2 * k)];
    }
  }

  // Convert back from depressed cubic
  for (var i = 0; i < roots.length; i++) {
    roots[i] -= b / (3 * a);
  }

  return roots;
}

double cubeRoot(num x) {
  final y = math.pow(x.abs(), 1 / 3);
  return x < 0 ? -y.toDouble() : y.toDouble();
}
