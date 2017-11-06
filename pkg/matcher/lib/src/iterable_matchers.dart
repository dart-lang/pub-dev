// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'core_matchers.dart';
import 'description.dart';
import 'interfaces.dart';
import 'util.dart';

/// Returns a matcher which matches [Iterable]s in which all elements
/// match the given [matcher].
Matcher everyElement(matcher) => new _EveryElement(wrapMatcher(matcher));

class _EveryElement extends _IterableMatcher {
  final Matcher _matcher;

  _EveryElement(this._matcher);

  bool matches(item, Map matchState) {
    if (item is! Iterable) {
      return false;
    }
    var i = 0;
    for (var element in item) {
      if (!_matcher.matches(element, matchState)) {
        addStateInfo(matchState, {'index': i, 'element': element});
        return false;
      }
      ++i;
    }
    return true;
  }

  Description describe(Description description) =>
      description.add('every element(').addDescriptionOf(_matcher).add(')');

  Description describeMismatch(
      item, Description mismatchDescription, Map matchState, bool verbose) {
    if (matchState['index'] != null) {
      var index = matchState['index'];
      var element = matchState['element'];
      mismatchDescription
          .add('has value ')
          .addDescriptionOf(element)
          .add(' which ');
      var subDescription = new StringDescription();
      _matcher.describeMismatch(
          element, subDescription, matchState['state'], verbose);
      if (subDescription.length > 0) {
        mismatchDescription.add(subDescription.toString());
      } else {
        mismatchDescription.add("doesn't match ");
        _matcher.describe(mismatchDescription);
      }
      mismatchDescription.add(' at index $index');
      return mismatchDescription;
    }
    return super
        .describeMismatch(item, mismatchDescription, matchState, verbose);
  }
}

/// Returns a matcher which matches [Iterable]s in which at least one
/// element matches the given [matcher].
Matcher anyElement(matcher) => new _AnyElement(wrapMatcher(matcher));

class _AnyElement extends _IterableMatcher {
  final Matcher _matcher;

  _AnyElement(this._matcher);

  bool matches(item, Map matchState) {
    return item.any((e) => _matcher.matches(e, matchState));
  }

  Description describe(Description description) =>
      description.add('some element ').addDescriptionOf(_matcher);
}

/// Returns a matcher which matches [Iterable]s that have the same
/// length and the same elements as [expected], in the same order.
///
/// This is equivalent to [equals] but does not recurse.
Matcher orderedEquals(Iterable expected) => new _OrderedEquals(expected);

class _OrderedEquals extends Matcher {
  final Iterable _expected;
  Matcher _matcher;

  _OrderedEquals(this._expected) {
    _matcher = equals(_expected, 1);
  }

  bool matches(item, Map matchState) =>
      (item is Iterable) && _matcher.matches(item, matchState);

  Description describe(Description description) =>
      description.add('equals ').addDescriptionOf(_expected).add(' ordered');

  Description describeMismatch(
      item, Description mismatchDescription, Map matchState, bool verbose) {
    if (item is! Iterable) {
      return mismatchDescription.add('is not an Iterable');
    } else {
      return _matcher.describeMismatch(
          item, mismatchDescription, matchState, verbose);
    }
  }
}

/// Returns a matcher which matches [Iterable]s that have the same length and
/// the same elements as [expected], but not necessarily in the same order.
///
/// Note that this is O(n^2) so should only be used on small objects.
Matcher unorderedEquals(Iterable expected) => new _UnorderedEquals(expected);

class _UnorderedEquals extends _UnorderedMatches {
  final List _expectedValues;

  _UnorderedEquals(Iterable expected)
      : _expectedValues = expected.toList(),
        super(expected.map(equals));

  Description describe(Description description) => description
      .add('equals ')
      .addDescriptionOf(_expectedValues)
      .add(' unordered');
}

/// Iterable matchers match against [Iterable]s. We add this intermediate
/// class to give better mismatch error messages than the base Matcher class.
abstract class _IterableMatcher extends Matcher {
  const _IterableMatcher();
  Description describeMismatch(
      item, Description mismatchDescription, Map matchState, bool verbose) {
    if (item is! Iterable) {
      return mismatchDescription.addDescriptionOf(item).add(' not an Iterable');
    } else {
      return super
          .describeMismatch(item, mismatchDescription, matchState, verbose);
    }
  }
}

/// Returns a matcher which matches [Iterable]s whose elements match the
/// matchers in [expected], but not necessarily in the same order.
///
///  Note that this is `O(n^2)` and so should only be used on small objects.
Matcher unorderedMatches(Iterable expected) => new _UnorderedMatches(expected);

class _UnorderedMatches extends Matcher {
  final List<Matcher> _expected;

  _UnorderedMatches(Iterable expected)
      : _expected = expected.map(wrapMatcher).toList();

  String _test(item) {
    if (item is Iterable) {
      var list = item.toList();

      // Check the lengths are the same.
      if (_expected.length > list.length) {
        return 'has too few elements (${list.length} < ${_expected.length})';
      } else if (_expected.length < list.length) {
        return 'has too many elements (${list.length} > ${_expected.length})';
      }

      var matched = new List<bool>.filled(list.length, false);
      var expectedPosition = 0;
      for (var expectedMatcher in _expected) {
        var actualPosition = 0;
        var gotMatch = false;
        for (var actualElement in list) {
          if (!matched[actualPosition]) {
            if (expectedMatcher.matches(actualElement, {})) {
              matched[actualPosition] = gotMatch = true;
              break;
            }
          }
          ++actualPosition;
        }

        if (!gotMatch) {
          return new StringDescription()
              .add('has no match for ')
              .addDescriptionOf(expectedMatcher)
              .add(' at index $expectedPosition')
              .toString();
        }

        ++expectedPosition;
      }
      return null;
    } else {
      return 'not iterable';
    }
  }

  bool matches(item, Map mismatchState) => _test(item) == null;

  Description describe(Description description) => description
      .add('matches ')
      .addAll('[', ', ', ']', _expected)
      .add(' unordered');

  Description describeMismatch(item, Description mismatchDescription,
          Map matchState, bool verbose) =>
      mismatchDescription.add(_test(item));
}

/// A pairwise matcher for [Iterable]s.
///
/// The [comparator] function, taking an expected and an actual argument, and
/// returning whether they match, will be applied to each pair in order.
/// [description] should be a meaningful name for the comparator.
Matcher pairwiseCompare<S, T>(
        Iterable<S> expected, bool comparator(S a, T b), String description) =>
    new _PairwiseCompare(expected, comparator, description);

typedef bool _Comparator<S, T>(S a, T b);

class _PairwiseCompare<S, T> extends _IterableMatcher {
  final Iterable<S> _expected;
  final _Comparator<S, T> _comparator;
  final String _description;

  _PairwiseCompare(this._expected, this._comparator, this._description);

  bool matches(item, Map matchState) {
    if (item is Iterable) {
      if (item.length != _expected.length) return false;
      var iterator = item.iterator;
      var i = 0;
      for (var e in _expected) {
        iterator.moveNext();
        if (!_comparator(e, iterator.current)) {
          addStateInfo(matchState,
              {'index': i, 'expected': e, 'actual': iterator.current});
          return false;
        }
        i++;
      }
      return true;
    } else {
      return false;
    }
  }

  Description describe(Description description) =>
      description.add('pairwise $_description ').addDescriptionOf(_expected);

  Description describeMismatch(
      item, Description mismatchDescription, Map matchState, bool verbose) {
    if (item is! Iterable) {
      return mismatchDescription.add('is not an Iterable');
    } else if (item.length != _expected.length) {
      return mismatchDescription
          .add('has length ${item.length} instead of ${_expected.length}');
    } else {
      return mismatchDescription
          .add('has ')
          .addDescriptionOf(matchState["actual"])
          .add(' which is not $_description ')
          .addDescriptionOf(matchState["expected"])
          .add(' at index ${matchState["index"]}');
    }
  }
}

/// Matches [Iterable]s which contain an element matching every value in
/// [expected] in the same order, but may contain additional values interleaved
/// throughout.
///
/// For example: `[0, 1, 0, 2, 0]` matches `containsAllInOrder([1, 2])` but not
/// `containsAllInOrder([2, 1])` or `containsAllInOrder([1, 2, 3])`.
Matcher containsAllInOrder(Iterable expected) =>
    new _ContainsAllInOrder(expected);

class _ContainsAllInOrder implements Matcher {
  final Iterable _expected;

  _ContainsAllInOrder(this._expected);

  String _test(item, Map matchState) {
    if (item is! Iterable) return 'not an iterable';
    var matchers = _expected.map(wrapMatcher).toList();
    var matcherIndex = 0;
    for (var value in item) {
      if (matchers[matcherIndex].matches(value, matchState)) matcherIndex++;
      if (matcherIndex == matchers.length) return null;
    }
    return new StringDescription()
        .add('did not find a value matching ')
        .addDescriptionOf(matchers[matcherIndex])
        .add(' following expected prior values')
        .toString();
  }

  @override
  bool matches(item, Map matchState) => _test(item, matchState) == null;

  @override
  Description describe(Description description) => description
      .add('contains in order(')
      .addDescriptionOf(_expected)
      .add(')');

  @override
  Description describeMismatch(item, Description mismatchDescription,
          Map matchState, bool verbose) =>
      mismatchDescription.add(_test(item, matchState));
}
