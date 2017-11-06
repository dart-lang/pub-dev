// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:stack_trace/stack_trace.dart';

import 'description.dart';
import 'interfaces.dart';
import 'util.dart';

/// Returns a matcher that matches the isEmpty property.
const Matcher isEmpty = const _Empty();

class _Empty extends Matcher {
  const _Empty();

  bool matches(item, Map matchState) => item.isEmpty;

  Description describe(Description description) => description.add('empty');
}

/// Returns a matcher that matches the isNotEmpty property.
const Matcher isNotEmpty = const _NotEmpty();

class _NotEmpty extends Matcher {
  const _NotEmpty();

  bool matches(item, Map matchState) => item.isNotEmpty;

  Description describe(Description description) => description.add('non-empty');
}

/// A matcher that matches any null value.
const Matcher isNull = const _IsNull();

/// A matcher that matches any non-null value.
const Matcher isNotNull = const _IsNotNull();

class _IsNull extends Matcher {
  const _IsNull();
  bool matches(item, Map matchState) => item == null;
  Description describe(Description description) => description.add('null');
}

class _IsNotNull extends Matcher {
  const _IsNotNull();
  bool matches(item, Map matchState) => item != null;
  Description describe(Description description) => description.add('not null');
}

/// A matcher that matches the Boolean value true.
const Matcher isTrue = const _IsTrue();

/// A matcher that matches anything except the Boolean value true.
const Matcher isFalse = const _IsFalse();

class _IsTrue extends Matcher {
  const _IsTrue();
  bool matches(item, Map matchState) => item == true;
  Description describe(Description description) => description.add('true');
}

class _IsFalse extends Matcher {
  const _IsFalse();
  bool matches(item, Map matchState) => item == false;
  Description describe(Description description) => description.add('false');
}

/// A matcher that matches the numeric value NaN.
const Matcher isNaN = const _IsNaN();

/// A matcher that matches any non-NaN value.
const Matcher isNotNaN = const _IsNotNaN();

class _IsNaN extends Matcher {
  const _IsNaN();
  bool matches(item, Map matchState) => double.NAN.compareTo(item) == 0;
  Description describe(Description description) => description.add('NaN');
}

class _IsNotNaN extends Matcher {
  const _IsNotNaN();
  bool matches(item, Map matchState) => double.NAN.compareTo(item) != 0;
  Description describe(Description description) => description.add('not NaN');
}

/// Returns a matches that matches if the value is the same instance
/// as [expected], using [identical].
Matcher same(expected) => new _IsSameAs(expected);

class _IsSameAs extends Matcher {
  final _expected;
  const _IsSameAs(this._expected);
  bool matches(item, Map matchState) => identical(item, _expected);
  // If all types were hashable we could show a hash here.
  Description describe(Description description) =>
      description.add('same instance as ').addDescriptionOf(_expected);
}

/// Returns a matcher that matches if the value is structurally equal to
/// [expected].
///
/// If [expected] is a [Matcher], then it matches using that. Otherwise it tests
/// for equality using `==` on the expected value.
///
/// For [Iterable]s and [Map]s, this will recursively match the elements. To
/// handle cyclic structures a recursion depth [limit] can be provided. The
/// default limit is 100. [Set]s will be compared order-independently.
Matcher equals(expected, [int limit = 100]) => expected is String
    ? new _StringEqualsMatcher(expected)
    : new _DeepMatcher(expected, limit);

typedef _RecursiveMatcher = List<String> Function(
    dynamic, dynamic, String, int);

class _DeepMatcher extends Matcher {
  final _expected;
  final int _limit;

  _DeepMatcher(this._expected, [int limit = 1000]) : this._limit = limit;

  // Returns a pair (reason, location)
  List<String> _compareIterables(Iterable expected, Object actual,
      _RecursiveMatcher matcher, int depth, String location) {
    if (actual is Iterable) {
      var expectedIterator = expected.iterator;
      var actualIterator = actual.iterator;
      for (var index = 0;; index++) {
        // Advance in lockstep.
        var expectedNext = expectedIterator.moveNext();
        var actualNext = actualIterator.moveNext();

        // If we reached the end of both, we succeeded.
        if (!expectedNext && !actualNext) return null;

        // Fail if their lengths are different.
        var newLocation = '$location[$index]';
        if (!expectedNext) return ['longer than expected', newLocation];
        if (!actualNext) return ['shorter than expected', newLocation];

        // Match the elements.
        var rp = matcher(expectedIterator.current, actualIterator.current,
            newLocation, depth);
        if (rp != null) return rp;
      }
    } else {
      return ['is not Iterable', location];
    }
  }

  List<String> _compareSets(Set expected, Object actual,
      _RecursiveMatcher matcher, int depth, String location) {
    if (actual is Iterable) {
      Set other = actual.toSet();

      for (var expectedElement in expected) {
        if (other.every((actualElement) =>
            matcher(expectedElement, actualElement, location, depth) != null)) {
          return ['does not contain $expectedElement', location];
        }
      }

      if (other.length > expected.length) {
        return ['larger than expected', location];
      } else if (other.length < expected.length) {
        return ['smaller than expected', location];
      } else {
        return null;
      }
    } else {
      return ['is not Iterable', location];
    }
  }

  List<String> _recursiveMatch(
      Object expected, Object actual, String location, int depth) {
    // If the expected value is a matcher, try to match it.
    if (expected is Matcher) {
      var matchState = {};
      if (expected.matches(actual, matchState)) return null;

      var description = new StringDescription();
      expected.describe(description);
      return ['does not match $description', location];
    } else {
      // Otherwise, test for equality.
      try {
        if (expected == actual) return null;
      } catch (e) {
        // TODO(gram): Add a test for this case.
        return ['== threw "$e"', location];
      }
    }

    if (depth > _limit) return ['recursion depth limit exceeded', location];

    // If _limit is 1 we can only recurse one level into object.
    if (depth == 0 || _limit > 1) {
      if (expected is Set) {
        return _compareSets(
            expected, actual, _recursiveMatch, depth + 1, location);
      } else if (expected is Iterable) {
        return _compareIterables(
            expected, actual, _recursiveMatch, depth + 1, location);
      } else if (expected is Map) {
        if (actual is! Map) return ['expected a map', location];
        var map = (actual as Map);
        var err =
            (expected.length == map.length) ? '' : 'has different length and ';
        for (var key in expected.keys) {
          if (!map.containsKey(key)) {
            return ["${err}is missing map key '$key'", location];
          }
        }

        for (var key in map.keys) {
          if (!expected.containsKey(key)) {
            return ["${err}has extra map key '$key'", location];
          }
        }

        for (var key in expected.keys) {
          var rp = _recursiveMatch(
              expected[key], map[key], "$location['$key']", depth + 1);
          if (rp != null) return rp;
        }

        return null;
      }
    }

    var description = new StringDescription();

    // If we have recursed, show the expected value too; if not, expect() will
    // show it for us.
    if (depth > 0) {
      description
          .add('was ')
          .addDescriptionOf(actual)
          .add(' instead of ')
          .addDescriptionOf(expected);
      return [description.toString(), location];
    }

    // We're not adding any value to the actual value.
    return ["", location];
  }

  String _match(expected, actual, Map matchState) {
    var rp = _recursiveMatch(expected, actual, '', 0);
    if (rp == null) return null;
    String reason;
    if (rp[0].length > 0) {
      if (rp[1].length > 0) {
        reason = "${rp[0]} at location ${rp[1]}";
      } else {
        reason = rp[0];
      }
    } else {
      reason = '';
    }
    // Cache the failure reason in the matchState.
    addStateInfo(matchState, {'reason': reason});
    return reason;
  }

  bool matches(item, Map matchState) =>
      _match(_expected, item, matchState) == null;

  Description describe(Description description) =>
      description.addDescriptionOf(_expected);

  Description describeMismatch(
      item, Description mismatchDescription, Map matchState, bool verbose) {
    var reason = matchState['reason'] ?? '';
    // If we didn't get a good reason, that would normally be a
    // simple 'is <value>' message. We only add that if the mismatch
    // description is non empty (so we are supplementing the mismatch
    // description).
    if (reason.length == 0 && mismatchDescription.length > 0) {
      mismatchDescription.add('is ').addDescriptionOf(item);
    } else {
      mismatchDescription.add(reason);
    }
    return mismatchDescription;
  }
}

/// A special equality matcher for strings.
class _StringEqualsMatcher extends Matcher {
  final String _value;

  _StringEqualsMatcher(this._value);

  bool get showActualValue => true;

  bool matches(item, Map matchState) => _value == item;

  Description describe(Description description) =>
      description.addDescriptionOf(_value);

  Description describeMismatch(
      item, Description mismatchDescription, Map matchState, bool verbose) {
    if (item is! String) {
      return mismatchDescription.addDescriptionOf(item).add('is not a string');
    } else {
      var buff = new StringBuffer();
      buff.write('is different.');
      var escapedItem = escape(item);
      var escapedValue = escape(_value);
      int minLength = escapedItem.length < escapedValue.length
          ? escapedItem.length
          : escapedValue.length;
      var start = 0;
      for (; start < minLength; start++) {
        if (escapedValue.codeUnitAt(start) != escapedItem.codeUnitAt(start)) {
          break;
        }
      }
      if (start == minLength) {
        if (escapedValue.length < escapedItem.length) {
          buff.write(' Both strings start the same, but the actual value also'
              ' has the following trailing characters: ');
          _writeTrailing(buff, escapedItem, escapedValue.length);
        } else {
          buff.write(' Both strings start the same, but the actual value is'
              ' missing the following trailing characters: ');
          _writeTrailing(buff, escapedValue, escapedItem.length);
        }
      } else {
        buff.write('\nExpected: ');
        _writeLeading(buff, escapedValue, start);
        _writeTrailing(buff, escapedValue, start);
        buff.write('\n  Actual: ');
        _writeLeading(buff, escapedItem, start);
        _writeTrailing(buff, escapedItem, start);
        buff.write('\n          ');
        for (int i = (start > 10 ? 14 : start); i > 0; i--) buff.write(' ');
        buff.write('^\n Differ at offset $start');
      }

      return mismatchDescription.add(buff.toString());
    }
  }

  static void _writeLeading(StringBuffer buff, String s, int start) {
    if (start > 10) {
      buff.write('... ');
      buff.write(s.substring(start - 10, start));
    } else {
      buff.write(s.substring(0, start));
    }
  }

  static void _writeTrailing(StringBuffer buff, String s, int start) {
    if (start + 10 > s.length) {
      buff.write(s.substring(start));
    } else {
      buff.write(s.substring(start, start + 10));
      buff.write(' ...');
    }
  }
}

/// A matcher that matches any value.
const Matcher anything = const _IsAnything();

class _IsAnything extends Matcher {
  const _IsAnything();
  bool matches(item, Map matchState) => true;
  Description describe(Description description) => description.add('anything');
}

/// Returns a matcher that matches if an object is an instance
/// of [T] (or a subtype).
///
/// As types are not first class objects in Dart we can only
/// approximate this test by using a generic wrapper class.
///
/// For example, to test whether 'bar' is an instance of type
/// 'Foo', we would write:
///
///     expect(bar, new isInstanceOf<Foo>());
class isInstanceOf<T> extends Matcher {
  const isInstanceOf();

  bool matches(obj, Map matchState) => obj is T;

  Description describe(Description description) =>
      description.add('an instance of $T');
}

/// A matcher that matches a function call against no exception.
///
/// The function will be called once. Any exceptions will be silently swallowed.
/// The value passed to expect() should be a reference to the function.
/// Note that the function cannot take arguments; to handle this
/// a wrapper will have to be created.
const Matcher returnsNormally = const _ReturnsNormally();

class _ReturnsNormally extends Matcher {
  const _ReturnsNormally();

  bool matches(f, Map matchState) {
    try {
      f();
      return true;
    } catch (e, s) {
      addStateInfo(matchState, {'exception': e, 'stack': s});
      return false;
    }
  }

  Description describe(Description description) =>
      description.add("return normally");

  Description describeMismatch(
      item, Description mismatchDescription, Map matchState, bool verbose) {
    mismatchDescription.add('threw ').addDescriptionOf(matchState['exception']);
    if (verbose) {
      mismatchDescription.add(' at ').add(matchState['stack'].toString());
    }
    return mismatchDescription;
  }
}

/*
 * Matchers for different exception types. Ideally we should just be able to
 * use something like:
 *
 * final Matcher throwsException =
 *     const _Throws(const isInstanceOf<Exception>());
 *
 * Unfortunately instanceOf is not working with dart2js.
 *
 * Alternatively, if static functions could be used in const expressions,
 * we could use:
 *
 * bool _isException(x) => x is Exception;
 * final Matcher isException = const _Predicate(_isException, "Exception");
 * final Matcher throwsException = const _Throws(isException);
 *
 * But currently using static functions in const expressions is not supported.
 * For now the only solution for all platforms seems to be separate classes
 * for each exception type.
 */

abstract class TypeMatcher extends Matcher {
  final String _name;
  const TypeMatcher(this._name);
  Description describe(Description description) => description.add(_name);
}

/// A matcher for Map types.
const Matcher isMap = const _IsMap();

class _IsMap extends TypeMatcher {
  const _IsMap() : super("Map");
  bool matches(item, Map matchState) => item is Map;
}

/// A matcher for List types.
const Matcher isList = const _IsList();

class _IsList extends TypeMatcher {
  const _IsList() : super("List");
  bool matches(item, Map matchState) => item is List;
}

/// Returns a matcher that matches if an object has a length property
/// that matches [matcher].
Matcher hasLength(matcher) => new _HasLength(wrapMatcher(matcher));

class _HasLength extends Matcher {
  final Matcher _matcher;
  const _HasLength([Matcher matcher = null]) : this._matcher = matcher;

  bool matches(item, Map matchState) {
    try {
      // This is harmless code that will throw if no length property
      // but subtle enough that an optimizer shouldn't strip it out.
      if (item.length * item.length >= 0) {
        return _matcher.matches(item.length, matchState);
      }
    } catch (e) {}
    return false;
  }

  Description describe(Description description) =>
      description.add('an object with length of ').addDescriptionOf(_matcher);

  Description describeMismatch(
      item, Description mismatchDescription, Map matchState, bool verbose) {
    try {
      // We want to generate a different description if there is no length
      // property; we use the same trick as in matches().
      if (item.length * item.length >= 0) {
        return mismatchDescription
            .add('has length of ')
            .addDescriptionOf(item.length);
      }
    } catch (e) {}
    return mismatchDescription.add('has no length property');
  }
}

/// Returns a matcher that matches if the match argument contains the expected
/// value.
///
/// For [String]s this means substring matching;
/// for [Map]s it means the map has the key, and for [Iterable]s
/// it means the iterable has a matching element. In the case of iterables,
/// [expected] can itself be a matcher.
Matcher contains(expected) => new _Contains(expected);

class _Contains extends Matcher {
  final _expected;

  const _Contains(this._expected);

  bool matches(item, Map matchState) {
    if (item is String) {
      return item.indexOf(_expected) >= 0;
    } else if (item is Iterable) {
      if (_expected is Matcher) {
        return item.any((e) => _expected.matches(e, matchState));
      } else {
        return item.contains(_expected);
      }
    } else if (item is Map) {
      return item.containsKey(_expected);
    }
    return false;
  }

  Description describe(Description description) =>
      description.add('contains ').addDescriptionOf(_expected);

  Description describeMismatch(
      item, Description mismatchDescription, Map matchState, bool verbose) {
    if (item is String || item is Iterable || item is Map) {
      return super
          .describeMismatch(item, mismatchDescription, matchState, verbose);
    } else {
      return mismatchDescription.add('is not a string, map or iterable');
    }
  }
}

/// Returns a matcher that matches if the match argument is in
/// the expected value. This is the converse of [contains].
Matcher isIn(expected) => new _In(expected);

class _In extends Matcher {
  final _expected;

  const _In(this._expected);

  bool matches(item, Map matchState) {
    if (_expected is String) {
      return _expected.indexOf(item) >= 0;
    } else if (_expected is Iterable) {
      return _expected.any((e) => e == item);
    } else if (_expected is Map) {
      return _expected.containsKey(item);
    }
    return false;
  }

  Description describe(Description description) =>
      description.add('is in ').addDescriptionOf(_expected);
}

/// Returns a matcher that uses an arbitrary function that returns
/// true or false for the actual value.
///
/// For example:
///
///     expect(v, predicate((x) => ((x % 2) == 0), "is even"))
Matcher predicate<T>(bool f(T value),
        [String description = 'satisfies function']) =>
    new _Predicate(f, description);

typedef bool _PredicateFunction<T>(T value);

class _Predicate<T> extends Matcher {
  final _PredicateFunction<T> _matcher;
  final String _description;

  _Predicate(this._matcher, this._description);

  bool matches(item, Map matchState) => _matcher(item as T);

  Description describe(Description description) =>
      description.add(_description);
}

/// A useful utility class for implementing other matchers through inheritance.
/// Derived classes should call the base constructor with a feature name and
/// description, and an instance matcher, and should implement the
/// [featureValueOf] abstract method.
///
/// The feature description will typically describe the item and the feature,
/// while the feature name will just name the feature. For example, we may
/// have a Widget class where each Widget has a price; we could make a
/// [CustomMatcher] that can make assertions about prices with:
///
/// ```dart
/// class HasPrice extends CustomMatcher {
///   HasPrice(matcher) : super("Widget with price that is", "price", matcher);
///   featureValueOf(actual) => actual.price;
/// }
/// ```
///
/// and then use this for example like:
///
/// ```dart
/// expect(inventoryItem, new HasPrice(greaterThan(0)));
/// ```
class CustomMatcher extends Matcher {
  final String _featureDescription;
  final String _featureName;
  final Matcher _matcher;

  CustomMatcher(this._featureDescription, this._featureName, matcher)
      : this._matcher = wrapMatcher(matcher);

  /// Override this to extract the interesting feature.
  featureValueOf(actual) => actual;

  bool matches(item, Map matchState) {
    try {
      var f = featureValueOf(item);
      if (_matcher.matches(f, matchState)) return true;
      addStateInfo(matchState, {'custom.feature': f});
    } catch (exception, stack) {
      addStateInfo(matchState, {
        'custom.exception': exception.toString(),
        'custom.stack': new Chain.forTrace(stack)
            .foldFrames(
                (frame) =>
                    frame.package == 'test' ||
                    frame.package == 'stream_channel' ||
                    frame.package == 'matcher',
                terse: true)
            .toString()
      });
    }
    return false;
  }

  Description describe(Description description) =>
      description.add(_featureDescription).add(' ').addDescriptionOf(_matcher);

  Description describeMismatch(
      item, Description mismatchDescription, Map matchState, bool verbose) {
    if (matchState['custom.exception'] != null) {
      mismatchDescription
          .add('threw ')
          .addDescriptionOf(matchState['custom.exception'])
          .add('\n')
          .add(matchState['custom.stack'].toString());
      return mismatchDescription;
    }

    mismatchDescription
        .add('has ')
        .add(_featureName)
        .add(' with value ')
        .addDescriptionOf(matchState['custom.feature']);
    var innerDescription = new StringDescription();

    _matcher.describeMismatch(matchState['custom.feature'], innerDescription,
        matchState['state'], verbose);

    if (innerDescription.length > 0) {
      mismatchDescription.add(' which ').add(innerDescription.toString());
    }
    return mismatchDescription;
  }
}
