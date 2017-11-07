// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'interfaces.dart';

/// Returns a matcher which matches if the match argument is greater
/// than the given [value].
Matcher greaterThan(value) =>
    new _OrderingMatcher(value, false, false, true, 'a value greater than');

/// Returns a matcher which matches if the match argument is greater
/// than or equal to the given [value].
Matcher greaterThanOrEqualTo(value) => new _OrderingMatcher(
    value, true, false, true, 'a value greater than or equal to');

/// Returns a matcher which matches if the match argument is less
/// than the given [value].
Matcher lessThan(value) =>
    new _OrderingMatcher(value, false, true, false, 'a value less than');

/// Returns a matcher which matches if the match argument is less
/// than or equal to the given [value].
Matcher lessThanOrEqualTo(value) => new _OrderingMatcher(
    value, true, true, false, 'a value less than or equal to');

/// A matcher which matches if the match argument is zero.
const Matcher isZero =
    const _OrderingMatcher(0, true, false, false, 'a value equal to');

/// A matcher which matches if the match argument is non-zero.
const Matcher isNonZero =
    const _OrderingMatcher(0, false, true, true, 'a value not equal to');

/// A matcher which matches if the match argument is positive.
const Matcher isPositive =
    const _OrderingMatcher(0, false, false, true, 'a positive value', false);

/// A matcher which matches if the match argument is zero or negative.
const Matcher isNonPositive =
    const _OrderingMatcher(0, true, true, false, 'a non-positive value', false);

/// A matcher which matches if the match argument is negative.
const Matcher isNegative =
    const _OrderingMatcher(0, false, true, false, 'a negative value', false);

/// A matcher which matches if the match argument is zero or positive.
const Matcher isNonNegative =
    const _OrderingMatcher(0, true, false, true, 'a non-negative value', false);

// TODO(kevmoo) Note that matchers that use _OrderingComparison only use
// `==` and `<` operators to evaluate the match. Or change the matcher.
class _OrderingMatcher extends Matcher {
  /// Expected value.
  final _value;

  /// What to return if actual == expected
  final bool _equalValue;

  /// What to return if actual < expected
  final bool _lessThanValue;

  /// What to return if actual > expected
  final bool _greaterThanValue;

  /// Textual name of the inequality
  final String _comparisonDescription;

  /// Whether to include the expected value in the description
  final bool _valueInDescription;

  const _OrderingMatcher(this._value, this._equalValue, this._lessThanValue,
      this._greaterThanValue, this._comparisonDescription,
      [bool valueInDescription = true])
      : this._valueInDescription = valueInDescription;

  bool matches(item, Map matchState) {
    if (item == _value) {
      return _equalValue;
    } else if (item < _value) {
      return _lessThanValue;
    } else {
      return _greaterThanValue;
    }
  }

  Description describe(Description description) {
    if (_valueInDescription) {
      return description
          .add(_comparisonDescription)
          .add(' ')
          .addDescriptionOf(_value);
    } else {
      return description.add(_comparisonDescription);
    }
  }

  Description describeMismatch(
      item, Description mismatchDescription, Map matchState, bool verbose) {
    mismatchDescription.add('is not ');
    return describe(mismatchDescription);
  }
}
