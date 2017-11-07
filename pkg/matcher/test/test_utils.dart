// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

void shouldFail(value, Matcher matcher, expected) {
  var failed = false;
  try {
    expect(value, matcher);
  } on TestFailure catch (err) {
    failed = true;

    var _errorString = err.message;

    if (expected is String) {
      expect(_errorString, equalsIgnoringWhitespace(expected));
    } else {
      expect(_errorString.replaceAll('\n', ''), expected);
    }
  }

  expect(failed, isTrue, reason: 'Expected to fail.');
}

void shouldPass(value, Matcher matcher) {
  expect(value, matcher);
}

doesNotThrow() {}
doesThrow() {
  throw 'X';
}

class Widget {
  int price;
}

class HasPrice extends CustomMatcher {
  HasPrice(matcher) : super("Widget with a price that is", "price", matcher);
  featureValueOf(actual) => actual.price;
}

class SimpleIterable extends Iterable<int> {
  final int count;

  SimpleIterable(this.count);

  Iterator<int> get iterator => new _SimpleIterator(count);
}

class _SimpleIterator implements Iterator<int> {
  int _count;
  int _current;

  _SimpleIterator(this._count);

  bool moveNext() {
    if (_count > 0) {
      _current = _count;
      _count--;
      return true;
    }
    _current = null;
    return false;
  }

  int get current => _current;
}
