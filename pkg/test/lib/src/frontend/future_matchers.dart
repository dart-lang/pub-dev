// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:matcher/matcher.dart';

import '../utils.dart';
import 'async_matcher.dart';
import 'expect.dart';

/// Matches a [Future] that completes successfully with a value.
///
/// Note that this creates an asynchronous expectation. The call to `expect()`
/// that includes this will return immediately and execution will continue.
/// Later, when the future completes, the actual expectation will run.
///
/// To test that a Future completes with an exception, you can use [throws] and
/// [throwsA].
///
/// This returns an [AsyncMatcher], so [expect] won't complete until the matched
/// future does.
final Matcher completes = const _Completes(null);

/// Matches a [Future] that completes succesfully with a value that matches
/// [matcher].
///
/// Note that this creates an asynchronous expectation. The call to
/// `expect()` that includes this will return immediately and execution will
/// continue. Later, when the future completes, the actual expectation will run.
///
/// To test that a Future completes with an exception, you can use [throws] and
/// [throwsA].
///
/// The [description] parameter is deprecated and shouldn't be used.
///
/// This returns an [AsyncMatcher], so [expect] won't complete until the matched
/// future does.
Matcher completion(matcher, [@deprecated String description]) =>
    new _Completes(wrapMatcher(matcher));

class _Completes extends AsyncMatcher {
  final Matcher _matcher;

  const _Completes(this._matcher);

  // Avoid async/await so we synchronously start listening to [item].
  /*FutureOr<String>*/ matchAsync(item) {
    if (item is! Future) return "was not a Future";

    return item.then((value) async {
      if (_matcher == null) return null;

      String result;
      if (_matcher is AsyncMatcher) {
        result = await (_matcher as AsyncMatcher).matchAsync(value);
        if (result == null) return null;
      } else {
        var matchState = {};
        if (_matcher.matches(value, matchState)) return null;
        result = _matcher
            .describeMismatch(value, new StringDescription(), matchState, false)
            .toString();
      }

      var buffer = new StringBuffer();
      buffer.writeln(indent(prettyPrint(value), first: 'emitted '));
      if (result.isNotEmpty) buffer.writeln(indent(result, first: '  which '));
      return buffer.toString().trimRight();
    });
  }

  Description describe(Description description) {
    if (_matcher == null) {
      description.add('completes successfully');
    } else {
      description.add('completes to a value that ').addDescriptionOf(_matcher);
    }
    return description;
  }
}

/// Matches a [Future] that does not complete.
///
/// Note that this creates an asynchronous expectation. The call to
/// `expect()` that includes this will return immediately and execution will
/// continue.
final Matcher doesNotComplete = const _DoesNotComplete(20);

class _DoesNotComplete extends Matcher {
  final int _timesToPump;
  const _DoesNotComplete(this._timesToPump);

  // TODO(grouma) - Make this a top level function
  Future _pumpEventQueue(times) {
    if (times == 0) return new Future.value();
    return new Future(() => _pumpEventQueue(times - 1));
  }

  Description describe(Description description) {
    description.add("does not complete");
    return description;
  }

  @override
  bool matches(item, Map matchState) {
    if (item is! Future) return false;
    item.then((value) {
      fail('Future was not expected to complete but completed with a value of '
          '$value');
    });
    expect(_pumpEventQueue(_timesToPump), completes);
    return true;
  }

  Description describeMismatch(
      item, Description description, Map matchState, bool verbose) {
    if (item is! Future) return description.add("$item is not a Future");
    return description;
  }
}
