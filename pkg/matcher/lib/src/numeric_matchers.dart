// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'interfaces.dart';

/// Returns a matcher which matches if the match argument is within [delta]
/// of some [value].
///
/// In other words, this matches if the match argument is greater than
/// than or equal [value]-[delta] and less than or equal to [value]+[delta].
Matcher closeTo(num value, num delta) => new _IsCloseTo(value, delta);

class _IsCloseTo extends Matcher {
  final num _value, _delta;

  const _IsCloseTo(this._value, this._delta);

  bool matches(item, Map matchState) {
    if (item is num) {
      var diff = item - _value;
      if (diff < 0) diff = -diff;
      return (diff <= _delta);
    } else {
      return false;
    }
  }

  Description describe(Description description) => description
      .add('a numeric value within ')
      .addDescriptionOf(_delta)
      .add(' of ')
      .addDescriptionOf(_value);

  Description describeMismatch(
      item, Description mismatchDescription, Map matchState, bool verbose) {
    if (item is num) {
      var diff = item - _value;
      if (diff < 0) diff = -diff;
      return mismatchDescription.add(' differs by ').addDescriptionOf(diff);
    } else {
      return mismatchDescription.add(' not numeric');
    }
  }
}

/// Returns a matcher which matches if the match argument is greater
/// than or equal to [low] and less than or equal to [high].
Matcher inInclusiveRange(num low, num high) =>
    new _InRange(low, high, true, true);

/// Returns a matcher which matches if the match argument is greater
/// than [low] and less than [high].
Matcher inExclusiveRange(num low, num high) =>
    new _InRange(low, high, false, false);

/// Returns a matcher which matches if the match argument is greater
/// than [low] and less than or equal to [high].
Matcher inOpenClosedRange(num low, num high) =>
    new _InRange(low, high, false, true);

/// Returns a matcher which matches if the match argument is greater
/// than or equal to a [low] and less than [high].
Matcher inClosedOpenRange(num low, num high) =>
    new _InRange(low, high, true, false);

class _InRange extends Matcher {
  final num _low, _high;
  final bool _lowMatchValue, _highMatchValue;

  const _InRange(
      this._low, this._high, this._lowMatchValue, this._highMatchValue);

  bool matches(value, Map matchState) {
    if (value is num) {
      if (value < _low || value > _high) {
        return false;
      }
      if (value == _low) {
        return _lowMatchValue;
      }
      if (value == _high) {
        return _highMatchValue;
      }
      return true;
    } else {
      return false;
    }
  }

  Description describe(Description description) =>
      description.add("be in range from "
          "$_low (${_lowMatchValue ? 'inclusive' : 'exclusive'}) to "
          "$_high (${_highMatchValue ? 'inclusive' : 'exclusive'})");

  Description describeMismatch(
      item, Description mismatchDescription, Map matchState, bool verbose) {
    if (item is! num) {
      return mismatchDescription.addDescriptionOf(item).add(' not numeric');
    } else {
      return super
          .describeMismatch(item, mismatchDescription, matchState, verbose);
    }
  }
}
